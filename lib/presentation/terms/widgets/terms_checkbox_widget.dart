import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/domain/entities/terms.dart';
import 'package:mongbi_app/presentation/terms/terms_inner_page.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_custom_checkbox.widget.dart';

class TermsAgreementTile extends StatelessWidget {
  const TermsAgreementTile({
    super.key,
    required this.term,
    this.isAllAgree = false,
    required this.isChecked,
    this.isRequired = false,
    required this.onChanged,
  });
  final Terms term;
  final bool isAllAgree;
  final bool isChecked;
  final bool isRequired;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final title = term.name;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!isChecked),
      child: Padding(
        padding:
            isAllAgree
                ? const EdgeInsets.fromLTRB(24, 14, 24, 12)
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          isAllAgree
                              ? Font.title16.copyWith(
                                color: const Color(0xFF1A181B),
                              )
                              : Font.body16.copyWith(
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
                        builder: (_) => TermsDetailPage(termsList: [term]),
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
