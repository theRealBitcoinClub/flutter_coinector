import 'package:flutter/material.dart';

class TabPageStatistics {
  const TabPageStatistics(
      {this.text,
      this.icon,
      this.title,
      this.tabIndex,
      this.color,
      this.file,
      this.varietyCount});
  final String text;
  final String title;
  final IconData icon;
  final int tabIndex;
  final Color color;
  final String file;
  final int varietyCount;
}

class TabPagesStatistics {
  static const List<TabPageStatistics> pages = <TabPageStatistics>[
    TabPageStatistics(
        text: 'COINS',
        icon: Icons.currency_bitcoin_outlined,
        title: 'Bitcoins',
        tabIndex: 0,
        color: Colors.green,
        file: "PieChartCoins",
        varietyCount: 3),
    TabPageStatistics(
        text: 'BRANDS',
        icon: Icons.brightness_auto_outlined,
        title: 'Team / Brand',
        tabIndex: 1,
        color: Colors.yellow,
        file: "PieChartBrands",
        varietyCount: 15),
    TabPageStatistics(
        text: 'TYPE',
        icon: Icons.category_outlined,
        title: 'Category',
        tabIndex: 2,
        color: Colors.blueAccent,
        file: "PieChartCategories",
        varietyCount: 7),
    TabPageStatistics(
        text: 'CONTINENT',
        icon: Icons.landscape_outlined,
        title: 'Location',
        tabIndex: 3,
        color: Colors.redAccent,
        file: "PieChartContinents",
        varietyCount: 4),
  ];
}
