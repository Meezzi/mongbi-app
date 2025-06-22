import 'package:flutter/widgets.dart';
import 'package:mongbi_app/core/font.dart';

class ChallengeContainer extends StatelessWidget {
  const ChallengeContainer({
    super.key,
    required this.title,
    required this.content,
    required this.containerColor,
    this.rotationAngle = 0.0,
    this.isSelected = false,
  });

  final String title;
  final String content;
  final Color containerColor;
  final double rotationAngle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedScale(
      scale: isSelected ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(rotationAngle),
        child: Container(
          width: screenHeight * 0.23,
          height: screenHeight * 0.23,
          decoration: ShapeDecoration(
            color: containerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x331A181B),
                blurRadius: 10,
                offset: Offset(2, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: ShapeDecoration(
                    color: Color(0xFFE8F9F7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF64D4C7)),
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                    ),
                  ),
                  child: Text(
                    title,
                    style: Font.subTitle12.copyWith(color: Color(0xFF15AE9C)),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: Font.title14.copyWith(color: Color(0xFF28272A)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
