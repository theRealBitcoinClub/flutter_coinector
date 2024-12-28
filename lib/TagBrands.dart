// Identifier b

import 'package:flutter/material.dart';

class TagBrand {
  static Set<TagBrand> _brands={};
  static Set<String> _suggestions={};
  int index;
  String short;
  String long;
  Color color;
  IconData? icon;

  TagBrand(this.index, this.short, this.long, this.color);

  static Set<String> getSuggestions() {
    if (_suggestions.isEmpty) {
      _suggestions = {};
      getBrands().forEach((TagBrand element) {
        _suggestions.add(element.long);
      });
    }

    return _suggestions;
  }

  static Set<TagBrand> getBrands() {
    if (_brands.isEmpty) {
      _brands = {};
      _brands.add(TagBrand(0, "TRBC", "The Real Bitcoin Club",
          Color.fromRGBO(71, 133, 88, 1.0)));
      _brands.add(TagBrand(1, "APAY", "Anypay", Colors.blueGrey[700]!));
      _brands.add(TagBrand(2, "GOC", "GoCrypto", Colors.yellow[700]!));
      _brands.add(
          TagBrand(3, "TOW", "BCH City", Colors.lightGreen[600]!));
      _brands.add(TagBrand(4, "BCHLAT", "BCHLatam", Colors.green));
      _brands.add(TagBrand(5, "BNB", "Binance", Colors.amber[700]!));
      _brands.add(TagBrand(6, "SAL", "Salamantex", Colors.orange[700]!));
      _brands.add(TagBrand(7, "CBUY", "CryptoBuyer", Colors.teal));
      _brands.add(TagBrand(8, "XPAY", "XPay", Colors.blue[600]!));
      _brands.add(TagBrand(9, "CAT", "Cripto Catia", Colors.green[800]!));
      _brands.add(TagBrand(10, "BCOM", "bitcoin.com", Colors.deepOrange));
      _brands.add(TagBrand(11, "BARN", "Bitcoinstad Arnhem", Colors.orange));
      _brands.add(TagBrand(12, "CMAP", "Coinmap.org", Colors.deepOrange));
      _brands.add(TagBrand(13, "DASH", "Discover Dash", Colors.blue));
      _brands.add(TagBrand(14, "SAT", "Satoshi Angels", Colors.purple));
      _brands.add(TagBrand(15, "BCHH", "BCH House Vzla", Colors.green[400]!));
      _brands.add(TagBrand(16, "BCHO", "BCH Oriente Vzla", Colors.green[600]!));
      _brands.add(TagBrand(17, "ARG", "BCH Argentina", Colors.teal));
      _brands.add(TagBrand(18, "GIF", "Ryan Giffin", Colors.blue));
      _brands.add(TagBrand(19, "FAL", "Marc Falzon", Colors.pink));
      _brands.add(TagBrand(20, "SUN", "BCH Sunny", Colors.yellow));
      _brands.add(TagBrand(21, "NICK", "Nick Chase", Colors.red));
      _brands.add(TagBrand(22, "BMAP", "bmap.app", Colors.indigo));
    }
    return _brands;
  }
}
