import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/terms.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_button_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_checkbox_widget.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_text_widget.dart';
import 'package:mongbi_app/providers/terms_provider.dart';

class TermsBottomSheet extends ConsumerStatefulWidget {
  const TermsBottomSheet({super.key});

  @override
  ConsumerState<TermsBottomSheet> createState() => _TermsBottomSheetState();
}

class _TermsBottomSheetState extends ConsumerState<TermsBottomSheet> {
  List<bool> isCheckedList = [];
  bool isAllChecked = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(termsViewModelProvider).fetchTerms();
      final terms = ref.read(termsViewModelProvider).terms;
      setState(() {
        isCheckedList = List.filled(terms.length, false);
      });
    });
  }

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

  String getTypeLabel(String type) {
    switch (type) {
      case 'TERMS_OF_SERVICE':
        return '서비스 이용약관';
      case 'PRIVACY_POLICY':
        return '개인정보 수집 및 이용 약관';
      case 'MARKETING_CONSENT':
        return '마케팅 수신동의';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(termsViewModelProvider);
    final terms = state.terms;

    if (terms.isEmpty || isCheckedList.length != terms.length) {
      return const Center(child: CircularProgressIndicator());
    }

    final mandatoryIndexes = terms
        .asMap()
        .entries
        .where((e) => e.value.requirement == 'MANDATORY') // <- 필수 여부 체크
        .map((e) => e.key)
        .toList();

    final isEssentialChecked = mandatoryIndexes.every((i) => isCheckedList[i]);

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

          // 전체 동의
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TermsAgreementTile(
              term: Terms(id: -1, name: '약관 전체 동의', type: '', requirement: '', content: ''),
              isAllAgree: true,
              isChecked: isAllChecked,
              onChanged: toggleAllAgree,
            ),
          ),

          // 개별 항목 렌더링
          ...terms.asMap().entries.map((entry) {
            final i = entry.key;
            final term = entry.value;
            return TermsAgreementTile(
              term: Terms(
                id: term.id,
                name: getTypeLabel(term.type),
                type: term.type,
                requirement: term.requirement,
                content: term.content,
              ),
              isRequired: term.requirement == 'MANDATORY',
              isChecked: isCheckedList[i],
              onChanged: (val) => toggleSingle(i, val),
            );
          }).toList(),

          const SizedBox(height: 24),

          ConfirmButton(
            isEnabled: isEssentialChecked,
            onPressed: () {
              // 필수 항목 동의 완료 후 처리
            },
          ),
        ],
      ),
    );
  }
}
