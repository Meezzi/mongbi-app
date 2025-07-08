import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/widgets/measure_size.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({
    super.key,
    this.nextItemKey,
    required this.label,
    required this.content,
    this.tagList,
    this.isChallenge = false,
    this.challengeType = '',
    this.challengeStatus = '',
    required this.controller,
  });

  final GlobalKey? nextItemKey;
  final String label;
  final String content;
  final List<String>? tagList;
  final bool isChallenge;
  final String challengeType;
  final String challengeStatus;
  final ScrollController controller;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  bool isExpansion = false;
  List<String> iconPath = [
    'assets/icons/chevron-up.svg',
    'assets/icons/chevron-down.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onStop: () {
        if (isExpansion) {
          if (widget.nextItemKey != null &&
              widget.nextItemKey?.currentContext != null) {
            Scrollable.ensureVisible(
              widget.nextItemKey!.currentContext!,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: 1.0, // 0.0 = 위쪽에 맞춤, 1.0 = 아래쪽
            );
          } else {
            Scrollable.ensureVisible(
              context,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: 1.0, // 0.0 = 위쪽에 맞춤, 1.0 = 아래쪽
            );
          }
        }
      },
      child: Card(
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
            onExpansionChanged: (value) {
              setState(() {
                isExpansion = value;
              });
            },
            tilePadding: EdgeInsets.symmetric(horizontal: 24),
            dense: true,
            title: Row(
              children: [
                Text(
                  widget.label,
                  style: Font.title16.copyWith(color: Color(0xFF4D198C)),
                ),
                SizedBox(width: 4),
                if (widget.isChallenge && widget.challengeStatus == 'COMPLETED')
                  circleTag(
                    borderColor: Color(0xFFCDF4ED),
                    bgColor: Color(0xFFEFFCF9),
                    text: Text(
                      '완료',
                      style: Font.subTitle12.copyWith(color: Color(0xFF56C9B4)),
                    ),
                  ),
              ],
            ),
            trailing: SvgPicture.asset(
              isExpansion ? iconPath[0] : iconPath[1],
              colorFilter: ColorFilter.mode(Color(0xff4D198C), BlendMode.srcIn),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isChallenge)
                      circleTag(
                        borderColor: Color(0xFFB273FF),
                        bgColor: Color(0xFFF4EAFF),
                        text: Text(
                          widget.challengeType,
                          style: Font.subTitle12.copyWith(
                            color: Color(0xFF7F2AE8),
                          ),
                        ),
                      ),
                    if (widget.isChallenge) SizedBox(height: 8),
                    Text(
                      widget.content,
                      style: Font.body14.copyWith(color: Color(0xFF1A181B)),
                    ),
                    if (widget.tagList != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 16),
                        child: WrapSuper(
                          wrapType: WrapType.fit,
                          spacing: 8,
                          lineSpacing: 8,
                          children: [
                            if (widget.tagList != null)
                              ...widget.tagList!.map((item) => tag(item)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
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

  Widget circleTag({
    required Color borderColor,
    required Color bgColor,
    required Text text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(999),
        color: bgColor,
      ),
      child: text,
    );
  }
}
