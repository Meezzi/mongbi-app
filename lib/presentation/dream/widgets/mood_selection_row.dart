import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class MoodSelectionRow extends ConsumerWidget {
  const MoodSelectionRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dreamWriteViewModelProvider);

    final iconNames = [
      'assets/icons/very_bad.svg',
      'assets/icons/bad.svg',
      'assets/icons/ordinary.svg',
      'assets/icons/good.svg',
      'assets/icons/very_good.svg',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            ref
                .read(dreamWriteViewModelProvider.notifier)
                .setSelectedIndex(index);
          },
          child: Opacity(
            opacity: state.selectedIndex == index ? 1.0 : 0.2,
            child: SvgPicture.asset(iconNames[index], width: 50, height: 50),
          ),
        );
      }),
    );
  }
}
