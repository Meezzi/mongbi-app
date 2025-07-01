import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/challenge_dead_line_manager.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';
import 'package:mongbi_app/presentation/common/touch_scale_widget.dart';
import 'package:mongbi_app/presentation/home/widgets/challenge_card.dart';
import 'package:mongbi_app/presentation/home/widgets/mongbi_constants.dart';
import 'package:mongbi_app/presentation/home/widgets/speech_bubble.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String selectedMessage;
  late String selectedMongbiImage;
  final DeadlineManager _deadlineManager = DeadlineManager();
  bool _shouldShowChallenge = true;

  @override
  void initState() {
    super.initState();
    selectedMessage = (List.of(mongbiMessages)..shuffle()).first;
    selectedMongbiImage = (List.of(mongbiImages)..shuffle()).first;

    _deadlineManager.checkInitialDeadlineStatus();
    _shouldShowChallenge = !_deadlineManager.isDeadlinePassed;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homeViewModelProvider.notifier).fetchActiveChallenge();

      if (!_deadlineManager.isDeadlinePassed) {
        _deadlineManager.setupTimer(_onDeadlineReached);
      }
    });

    FirebaseAnalytics.instance.logEvent(
      name: 'home_viewed',
      parameters: {'screen': 'HomePage'},
    );

    FirebaseAnalytics.instance.logEvent(
      name: 'message_shown',
      parameters: {'message': selectedMessage},
    );
  }

  @override
  void dispose() {
    _deadlineManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final challengeState = ref.watch(homeViewModelProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_background.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/home_cloude.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Image.asset(
              'assets/images/home_star.webp',
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingAnimationWidget(
                  child: Column(
                    children: [
                      CustomSpeechBubble(text: selectedMessage),
                      TouchScaleWidget(
                        onTap: _changeMongbiImage,
                        child: Image.asset(
                          selectedMongbiImage,
                          width: screenHeight * 0.32,
                          height: screenHeight * 0.32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (challengeState.challenge != null && _shouldShowChallenge)
            Positioned(bottom: 24, left: 24, right: 24, child: ChallengeCard()),
        ],
      ),
    );
  }

  void _changeMongbiImage() {
    setState(() {
      selectedMongbiImage = (List.of(mongbiImages)..shuffle()).first;
      selectedMessage = (List.of(mongbiMessages)..shuffle()).first;
    });

    // 터치 이벤트 로깅
    FirebaseAnalytics.instance.logEvent(
      name: 'mongbi_touched',
      parameters: {
        'new_image': selectedMongbiImage,
        'new_message': selectedMessage,
      },
    );
  }

  void _onDeadlineReached() {
    if (mounted) {
      setState(() {
        _shouldShowChallenge = false;
      });

      _showDeadlineReachedMessage();
    }
  }

  void _showDeadlineReachedMessage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(customSnackBar('앗, 오늘 선물 받을 수 있는 시간이 끝났다몽!', 30, 3));
  }
}
