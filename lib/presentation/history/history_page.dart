import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/history/history_key/history_key.dart';
import 'package:mongbi_app/presentation/history/widgets/history_app_bar.dart';
import 'package:mongbi_app/presentation/history/widgets/history_body.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});
  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final double horizontalPadding = 24;
  final ScrollController scrollController = ScrollController();

  late final Size deviceSize;
  late final EdgeInsets devicePadding;
  late final double appBarHeight;
  late bool isActive = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      deviceSize = MediaQuery.of(context).size;
      devicePadding = MediaQuery.of(context).padding;
      appBarHeight = AppBar().preferredSize.height;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyViewModelProvider);
    final calendarState = ref.watch(calendarViewModelProvider);

    return Scaffold(
      appBar: PreferredSize(
        key: appBarKey,
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HistoryAppBar(
          isActive: isActive,
          horizontalPadding: horizontalPadding,
        ),
      ),
      body: historyAsync.when(
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        data: (data) {
          return HistoryBody(
            isActive: isActive,
            onScroll: onScroll,
            calendarState: calendarState,
            horizontalPadding: horizontalPadding,
            scrollController: scrollController,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('예기치 못한 오류가 발생했습니다.'));
        },
      ),
    );
  }

  void onScroll() {
    final box = getWidgetInfo(historyKey);
    final position = box!.localToGlobal(Offset.zero);
    final triggerHeight = appBarHeight + devicePadding.top;
    final nextValue = triggerHeight >= position.dy;

    if (isActive != nextValue) {
      setState(() {
        isActive = nextValue;
      });
    }
  }
}
