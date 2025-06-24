import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_image_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';

class RemindTimeSettingPage extends StatelessWidget {
  const RemindTimeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ 진입 시 로그
    FirebaseAnalytics.instance.logEvent(
      name: 'remind_intro_viewed',
      parameters: {'screen': 'RemindTimeSettingPage'},
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            width: 24,
            height: 24,
          ),
          onPressed: () => context.go('/home'),
          splashRadius: 20,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        toolbarHeight: 56,
        titleSpacing: 24,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const OnboardingText(
                text: '몽비가 알림을 보내줄까몽?',
                type: RemindTimeSettingTextType.title,
              ),
              const OnboardingText(
                text: '매일 몽비와 함께 할 수 있도록',
                type: RemindTimeSettingTextType.description,
              ),
              const OnboardingText(
                text: '알림을 보내드릴게요.',
                type: RemindTimeSettingTextType.description,
              ),
              const SizedBox(height: 48),
              const RemindTimeSettingImageWidget(
                assetPath: 'assets/images/remind_bell.webp',
              ),
              const Spacer(),
              FilledButtonWidget(
                type: ButtonType.primary,
                text: '알겠어',
                onPress: () async {
                  // ✅ 알림 수락 클릭 로그
                  await FirebaseAnalytics.instance.logEvent(
                    name: 'remind_intro_confirmed',
                    parameters: {'screen': 'RemindTimeSettingPage'},
                  );

                  context.go('/remindtime_time_setting');
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
