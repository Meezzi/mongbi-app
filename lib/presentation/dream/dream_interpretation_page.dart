import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/dream/widgets/custom_button.dart';
import 'package:mongbi_app/presentation/dream/widgets/dream_section_card.dart';
import 'package:mongbi_app/presentation/dream/widgets/mongbi_comment_card.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamInterpretationPage extends ConsumerStatefulWidget {
  const DreamInterpretationPage({super.key});

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
                  onSubmit: () async {
                    final navigator = GoRouter.of(context);
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    try {
                      final isSuccess =
                          await ref
                              .read(
                                dreamInterpretationViewModelProvider.notifier,
                              )
                              .saveDream();

                      if (isSuccess) {
                        // TODO: 홈 화면으로 이동
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('꿈 저장에 실패했어요. 다시 시도해 주세요.'),
                          ),
                        );
                      }
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('오류가 발생했어요: $e')),
                      );
                    }
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
