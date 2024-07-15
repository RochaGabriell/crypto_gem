import 'package:crypto_gem/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class LabelFormated extends StatelessWidget {
  final String title;
  final String value;
  final bool isRow;

  const LabelFormated({
    super.key,
    required this.title,
    required this.value,
    this.isRow = false,
  });

  @override
  Widget build(BuildContext context) {
    const textStyleTitle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    const textStyleValue = TextStyle(
      fontSize: 16,
      color: AppPallete.foregroundColor,
    );

    if (isRow) {
      return Row(
        children: [
          Text(title, style: textStyleTitle),
          Text(value, style: textStyleValue),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyleTitle),
          Text(value, style: textStyleValue),
        ],
      );
    }
  }
}
