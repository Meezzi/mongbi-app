import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/presentation/common/floating_animation_widget.dart';
import 'package:mongbi_app/presentation/home/widgets/mongbi_message_list.dart';
import 'package:mongbi_app/presentation/home/widgets/speech_bubble.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedMessage;

  @override
  void initState() {
    super.initState();
    selectedMessage = (List.of(mongbiMessages)..shuffle()).first;
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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                      Image.asset(
                        'assets/images/mongbi.webp',
                        width: screenHeight * 0.32,
                        height: screenHeight * 0.32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
