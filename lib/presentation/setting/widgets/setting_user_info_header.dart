import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    super.key,
    required this.nickname,
    required this.loginType,
    required this.onTap,
  });

  final String nickname;
  final String loginType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$nickname 님',
            style: Font.title20.copyWith(color: Color(0xFF6321B5)),
          ),
          SizedBox(width: 8),
          Text(
            '$loginType 로그인',
            style: Font.subTitle12.copyWith(color: Color(0xFFCA9FFF)),
          ),
          Spacer(),
          SvgPicture.asset(
            'assets/icons/chevron-right.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Color(0xFFA6A1AA), BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
