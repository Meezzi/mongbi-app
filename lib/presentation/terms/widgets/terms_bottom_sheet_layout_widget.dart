import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_button_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_checkbox_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_text_widget.dart';

class TermsBottomSheet extends StatefulWidget {
  const TermsBottomSheet({super.key});

  @override
  State<TermsBottomSheet> createState() => _TermsBottomSheetState();
}

class _TermsBottomSheetState extends State<TermsBottomSheet> {
  bool isAllChecked = false;
  List<bool> isCheckedList = [false, false, false, false];

  void toggleAllAgree(bool value) {
    setState(() {
      isAllChecked = value;
      isCheckedList = List.filled(isCheckedList.length, value);
    });
  }

  void toggleSingle(int index, bool value) {
    setState(() {
      isCheckedList[index] = value;
      isAllChecked = isCheckedList.every((e) => e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isEssentialChecked = isCheckedList[0] && isCheckedList[1];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TermsHeaderText(),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA), // ← 전체 동의 배경색
              borderRadius: BorderRadius.circular(24),
            ),
            child: TermsAgreementTile(
              title: '약관 전체 동의',
              isAllAgree: true,
              isChecked: isAllChecked,
              onChanged: toggleAllAgree,
            ),
          ),
          TermsAgreementTile(
            title: '서비스 이용 약관 동의',
            isRequired: true,
            isChecked: isCheckedList[0],
            onChanged: (val) => toggleSingle(0, val),
          ),
          TermsAgreementTile(
            title: '개인정보 수집 및 이용 동의',
            isRequired: true,
            isChecked: isCheckedList[1],
            onChanged: (val) => toggleSingle(1, val),
          ),
          TermsAgreementTile(
            title: '마케팅 및 이벤트성 알림 동의',
            isChecked: isCheckedList[2],
            onChanged: (val) => toggleSingle(2, val),
          ),
          const SizedBox(height: 24),
          ConfirmButton(
            isEnabled: isEssentialChecked,
            onPressed: () {
              // 필수 항목 체크 완료 후 처리
            },
          ),
        ],
      ),
    );
  }
}
