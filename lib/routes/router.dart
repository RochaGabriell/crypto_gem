import 'package:flutter/material.dart';

import 'package:crypto_gem/screens/base_screen.dart';

Route browserRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const BaseScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => const Center(child: Text('404')),
      );
  }
}
