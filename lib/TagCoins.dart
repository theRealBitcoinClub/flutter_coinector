// Identifier w

import 'package:flutter/material.dart';

class TagCoin {
  static Set<TagCoin> _tagCoins={};
  static Set<String> _suggestions = {};
  int index;
  String long;
  String short;
  Color color;
  IconData? icon;

  TagCoin(this.index, this.long, this.short, this.color);

  static Set<String> getSuggestions() {
    if (_suggestions.isEmpty) {
      getTagCoins().forEach((TagCoin element) {
        _suggestions.add(element.long);
        _suggestions.add(element.short);
      });
    }

    return _suggestions;
  }

  static Set<TagCoin> getTagCoins() {
    if (_tagCoins.isEmpty) {
      _tagCoins.add(TagCoin(0, "Bitcoin Cash", "BCH", Colors.green));
      _tagCoins.add(TagCoin(1, "Digital Cash", "DASH", Colors.blueAccent));
      _tagCoins.add(TagCoin(2, "Bitcoin Core", "BTC", Colors.orange));
      _tagCoins.add(TagCoin(3, "Tether USD", "USDT", Colors.blue[700]!));
      _tagCoins.add(TagCoin(4, "Binance USD", "BUSD", Colors.amber));
      _tagCoins.add(TagCoin(5, "Flex USD", "FUSD", Colors.purple));
      _tagCoins.add(TagCoin(6, "Maker DAI", "DAI", Colors.yellow[900]!));
      _tagCoins.add(TagCoin(7, "Reserve", "RUSD", Colors.blueGrey));
      _tagCoins.add(TagCoin(8, "ZCash", "ZEC", Colors.yellow[800]!));
    }
    return _tagCoins;
  }
}
