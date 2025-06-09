import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/history/widgets/history_item.dart';

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key, required this.horizontalPadding});

  final double horizontalPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(top: horizontalPadding),
      padding: EdgeInsets.all(horizontalPadding),
      decoration: BoxDecoration(
        color: Color(0xFF3B136B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2025년 06월 02일 월요일',
            style: Font.subTitle14.copyWith(color: Colors.white),
          ),
          SizedBox(height: horizontalPadding),
          HistoryItem(),
          HistoryItem(),
        ],
      ),
    );
  }
}
