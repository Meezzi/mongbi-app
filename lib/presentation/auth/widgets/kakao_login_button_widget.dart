import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KakaoLoginButton extends StatelessWidget {
  final VoidCallback? onTap;

  const KakaoLoginButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/kakao_login.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
