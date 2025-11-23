import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/licenses.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceLicensePage extends StatelessWidget {
  const OpenSourceLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(child: Text('오픈소스 라이선스', style: Font.title20)),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: ListView.builder(
          itemCount: openSourceLicenses.length,
          itemBuilder: (context, index) {
            final item = openSourceLicenses[index];
            return ListTile(
              title: Text(item['name'] ?? ''),
              subtitle: Text(item['license'] ?? ''),
              onTap: () {
                final uri = Uri.parse(item['url'] ?? '');
                launchUrl(uri);
              },
            );
          },
        ),
      ),
    );
  }
}
