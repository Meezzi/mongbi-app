import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';
import 'package:mongbi_app/presentation/dream/widgets/custom_button.dart';
import 'package:mongbi_app/presentation/dream/widgets/dream_section_card.dart';
import 'package:mongbi_app/presentation/dream/widgets/mongbi_comment_card.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamInterpretationPage extends ConsumerStatefulWidget {
  const DreamInterpretationPage({super.key, required this.isFirst});

  final bool isFirst;

  @override
  ConsumerState<DreamInterpretationPage> createState() =>
      _DreamInterpretationPageState();
}

class _DreamInterpretationPageState
    extends ConsumerState<DreamInterpretationPage> {
  @override
  Widget build(BuildContext context) {
    final dream = ref.watch(dreamInterpretationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘 꿈은 말이야...', style: Font.title20),
        titleSpacing: 24,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFFFCF6FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                DreamSectionCard(
                  title: '꿈을 해석 해보자면',
                  subTitle: dream.dreamSubTitle,
                  content: dream.dreamInterpretation,
                  keywords: dream.dreamKeywords,
                ),
                SizedBox(height: 32),
                DreamSectionCard(
                  title: '따라서 너의 심리는',
                  subTitle: dream.psychologicalSubTitle,
                  content: dream.psychologicalStateInterpretation,
                  keywords: dream.psychologicalStateKeywords,
                ),
                SizedBox(height: 32),
                MongbiCommentCard(
                  title: '몽비의 한마디',
                  comment: dream.mongbiComment,
                ),
                SizedBox(height: 40),

                if (widget.isFirst) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ActionButtonRow(
                      leftText: '음... 아닌데?',
                      rightText: '오 맞아!',
                      onLeftPressed: () {
                        context.pushReplacement('/dream_write?isFirst=false');
                      },
                      onRightPressed:
                          () => context.pushReplacement('/challenge_intro'),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomButton(
                      text: '고마워',
                      onSubmit:
                          () => context.pushReplacement('/challenge_intro'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message, style: Font.body14)));
  }
}
