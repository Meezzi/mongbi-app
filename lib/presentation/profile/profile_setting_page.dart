import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/profile/widgets/nickname_submit_button.dart';
import 'package:mongbi_app/presentation/profile/widgets/nickname_text_field.dart';
import 'package:mongbi_app/presentation/profile/widgets/nickname_title.dart';

class NicknameInputPage extends StatefulWidget {
  const NicknameInputPage({super.key});

  @override
  State<NicknameInputPage> createState() => _NicknameInputPageState();
}

class _NicknameInputPageState extends State<NicknameInputPage> {
  final TextEditingController _controller = TextEditingController();
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = nickname.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 84, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const NicknameTitle(),
            const SizedBox(height: 32),
            NicknameTextField(
              controller: _controller,
              onChanged: (value) => setState(() => nickname = value),
              nickname: nickname,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${nickname.length}/10',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const Spacer(),
            NicknameSubmitButton(
              enabled: isButtonEnabled,
              onTap: () {
                if (isButtonEnabled) {
                  // 제출 처리
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
