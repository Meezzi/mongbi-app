import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/dream/widgets/dream_content_input.dart';
import 'package:mongbi_app/presentation/dream/widgets/mood_selection_row.dart';
import 'package:mongbi_app/presentation/dream/widgets/submit_dream_button.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamWritePage extends ConsumerStatefulWidget {
  const DreamWritePage({super.key});

  @override
  ConsumerState<DreamWritePage> createState() => _DreamWritePageState();
}

class _DreamWritePageState extends ConsumerState<DreamWritePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      ref
          .read(dreamWriteViewModelProvider.notifier)
          .setFocused(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 0,
                backgroundColor: Colors.grey[50],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 꿈 내용 입력 필드
                      Text('오늘 꿈 내용은', style: Font.title18),
                      const SizedBox(height: 8),
                      DreamContentInput(focusNode: _focusNode),
                      const SizedBox(height: 72),

                      // 기분 선택 아이콘 행 위젯
                      Text('꿈을 꾸고 내 기분은', style: Font.title18),
                      const SizedBox(height: 16),
                      const MoodSelectionRow(),
                      SizedBox(
                        height:
                            MediaQuery.of(context).viewInsets.bottom > 0
                                ? 0
                                : MediaQuery.of(context).size.height * 0.2,
                      ),

                      // 제출 버튼 위젯
                      SubmitDreamButton(
                        onSubmit: () {
                          final notifier = ref.read(
                            dreamWriteViewModelProvider.notifier,
                          );
                          final errorMessage = notifier.submitDream();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage as String)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
