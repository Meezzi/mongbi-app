import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.label,
    required this.content,
    this.tagList,
  });

  final String label;
  final String content;
  final List<String>? tagList;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      color: Color(0xFFF4EAFF),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24),
          dense: true,
          title: Row(
            children: [
              Text(
                label,
                style: Font.title16.copyWith(color: Color(0xFF4D198C)),
              ),
              SizedBox(width: 4),
              // TODO : 몽비의 한마디의 상태를 받아와야 함 => 아직 필드에 없는 듯
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Color(0xFFCDF4ED)),
              //     borderRadius: BorderRadius.circular(999),
              //     color: Color(0xFFEFFCF9),
              //   ),
              //   child: Text(
              //     '완료',
              //     style: Font.subTitle12.copyWith(color: Color(0xFF56C9B4)),
              //   ),
              // ),
            ],
          ),
          trailing: SvgPicture.asset(
            'assets/icons/chevron-down.svg',
            colorFilter: ColorFilter.mode(Color(0xff4D198C), BlendMode.srcIn),
          ),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: Font.body14.copyWith(color: Color(0xFF1A181B)),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16),
                    child: WrapSuper(
                      wrapType: WrapType.fit,
                      spacing: 8,
                      lineSpacing: 8,
                      children: [
                        if (tagList != null)
                          ...tagList!.map((item) => tag(item)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xF5F5F4F5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '#$text',
        style: Font.body12.copyWith(color: Color(0xFF57525B)),
      ),
    );
  }
}
