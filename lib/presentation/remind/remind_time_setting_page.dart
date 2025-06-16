import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_button_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_image_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';

class RemindTimeSettingPage extends StatelessWidget {
  const RemindTimeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () => context.go('/home'),
            splashRadius: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        toolbarHeight: 56,
        titleSpacing: 0,
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
              RemindTimeSettingButtonWidget(
                onTap: () async {
                  final notificationService = NotificationService();
                  final granted = await notificationService.requestNotificationPermission();
                  if (granted) {
                    context.go('/remindtime_time_setting');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('알림 권한을 허용해야 다음 단계로 진행할 수 있어요.'),
                      ),
                    );
                  }
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
