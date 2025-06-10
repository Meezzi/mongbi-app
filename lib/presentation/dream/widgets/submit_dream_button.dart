import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class SubmitDreamButton extends ConsumerWidget {
  const SubmitDreamButton({super.key, required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dreamWriteViewModelProvider);
    final isButtonEnabled =
        state.dreamContent.trim().length >= 10 && state.selectedIndex != -1;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onSubmit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8C2EFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          '내가 꾼 꿈이야',
          style: Font.title18.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
