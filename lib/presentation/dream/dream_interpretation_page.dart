import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/dream/widgets/custom_button.dart';
import 'package:mongbi_app/presentation/dream/widgets/dream_section_card.dart';
import 'package:mongbi_app/presentation/dream/widgets/mongbi_comment_card.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamInterpretationPage extends ConsumerWidget {
  const DreamInterpretationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final dream = ref.watch(dreamInterpretationViewModelProvider);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xfffcf6ff),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                DreamSectionCard(
                  title: '꿈을 해석 해보자면',
                  subTitle: dream.dreamSubTitle,
                  content: dream.dreamInterpretation,
                  keywords: dream.dreamKeywords,
                ),
                SizedBox(height: 24),
                DreamSectionCard(
                  title: '심리 상태는',
                  subTitle: dream.psychologicalSubTitle,
                  content: dream.psychologicalStateInterpretation,
                  keywords: dream.psychologicalStateKeywords,
                ),
                SizedBox(height: 24),
                MongbiCommentCard(
                  title: '몽비의 한마디',
                  comment: dream.mongbiComment,
                ),
                SizedBox(height: 24),
                CustomButton(
                  text: '다음',
                  onSubmit: () {
                    // TODO: 다음 화면으로 이동
                  },
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
