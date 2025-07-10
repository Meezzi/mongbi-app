import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class SubscriptionOption {

  SubscriptionOption({
    required this.title,
    this.subtitle,
    required this.price,
    this.subPrice,
  });
  final String title;
  final String? subtitle;
  final String price;
  final String? subPrice;
}

class SubscriptionSelector extends StatefulWidget {
  const SubscriptionSelector({super.key});

  @override
  State<SubscriptionSelector> createState() => _SubscriptionSelectorState();
}

class _SubscriptionSelectorState extends State<SubscriptionSelector> {
  int selectedIndex = 0;

  final options = [
    SubscriptionOption(
      title: '연간 구독',
      subtitle: '첫 구독 시 7일간 무료',
      price: '연 ₩33,000',
      subPrice: '월 ₩3,200',
    ),
    SubscriptionOption(
      title: '월간 구독',
      subtitle: null,
      price: '월 ₩3,200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        final isSelected = selectedIndex == index;
        final option = options[index];

        return GestureDetector(
          onTap: () => setState(() => selectedIndex = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF8F1FF) : const Color(0xFFF9F6FD),
              border: Border.all(
                color: isSelected ? const Color(0xFF6321B5) : const Color(0xFFDADADA),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? const Color(0xFF8844FF) : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: Font.subTitle12.copyWith(color: const Color(0xFF29272A)),
                      ),
                      if (option.subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            option.subtitle!,
                            style: Font.subTitle12.copyWith(color: const Color(0xFF7F2AE8)),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      option.price,
                      style: Font.subTitle12.copyWith(color: const Color(0xFF29272A)),
                    ),
                    if (option.subPrice != null)
                      Text(
                        option.subPrice!,
                        style: Font.body12.copyWith(color: const Color(0xFF76717A)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
