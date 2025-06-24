import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/alarm/models/alarm_model.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';

class AlarmType extends ConsumerStatefulWidget {
  const AlarmType({super.key});

  @override
  ConsumerState<AlarmType> createState() => _AlarmTypeState();
}

class _AlarmTypeState extends ConsumerState<AlarmType> {
  final alarmTypeList = const ['전체', '리마인드', '진행 중인 선물', '주간 꿈 리포트'];
  int seletedIndex = 0;
  final ScrollController scrollController = ScrollController();
  final List<GlobalKey> alarmTypeKeyList = List.generate(4, (_) => GlobalKey());

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          ...List.generate(alarmTypeList.length, (index) {
            final typeLabel = alarmTypeList[index];
            final isLast = alarmTypeList.length - 1 == index;
            final isActive = seletedIndex == index;
            return GestureDetector(
              key: alarmTypeKeyList[index],
              onTap: () {
                final alarmVm = ref.read(alarmViewModelProvider.notifier);
                FilterType? type;

                setState(() {
                  seletedIndex = index;
                });

                switch (index) {
                  case 0:
                    type = FilterType.all;
                    break;
                  case 1:
                    type = FilterType.remind;
                    break;
                  case 2:
                    type = FilterType.challenge;
                    break;
                  case 3:
                    type = FilterType.report;
                    break;
                }

                alarmVm.filterAlarmList(type!);

                scrollToIndex(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7,
                ),
                margin: EdgeInsets.only(right: isLast ? 0 : 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE6E4E7)),
                  borderRadius: BorderRadius.circular(999),
                  color: isActive ? Color(0xFF8C2EFF) : null,
                ),
                child: Text(
                  typeLabel,
                  style: Font.body14.copyWith(
                    color: isActive ? Colors.white : Color(0xFF76717A),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void scrollToIndex(int index) {
    double offset = 0;
    for (int i = 0; i < index; i++) {
      final keyContext = alarmTypeKeyList[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        offset += box.size.width;
      }
    }
    final min = 0.0;
    // 스크롤이 가능한 최대값을 반환
    final max = scrollController.position.maxScrollExtent;
    // offset을 clamp의 범위로 제한
    final target = offset.clamp(min, max);
    scrollController.animateTo(
      target,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
