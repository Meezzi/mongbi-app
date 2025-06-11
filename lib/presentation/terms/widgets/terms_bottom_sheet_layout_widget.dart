import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_button_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_checkbox_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_text_widget.dart';

class TermsBottomSheet extends StatelessWidget {
  const TermsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TermsHeaderText(),
          const SizedBox(height: 20),
          const TermsAgreementTile(
            title: '약관 전체 동의',
            isRequired: false,
            isAllAgree: true,
          ),
          const Divider(),
          const TermsAgreementTile(
            title: '서비스 이용 약관 동의',
            isRequired: true,
          ),
          const TermsAgreementTile(
            title: '개인정보 수집 및 이용 동의',
            isRequired: true,
          ),
          const TermsAgreementTile(
            title: '마케팅 및 이벤트성 알림 동의',
            isRequired: false,
          ),
          const TermsAgreementTile(
            title: '심야 시간 알림 동의',
            isRequired: false,
          ),
          const SizedBox(height: 24),
          const ConfirmButton(),
        ],
      ),
    );
  }
}
