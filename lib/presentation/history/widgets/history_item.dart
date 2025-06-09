import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key});

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
                '몽비의 꿈 해석',
                style: Font.title16.copyWith(color: Color(0xFF4D198C)),
              ),
              SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFCDF4ED)),
                  borderRadius: BorderRadius.circular(999),
                  color: Color(0xFFEFFCF9),
                ),
                child: Text(
                  '완료',
                  style: Font.subTitle12.copyWith(
                    // letterSpacing: 0,
                    color: Color(0xFF56C9B4),
                  ),
                ),
              ),
            ],
          ),
          trailing: SvgPicture.asset('assets/icons/chevron-down.svg'),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    '금빛 용은 전통적으로 힘과 권위, 명예, 행운을 상징하는 멋진 존재야. 특히 용이 하늘을 나는 건 네가 뭔가 크게 도약하려는 열망이 있거나, 새로운 시작을 준비 중이라는 신호야.\n\n머리를 쓰다듬어줬다는 건 누군가의 인정이나 격려를 받고 싶다는 마음이 담겨 있을 수도 있어.\n\n용이 사라진 건 \'좋은 기회가 한순간에 스쳐갈 수 있다\'는 암시이기도 하니까, 눈치 빠르게 기회를 잡으라는 의미도 있어. 전반적으로 좋은 기운이 가득한 꿈이네!',
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
                        tag('금빛 용'),
                        tag('하늘을 나는 모습'),
                        tag('머리를 쓰다듬음'),
                        tag('사라짐'),
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
