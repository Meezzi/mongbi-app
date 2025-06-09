import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/text_widgets.dart'; // 이걸로 수정

class SocialLoginPage extends StatelessWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: '반가워몽!', type: TextType.title),
            CustomText(text: '몽비랑 같이 꿈보러갈래?', type: TextType.title),
            SizedBox(height: 28),
            MongbiCharacter(size: 288),
            SizedBox(height: 62),
            CustomText(text: '간편 로그인', type: TextType.login_info),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
