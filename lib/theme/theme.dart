import 'package:flutter/material.dart';

import 'package:crypto_gem/theme/app_pallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      foregroundColor: AppPallete.foregroundColor,
      titleTextStyle: TextStyle(
        color: AppPallete.foregroundColor,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPallete.selectedColor,
    ),
    iconTheme: const IconThemeData(
      color: AppPallete.disabledColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPallete.backgroundColor,
      selectedItemColor: AppPallete.selectedColor,
      unselectedItemColor: AppPallete.disabledColor,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: AppPallete.disabledColor,
      selectedColor: AppPallete.selectedColor,
    ),
  );
}
