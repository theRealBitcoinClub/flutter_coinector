import 'package:flutter/material.dart';

class Page {
  const Page({this.text, this.icon, this.title, this.tabIndex, this.typeIndex});
  final String text;
  final String title;
  final IconData icon;
  final int tabIndex;
  final int typeIndex;
}

class Pages {
  static const List<Page> pages = <Page>[
    Page(
        text: 'EAT',
        icon: Icons.restaurant,
        title: 'RESTAURANT',
        tabIndex: 0,
        typeIndex: 0),
    Page(
        text: 'TOGO',
        icon: Icons.restaurant_menu,
        title: 'TAKE-AWAY-FOOD',
        tabIndex: 1,
        typeIndex: 1),
    Page(
        text: 'BAR',
        icon: Icons.local_bar,
        title: 'BAR, CLUB, CAFE',
        tabIndex: 2,
        typeIndex: 2),
    Page(
        text: 'MARKET',
        icon: Icons.shopping_cart,
        title: 'SUPERMARKET',
        tabIndex: 3,
        typeIndex: 3),
    Page(
        text: 'SHOP',
        icon: Icons.shopping_basket,
        title: 'SHOP, FASHION',
        tabIndex: 4,
        typeIndex: 4),
    Page(
        text: 'HOTEL',
        icon: Icons.hotel,
        title: 'HOTEL',
        tabIndex: 5,
        typeIndex: 5),
    /*_Page(
      text: 'ATM',
      icon: Icons.atm,
      title: 'TELLER & TRADER',
      tabIndex: 6,
      typeIndex: 99),*/
    Page(
        text: 'SPA',
        icon: Icons.spa,
        title: 'WELLNESS & BEAUTY',
        tabIndex: 6,
        typeIndex: 999),
  ];
}
