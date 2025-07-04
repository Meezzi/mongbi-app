import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class DreamSectionCard extends StatelessWidget {
  const DreamSectionCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.content,
    required this.keywords,
  });

  final String title;
  final String subTitle;
  final String content;
  final List<String> keywords;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Font.title18),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle, style: Font.subTitle16),
              SizedBox(height: 16),
              Text(
                content,
                style: Font.body14.copyWith(color: Color(0xFF1A181B)),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 34,
                child: ListView.separated(
                  itemCount: keywords.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder:
                      (context, index) => Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xF5F5F4F5),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '#${keywords[index]}',
                          style: Font.body12.copyWith(color: Color(0xFF57525B)),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
