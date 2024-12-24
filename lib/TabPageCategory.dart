import 'package:Coinector/MyColors.dart';
import 'package:flutter/material.dart';

import 'Merchant.dart';

class TabPageCategory {
  TabPageCategory(
      {this.short,
      this.icon,
      this.long,
      this.tabIndex,
      this.typeIndex,
      this.color});
  final String short;
  final String long;
  final IconData icon;
  final int tabIndex;
  final int typeIndex;
  Color color;
}

class TabPages {
  static List<TabPageCategory> pages = <TabPageCategory>[
    TabPageCategory(
        short: 'EAT',
        icon: Icons.restaurant,
        long: 'RESTAURANT',
        tabIndex: 0,
        typeIndex: 0,
        color: MyColors.getTabColor(0)),
    TabPageCategory(
        short: 'TOGO',
        icon: Icons.restaurant_menu,
        long: 'TAKE-AWAY-FOOD',
        tabIndex: 1,
        typeIndex: 1,
        color: MyColors.getTabColor(1)),
    TabPageCategory(
        short: 'BAR',
        icon: Icons.local_bar,
        long: 'BAR, CLUB, CAFE',
        tabIndex: 2,
        typeIndex: 2,
        color: MyColors.getTabColor(2)),
    TabPageCategory(
        short: 'MARKET',
        icon: Icons.shopping_cart,
        long: 'SUPERMARKET',
        tabIndex: 3,
        typeIndex: 3,
        color: MyColors.getTabColor(3)),
    TabPageCategory(
        short: 'SHOP',
        icon: Icons.shopping_basket,
        long: 'SHOP & FASHION',
        tabIndex: 4,
        typeIndex: 4,
        color: MyColors.getTabColor(4)),
    TabPageCategory(
        short: 'HOTEL',
        icon: Icons.hotel,
        long: 'HOTEL & BnB',
        tabIndex: 5,
        typeIndex: 5,
        color: MyColors.getTabColor(5)),
    /*_Page(
      text: 'ATM',
      icon: Icons.atm,
      title: 'TELLER & TRADER',
      tabIndex: 6,
      typeIndex: 99),*/
    TabPageCategory(
        short: 'OTHER',
        icon: Icons.spa,
        long: 'OTHER',
        tabIndex: 6,
        typeIndex: 999,
        color: MyColors.getTabColor(6)),
  ];

  static getTabIndex(Merchant m) {
    return m.type != 999 ? m.type : 6;
  }
}
