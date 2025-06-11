import 'package:flutter/material.dart';

class TermsAgreementTile extends StatelessWidget {
  final String title;
  final bool isRequired;
  final bool isAllAgree;

  const TermsAgreementTile({
    super.key,
    required this.title,
    this.isRequired = false,
    this.isAllAgree = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: true, // 상태 관리 필요
        onChanged: (_) {},
      ),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          if (isRequired)
            const Text(
              ' (필수)',
              style: TextStyle(color: Colors.deepPurple),
            )
          else if (!isAllAgree)
            const Text(
              ' (선택)',
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
      trailing: !isAllAgree
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : null,
      onTap: () {
        // 상세보기 페이지로 이동
      },
    );
  }
}
