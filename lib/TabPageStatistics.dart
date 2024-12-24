import 'package:flutter/material.dart';

class TabPageStatistics {
  const TabPageStatistics(
      {this.text,
      this.icon,
      this.title,
      this.tabIndex,
      this.color,
      this.varietyCount});
  final String text;
  final String title;
  final IconData icon;
  final int tabIndex;
  final Color color;
  final int varietyCount;
}

class TabPagesStatistics {
  static const List<TabPageStatistics> pages = <TabPageStatistics>[
    TabPageStatistics(
        text: 'COIN',
        icon: Icons.currency_bitcoin_outlined,
        title: 'Bitcoin / Crypto',
        tabIndex: 0,
        color: Colors.grey,
        varietyCount: 8),
    TabPageStatistics(
        text: 'BRAND',
        icon: Icons.brightness_auto_outlined,
        title: 'Team / Brand',
        tabIndex: 1,
        color: Colors.grey,
        varietyCount: 21),
    TabPageStatistics(
        text: 'TYPE',
        icon: Icons.category_outlined,
        title: 'Place Category',
        tabIndex: 2,
        color: Colors.grey,
        varietyCount: 7),
    TabPageStatistics(
        text: 'GEO',
        icon: Icons.landscape_outlined,
        title: 'Continent',
        tabIndex: 3,
        color: Colors.grey,
        varietyCount: 4),
  ];
}
