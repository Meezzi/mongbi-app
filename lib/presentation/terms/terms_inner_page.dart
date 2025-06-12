import 'package:flutter/material.dart';

class TermsDetailPage extends StatelessWidget {
  const TermsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // 닫기 기능
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 8),
              Text(
                '서비스 약관',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('1. 개인정보처리방침\n2. 이용약관'),
              SizedBox(height: 24),
              Text(
                '개인정보 처리방침',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '(주)피알앤디컴퍼니(이하 "회사")는 통신비밀보호법, ...\n\n'
                '회사의 개인정보처리방침은 다음과 같은 내용을 담고 있습니다.\n\n'
                '1. 수집하는 개인정보의 항목 및 수집방법\n'
                '2. 개인정보의 수집 및 이용목적\n'
                '3. 개인정보의 이용공유 및 제3자 제공\n'
                '...\n'
                '13. 고지의 의무\n\n'
                '1. 수집하는 개인정보의 항목 및 수집방법\n'
                '[이하 내용 생략]',
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
