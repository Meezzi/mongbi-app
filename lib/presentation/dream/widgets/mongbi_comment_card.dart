import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class MongbiCommentCard extends StatelessWidget {
  const MongbiCommentCard({
    super.key,
    required this.title,
    required this.comment,
  });

  final String title;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Font.title18),
        SizedBox(height: 9),
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            comment,
            style: Font.body14.copyWith(color: Colors.grey[900]),
          ),
        ),
      ],
    );
  }
}
