import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar.dart';
import 'package:mongbi_app/presentation/history/widgets/calendar_drop_down_button.dart';
import 'package:mongbi_app/presentation/history/widgets/history_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final double horizontalPadding = 24;
  final historyKey = GlobalKey();
  late Offset historyPosition;
  late EdgeInsets devicePaddig;
  late double appBarHeight;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
              child: Text('모몽의 꿈 기록'),
            ),
          ),
        ),
      ),
      body: AnimatedContainer(
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: horizontalPadding,
                ),
                child: Column(
                  children: [
                    CalendarDropDownButton(),
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
  }

  void onScroll() {
    final historyContext = historyKey.currentContext;
    if (historyContext != null) {
      final box = historyContext.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final devicePadding = MediaQuery.of(context).padding;
      final appBarHeight = AppBar().preferredSize.height;
      final triggerHeight = appBarHeight + devicePadding.top;
      final nextValue = triggerHeight >= position.dy;

      if (isActive != nextValue) {
        setState(() {
          isActive = nextValue;
        });
      }
    }
  }
}
