import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class NicknameTextField extends StatefulWidget {
  final void Function(String) onChanged;
  const NicknameTextField({super.key, required this.onChanged});

  @override
  State<NicknameTextField> createState() => _NicknameTextFieldState();
}

class _NicknameTextFieldState extends State<NicknameTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool isError = false;

  bool _isValidKorean(String text) {
    final koreanRegExp = RegExp(r'^[가-힣]{2,10}$');
    return koreanRegExp.hasMatch(text);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(() {
      final text = _controller.text;
      widget.onChanged(text);

      setState(() {
        isError = text.isNotEmpty && !_isValidKorean(text);
      });
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
    final backgroundColor =
        isError
            ? const Color(0xFFFDEDEE) // 수정된 에러 배경색
            : const Color(0xFFF4EAFF); // 기본 보라색 배경

    final textColor =
        isError
            ? Colors
                .black // 에러 시 글자색 검정 (가독성 위해)
            : const Color(0xFF1A181B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.only(left: 24, right: 8),
          alignment: Alignment.center,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLength: 5,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: InputBorder.none,
              hintText: '사용할 별명을 적어주세요',
              counterText: '',
              hintStyle: Font.title16.copyWith(
                color: isError ? Colors.black38 : const Color(0xFFA6A1AA),
              ),
              suffixIcon:
                  _controller.text.isNotEmpty
                      ? IconButton(
                        onPressed: () {
                          _controller.clear();
                          widget.onChanged('');
                        },
                        icon:
                            isError
                                ? SvgPicture.asset('assets/icons/error.svg')
                                : SvgPicture.asset('assets/icons/cancel.svg'),
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                      )
                      : null,
            ),
            style: Font.title16.copyWith(color: textColor),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                opacity: isError ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  '한글 2자 이상 입력해주세요.',
                  style: Font.subTitle16.copyWith(
                    color: const Color(0xFFEA4D57),
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
