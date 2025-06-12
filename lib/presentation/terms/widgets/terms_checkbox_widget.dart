import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/presentation/terms/terms_inner_page.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_custom_checkbox.widget.dart';

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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!isChecked),
      child: Padding(
        padding:
            isAllAgree
                ? const EdgeInsets.fromLTRB(
                  24,
                  14,
                  24,
                  12,
                )
                : const EdgeInsets.fromLTRB(24, 24, 24, 6), 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckbox(
              isChecked: isChecked,
              onTap: () => onChanged(!isChecked),
            ),
            const SizedBox(width: 4),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          isAllAgree
                              ? Font.title16.copyWith(
                                fontSize: getResponsiveRatioByWidth(
                                  context,
                                  16,
                                ),
                                color: const Color(0xFF1A181B),
                              )
                              : Font.body16.copyWith(
                                fontSize: getResponsiveRatioByWidth(
                                  context,
                                  16,
                                ),
                                color: const Color(0xFF1A181B),
                              ),
                    ),
                  ),
                  if (!isAllAgree)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        isRequired ? ' (필수)' : ' (선택)',
                        style: TextStyle(
                          color:
                              isRequired
                                  ? const Color(0xFF8C2EFF)
                                  : const Color(0xFF1A181B),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (!isAllAgree)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsDetailPage(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/chevron_right.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
