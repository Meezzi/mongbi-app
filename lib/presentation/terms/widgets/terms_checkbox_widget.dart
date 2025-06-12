import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class TermsAgreementTile extends StatelessWidget {
  final String title;
  final bool isRequired;
  final bool isAllAgree;

  const TermsAgreementTile({
    super.key,
    required this.title,
    this.isRequired = false,
    this.isAllAgree = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0.5, // ← 기본값은 16.0, 줄이면 간격도 좁아짐
      leading: Checkbox(
        value: true, // 상태 관리 필요
        onChanged: (_) {},
      ),
      title: Row(
        children: [
          Text(
            title,
            style:
                isAllAgree
                    ? Font.title16.copyWith(
                      fontSize: getResponsiveRatioByWidth(context, 16),
                      color: const Color(0xFF1A181B),
                    ) // 전체 동의일 때
                    : Font.body16.copyWith(
                      fontSize: getResponsiveRatioByWidth(context, 16),
                      color: const Color(0xFF1A181B),
                    ), // 나머지
          ),
          if (!isAllAgree)
            if (isRequired)
              const Text(' (필수)', style: TextStyle(color: Color(0xFF8C2EFF)))
            else
              const Text(' (선택)', style: TextStyle(color:  Color(0xFF1A181B))),
        ],
      ),

      trailing:
          !isAllAgree
              ? const Icon(Icons.chevron_right, color: Colors.grey)
              : null,
      onTap: () {
        // 상세보기 페이지로 이동
      },
    );
  }
}
