import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/dream/widgets/dream_content_input.dart';
import 'package:mongbi_app/presentation/dream/widgets/mood_selection_row.dart';
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
    final state = ref.watch(dreamWriteViewModelProvider);

    // 버튼 활성화 조건
    final isButtonEnabled =
        state.dreamContent.trim().length >= 10 && state.selectedIndex != -1;

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
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(),
                      FilledButtonWidget(
                        type: ButtonType.primary,
                        text: '내가 꾼 꿈이야',
                        onPress:
                            isButtonEnabled
                                ? () {
                                  context.pushReplacement(
                                    '/dream_analysis_loading',
                                  );
                                }
                                : null,
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
