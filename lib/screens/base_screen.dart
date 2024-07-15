import 'package:crypto_gem/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import 'package:crypto_gem/screens/coins_screnn/coins_screnn.dart';
import 'package:crypto_gem/screens/favorite_screen/favorite_screen.dart';
import 'package:crypto_gem/screens/about_screen/about_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;

  final List<Map<String, TabItem>> _items = [
    {'favorite': TabItem('Favoritos', Icons.stars, const FavoriteScreen())},
    {
      'coins': TabItem(
        'Criptomoedas',
        Icons.monetization_on,
        const CoinsScrenn(),
      )
    },
    {'about': TabItem('Sobre', Icons.info, const AboutScreen())}
  ];

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _items[_currentIndex].values.first.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        fixedColor: AppPallete.backgroundColor,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: _items.map(
          (item) {
            return BottomNavigationBarItem(
              icon: Icon(item.values.first.icon),
              label: item.values.first.title,
            );
          },
        ).toList(),
      ),
    );
  }
}

class TabItem {
  final String title;
  final IconData icon;
  final Widget child;

  TabItem(this.title, this.icon, this.child);
}
