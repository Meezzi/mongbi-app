import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/history/history_key/history_key.dart';
import 'package:mongbi_app/presentation/history/widgets/history_notice.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  ConsumerState<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  double? expandPaddingValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final deviceSize = MediaQuery.of(context).size;
      final devicePadding = MediaQuery.of(context).padding;
      final appBarHeight = getWidgetInfo(appBarKey)?.size.height ?? 0;
      final naviHeight = getWidgetInfo(naviKey)?.size.height ?? 0;
      final calendarHeight = getWidgetInfo(calendarKey)?.size.height ?? 0;
      final noticeHeight = getWidgetInfo(noticeKey)?.size.height ?? 0;

      setState(() {
        expandPaddingValue =
            deviceSize.height -
            devicePadding.top -
            appBarHeight -
            naviHeight -
            calendarHeight -
            noticeHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarViewModelProvider);

    return Container(
      key: noticeKey,
      padding:
          calendarState.searchedHistory.isEmpty
              ? EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding,
                vertical: 40,
              )
              : EdgeInsets.all(widget.horizontalPadding),
      decoration: BoxDecoration(
        color: Color(0xFF3B136B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: HistoryNotice(
        calendarState: calendarState,
        expandPaddingValue: expandPaddingValue ?? 0,
        horizontalPadding: widget.horizontalPadding,
      ),
    );
  }
}
