import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class RoundedListTileItem extends StatelessWidget {
  const RoundedListTileItem({
    super.key,
    required this.title,
    this.trailing,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
    this.enableInkWell = true,
  });

  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;
  final bool enableInkWell;

  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadius;

    if (isFirst && isLast) {
      borderRadius = BorderRadius.circular(24);
    } else if (isFirst) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      );
    } else if (isLast) {
      borderRadius = BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      );
    }

    Widget content = Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Font.body16.copyWith(color: Color(0xFF1A181B)),
            ),
          ),
          trailing ??
              SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                colorFilter: ColorFilter.mode(
                  Color(0xFFA6A1AA),
                  BlendMode.srcIn,
                ),
              ),
        ],
      ),
    );

    if (enableInkWell) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: content,
        ),
      );
    } else {
      return GestureDetector(onTap: onTap, child: content);
    }
  }
}
