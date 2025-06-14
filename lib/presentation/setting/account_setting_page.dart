import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('계정 설정', style: Font.title20),
        backgroundColor: Color(0xFFFAFAFA),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: 사용자의 이메일과 로그인 타입
                Text('계정 정보', style: Font.body16),
                SizedBox(height: 16),
                Text('mongbi2025@mongbi.com', style: Font.body16),
                Text(
                  '카카오로 가입한 계정이에요',
                  style: Font.body12.copyWith(color: Color(0xFF76717A)),
                ),
              ],
            ),
          ),

          Divider(height: 8, thickness: 8, color: Color(0xFFF3F2F4)),
          RoundedListTileItem(
            title: '로그아웃',
            isFirst: false,
            isLast: false,
            onTap: () {
              // TODO: 로그아웃 로직
            },
          ),
          RoundedListTileItem(
            title: '계정 탈퇴',
            isFirst: false,
            isLast: false,
            onTap: () {
              // TODO: 계정 탈퇴
            },
          ),
        ],
      ),
    );
  }
}
