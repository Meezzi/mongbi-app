import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Font.title14),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D7F2AE8),
                offset: Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
