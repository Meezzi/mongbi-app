import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_custom_checkbox.widget.dart'; // 커스텀 체크박스 임포트

class TermsAgreementTile extends StatelessWidget {
  final String title;
  final bool isRequired;
  final bool isAllAgree;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const TermsAgreementTile({
    super.key,
    required this.title,
    this.isRequired = false,
    this.isAllAgree = false,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 12,
      leading: CustomCheckbox(
        isChecked: isChecked,
        onTap: () => onChanged(!isChecked),
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
                    )
                    : Font.body16.copyWith(
                      fontSize: getResponsiveRatioByWidth(context, 16),
                      color: const Color(0xFF1A181B),
                    ),
          ),
          if (!isAllAgree)
            if (isRequired)
              const Text(' (필수)', style: TextStyle(color: Color(0xFF8C2EFF)))
            else
              const Text(' (선택)', style: TextStyle(color: Color(0xFF1A181B))),
        ],
      ),
      trailing:
          !isAllAgree
              ? GestureDetector(
                onTap: () {
                },
                child: SvgPicture.asset(
                  'assets/icons/chevron_right.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              )
              : null,

      onTap: () => onChanged(!isChecked),
    );
  }
}
