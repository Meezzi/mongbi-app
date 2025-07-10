import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/domain/entities/subscriptionproduct.dart';

class SubscriptionSelector extends StatelessWidget {

  const SubscriptionSelector({
    super.key,
    required this.products,
    required this.selectedIndex,
    required this.onChanged,
  });
  final List<SubscriptionProduct> products;
  final int selectedIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(products.length, (index) {
        final isSelected = selectedIndex == index;
        final product = products[index];

        return GestureDetector(
          onTap: () => onChanged(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? const Color(0xFFF8F1FF)
                      : const Color(0xFFF9F6FD),
              border: Border.all(
                color:
                    isSelected
                        ? const Color(0xFF6321B5)
                        : const Color(0xFFDADADA),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected ? const Color(0xFF8844FF) : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    product.title,
                    style: Font.subTitle12.copyWith(
                      color: const Color(0xFF29272A),
                    ),
                  ),
                ),
                Text(
                  product.price,
                  style: Font.subTitle12.copyWith(
                    color: const Color(0xFF29272A),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
