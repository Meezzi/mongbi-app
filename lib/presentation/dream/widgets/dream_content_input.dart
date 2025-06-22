import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamContentInput extends ConsumerWidget {
  const DreamContentInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dreamWriteViewModelProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFF4EAFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        focusNode: focusNode,
        minLines: 9,
        maxLines: null,
        maxLength: 250,
        onChanged: (text) {
          ref.read(dreamWriteViewModelProvider.notifier).setDreamContent(text);
        },
        style: Font.subTitle14,
        decoration: InputDecoration(
          hintText: '오늘 꾼 꿈을 10글자 이상 입력해주몽 :)',
          hintStyle: Font.subTitle14.copyWith(
            color: state.isFocused ? Colors.grey : Color(0xFFB273FF),
          ),
          border: InputBorder.none,
          counter: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${state.dreamContent.length}/250',
              style: Font.subTitle12.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
