import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_item.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_type.dart';
import 'package:mongbi_app/presentation/alarm/widgets/delete_modal.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(child: Text('알림함', style: Font.title20)),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // 배경 터치로 닫히지 않음!
                    barrierColor: Colors.black.withValues(alpha: 0.6),
                    builder: (context) => DeleteModal(),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/trash.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  context.push('/alarm_setting');
                },
                child: SvgPicture.asset(
                  'assets/icons/setting.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              AlarmType(),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AlarmItem(
                      type: '리마인드',
                      date: '2025년 06월 15일',
                      content: '안녕! 오늘은 어떤 꿈을 꿨는지 알려줘몽!' * 4,
                      isConfirmed: index % 2 == 0,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '받은 알림은 30일동안 보관됩니다.',
                  style: Font.subTitle12.copyWith(color: Color(0xFFA6A1AA)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
