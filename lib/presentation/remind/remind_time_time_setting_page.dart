import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_button_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';

class RemindTimePickerPage extends StatefulWidget {
  const RemindTimePickerPage({super.key});

  @override
  State<RemindTimePickerPage> createState() => _RemindTimePickerPageState();
}

class _RemindTimePickerPageState extends State<RemindTimePickerPage> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            onPressed: () => Navigator.pop(context),
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
              const SizedBox(height: 24),
              const OnboardingText(
                text: '몽비와 함께할 시간을 알려줘!',
                type: RemindTimeSettingTextType.title,
              ),
              const SizedBox(height: 8),
              const OnboardingText(
                text: '원하는 리마인드 시간을\n설정해주세요.',
                type: RemindTimeSettingTextType.description,
                align: TextAlign.center,
              ),
              const SizedBox(height: 36),
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  initialDateTime: DateTime(
                    2025,
                    1,
                    1,
                    selectedTime.hour,
                    selectedTime.minute,
                  ),
                  onDateTimeChanged: (newTime) {
                    setState(() {
                      selectedTime = TimeOfDay.fromDateTime(newTime);
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '나중에 다시 설정할 수 있어요',
                style: Font.subTitle14.copyWith(
                  color: Color(0xFFA6A1AA)
                ),
              ),
              const Spacer(),
              RemindTimeSettingButtonWidget(
                onTap: () {
                  // 저장 또는 다음 화면 이동 로직
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
