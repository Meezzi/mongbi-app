import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/alarm/widgets/delete_modal.dart';

class AlarmAppBar extends StatelessWidget {
  const AlarmAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
