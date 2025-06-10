import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppleLoginButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppleLoginButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/apple_login.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
