import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        isChecked
            ? 'assets/icons/checkbox_checked.svg'
            : 'assets/icons/checkbox_unchecked.svg',
        width: 24,
        height: 24,
      ),
    );
  }
}
