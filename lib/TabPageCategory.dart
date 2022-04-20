import 'package:flutter/material.dart';

import 'Merchant.dart';

class TabPageCategory {
  const TabPageCategory(
      {this.text, this.icon, this.title, this.tabIndex, this.typeIndex});
  final String text;
  final String title;
  final IconData icon;
  final int tabIndex;
  final int typeIndex;
}

class TabPages {
  static const List<TabPageCategory> pages = <TabPageCategory>[
    TabPageCategory(
        text: 'EAT',
        icon: Icons.restaurant,
        title: 'RESTAURANT',
        tabIndex: 0,
        typeIndex: 0),
    TabPageCategory(
        text: 'TOGO',
        icon: Icons.restaurant_menu,
        title: 'TAKE-AWAY-FOOD',
        tabIndex: 1,
        typeIndex: 1),
    TabPageCategory(
        text: 'BAR',
        icon: Icons.local_bar,
        title: 'BAR, CLUB, CAFE',
        tabIndex: 2,
        typeIndex: 2),
    TabPageCategory(
        text: 'MARKET',
        icon: Icons.shopping_cart,
        title: 'SUPERMARKET',
        tabIndex: 3,
        typeIndex: 3),
    TabPageCategory(
        text: 'SHOP',
        icon: Icons.shopping_basket,
        title: 'SHOP & FASHION',
        tabIndex: 4,
        typeIndex: 4),
    TabPageCategory(
        text: 'HOTEL',
        icon: Icons.hotel,
        title: 'HOTEL & BnB',
        tabIndex: 5,
        typeIndex: 5),
    /*_Page(
      text: 'ATM',
      icon: Icons.atm,
      title: 'TELLER & TRADER',
      tabIndex: 6,
      typeIndex: 99),*/
    TabPageCategory(
        text: 'OTHER',
        icon: Icons.spa,
        title: 'Other',
        tabIndex: 6,
        typeIndex: 999),
  ];

  static getTabIndex(Merchant m) {
    return m.type != 999 ? m.type : 6;
  }
}
