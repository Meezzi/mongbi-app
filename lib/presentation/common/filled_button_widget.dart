import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    required this.type,
    required this.text,
    required this.onPress,
  });

  final ButtonType type;
  final String text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          onPress != null
              ? BoxShadow(
                color: Color(0x331A181B),
                blurRadius: 10,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
              : BoxShadow(
                color: Color(0x191A181B),
                blurRadius: 10,
                offset: Offset(2, 2),
                spreadRadius: 0,
              ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(Font.title18),
          elevation: WidgetStatePropertyAll(0),
          minimumSize: WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          overlayColor: WidgetStatePropertyAll(
            type == ButtonType.primary
                ? Color.fromRGBO(77, 25, 140, 1)
                : Color.fromRGBO(13, 105, 94, 1),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case ButtonType.primary:
                if (states.contains(WidgetState.disabled)) {
                  return Color.fromRGBO(245, 244, 245, 0.96);
                }

                return Color.fromRGBO(140, 46, 255, 1);

              case ButtonType.secondary:
                if (states.contains(WidgetState.disabled)) {
                  return Color.fromRGBO(245, 244, 245, 0.96);
                }

                return Color.fromRGBO(23, 191, 171, 1);
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Color.fromRGBO(214, 212, 216, 1);
            }

            return Colors.white;
          }),
        ),
        child: Text(text),
      ),
    );
  }
}
