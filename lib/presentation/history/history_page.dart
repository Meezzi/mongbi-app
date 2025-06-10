import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_widget_info.dart';
import 'package:mongbi_app/presentation/history/history_key/history_key.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_change_button.dart';
import 'package:mongbi_app/presentation/history/widgets/history_list.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final double horizontalPadding = 24;

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
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyViewModelProvider);
    final calendarState = ref.watch(calendarViewModelProvider);

    return Scaffold(
      appBar: PreferredSize(
        key: appBarKey,
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: isActive ? Color(0xFF3B136B) : Color(0xffFCF6FF),
          child: AppBar(
            systemOverlayStyle:
                isActive
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            titleSpacing: horizontalPadding,
            title: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: Font.title20.copyWith(
                color: isActive ? Colors.white : Color(0xff1A181B),
              ),
              // TODO : 나중에 사용자 닉네임으로 변경
              child: Text('모몽의 꿈 기록'),
            ),
          ),
        ),
      ),
      body: historyAsync.when(
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        data: (data) {
          return AnimatedContainer(
            height: double.infinity,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                    isActive
                        ? [Color(0xFF3B136B), Color(0xFF3B136B)]
                        : [Color(0xffFDF8FF), Color(0xffEAC9FA)],
              ),
            ),
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  onScroll();
                }
                return false;
              },
              child: SingleChildScrollView(
                physics:
                    calendarState.searchedHistory.isEmpty
                        ? NeverScrollableScrollPhysics()
                        : AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      key: calendarKey,
                      padding: EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        bottom: horizontalPadding,
                      ),
                      child: Column(
                        children: [
                          CalendarChangeButton(),
                          Calendar(horizontalPadding: horizontalPadding),
                        ],
                      ),
                    ),
                    HistoryList(
                      key: historyKey,
                      horizontalPadding: horizontalPadding,
                    ),
                  ],
                ),
              ),
            ),
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
