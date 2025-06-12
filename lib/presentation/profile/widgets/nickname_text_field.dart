import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class NicknameTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String nickname;

  const NicknameTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.nickname,
  });

  @override
  State<NicknameTextField> createState() => _NicknameTextFieldState();
}

class _NicknameTextFieldState extends State<NicknameTextField> {
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
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
            style: Font.title16.copyWith(color: Color(0xFF1A181B)),
            focusNode: _focusNode,
            controller: widget.controller,
            maxLength: 5,
            decoration:  InputDecoration(
              border: InputBorder.none,
              hintText: '사용할 별명을 적어주세요',
              counterText: '',
              hintStyle: Font.title16.copyWith(color: Color(0xFFA6A1AA)),
            ),
            onChanged: widget.onChanged,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: isFocused ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '한글 2자 이상 입력해주세요.',
                  style: Font.subTitle16.copyWith(color: Color(0xFFD6D4D8)),
                ),
                Text(
                  '${widget.nickname.length}/5',
                  style: Font.body14.copyWith(color: Color(0xFF76717A)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
