import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:flutter/services.dart';

class NicknameTextField extends StatefulWidget {
  final void Function(String) onChanged;
  const NicknameTextField({super.key, required this.onChanged});

  @override
  State<NicknameTextField> createState() => _NicknameTextFieldState();
}

class _NicknameTextFieldState extends State<NicknameTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() => isFocused = _focusNode.hasFocus);
    });

    _controller.addListener(() {
      widget.onChanged(_controller.text); // 외부로 전달
      setState(() {}); // 글자 수 업데이트
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color:
                isFocused ? const Color(0xFFF4EAFF) : const Color(0xFFF9F8F8),
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLength: 5,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '사용할 별명을 적어주세요',
              counterText: '',
              hintStyle: Font.title16.copyWith(color: const Color(0xFFA6A1AA)),
            ),
            style: Font.title16.copyWith(color: const Color(0xFF1A181B)),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[가-힣ㄱ-ㅎㅏ-ㅣ]')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                opacity: isFocused ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  '한글 2자 이상 입력해주세요.',
                  style: Font.subTitle16.copyWith(
                    color: const Color(0xFFD6D4D8),
                  ),
                ),
              ),
              Text(
                '${_controller.text.length}/5',
                style: Font.body14.copyWith(color: const Color(0xFF76717A)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
