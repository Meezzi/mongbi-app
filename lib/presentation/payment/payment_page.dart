import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/payment/widgets/bottom_button.dart';
import 'package:mongbi_app/presentation/payment/widgets/premium_item_card.dart';
import 'package:mongbi_app/presentation/payment/widgets/price_card.dart';
import 'package:mongbi_app/presentation/payment/widgets/restore_button.dart';
import 'package:mongbi_app/presentation/payment/widgets/terms_text_button.dart';
import 'package:mongbi_app/providers/inapp_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(splashViewModelProvider);
    final viewModel = ref.watch(subscriptionViewModelProvider);
    final products = viewModel.products;

    if (products.isEmpty) {
      return const CircularProgressIndicator(); // or SizedBox.shrink()
    }
    AnalyticsHelper.logScreenView('결제페이지');

    return Scaffold(
      appBar: AppBar(
        title: Text('프리미엄 패스', style: Font.title20),
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
        ),
        backgroundColor: const Color(0xFFFCF6FF),
      ),
      backgroundColor: const Color(0xFFFCF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 55),
                Image.asset(
                  'assets/images/medal.webp',
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
                const SizedBox(height: 10),
                Text(
                  '7일간 무료로 먼저 체험해보세요! \n 결제는 언제든 취소할 수 있어요.',
                  textAlign: TextAlign.center,
                  style: Font.title14.copyWith(color: const Color(0xFF1A181B)),
                ),
                const SizedBox(height: 50),
                SubscriptionSelector(
                  products: products,
                  selectedIndex: viewModel.selectedIndex,
                  onChanged: viewModel.select,
                ),

                const SizedBox(height: 15),
                Text(
                  '*무료 구독은 첫 구매시에만 적용됩니다.',
                  textAlign: TextAlign.center,
                  style: Font.body12.copyWith(color: const Color(0xFF76717A)),
                ),
                const SizedBox(height: 30),
                const PremiumBenefitCard(
                  title: '광고 완전 제거',
                  description: '몽비와 함께하는 시간동안\n광고는 없어드려요',
                  assetImage: 'assets/images/ad.webp',
                ),
                const PremiumBenefitCard(
                  title: '프리미엄 해몽',
                  description: '보다 더 자세한 해몽을 통해\n내 꿈을 이해할 수 있어요',
                  assetImage: 'assets/images/ad.webp',
                ),
                const PremiumBenefitCard(
                  title: '심층 퍼스널 리포트',
                  description: '더욱 자세한 꿈 분석을 통해\n나의 심리를 더 자세히 알 수 있어요.',
                  assetImage: 'assets/images/ad.webp',
                ),
                const SizedBox(height: 20),
                RestorePurchaseButton(
                  onPressed: () {
                    // TODO: 구매 복원 로직
                    print('구매 복원 시도!');
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  '구글 플레이스토어에 로그인된 계정을 통해 결제가 진행됩니다.\n연간 맴버쉽의 가격은 연 ₩33,000원 으로 매년 자동으로 결제되며 \n언제든 취소가 가능합니다.',
                  textAlign: TextAlign.center,
                  style: Font.body12.copyWith(color: const Color(0xFF76717A)),
                ),
                const SizedBox(height: 20),
                TermsLinksRow(
                  onServiceTermsPressed: () {
                    print('서비스 이용약관 열기');
                  },
                  onPrivacyPolicyPressed: () {
                    print('개인정보 처리방침 열기');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PremiumBottomBar(
        onPressed: () {
          // TODO: 결제 로직
        },
        buttonText:
            viewModel.selectedProduct.price.contains('₩33,000')
                ? '무료 체험 시작하기'
                : '프리미엄 패스 결제하기',
        description:
            viewModel.selectedProduct.price.contains('₩33,000')
                ? '무료 체험 종료 후 연간 ₩33,000원이 결제되며,\n언제든 취소가 가능해요.' // 월간이면 설명문구 숨김
                : null,
      ),
    );
  }
}
