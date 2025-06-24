import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/domain/entities/terms.dart';

class TermsDetailPage extends StatelessWidget {
  const TermsDetailPage({super.key, required this.termsList});
  final List<Terms> termsList;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'terms_detail_viewed',
      parameters: {
        'terms': termsList.map((t) => t.name).toList(),
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/back-arrow.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            const SizedBox(width: 8),
            Text('서비스 약관', style: Font.title20),
          ],
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                '서비스 약관',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(termsList.map((t) => '• ${t.name}').join('\n')),
              const SizedBox(height: 24),
              ...termsList.map(
                (term) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      term.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Html(data: term.content),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
