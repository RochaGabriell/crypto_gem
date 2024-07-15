import 'package:crypto_gem/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final Widget child;

  const CoinCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppPallete.disabledColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
