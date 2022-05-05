// Identifier w

class TagCoin {
  static Set<TagCoin> _tagCoins;
  static Set<String> _suggestions;
  int index;
  String long;
  String short;

  TagCoin(this.index, this.long, this.short);

  static Set<String> getSuggestions() {
    if (_suggestions == null) {
      _suggestions = {};
      getTagCoins().forEach((TagCoin element) {
        _suggestions.add(element.long);
        _suggestions.add(element.short);
      });
    }

    return _suggestions;
  }

  static Set<TagCoin> getTagCoins() {
    if (_tagCoins == null) {
      _tagCoins = {};
      _tagCoins.add(TagCoin(0, "Bitcoin Cash", "BCH"));
      _tagCoins.add(TagCoin(1, "Digital Cash", "DASH"));
      _tagCoins.add(TagCoin(2, "Bitcoin Core", "BTC"));
      _tagCoins.add(TagCoin(3, "Tether USD", "USDT"));
      _tagCoins.add(TagCoin(4, "Binance USD", "BUSD"));
      _tagCoins.add(TagCoin(5, "Flex USD", "FUSD"));
      _tagCoins.add(TagCoin(6, "Maker DAI", "DAI"));
      _tagCoins.add(TagCoin(7, "Reserve", "RUSD"));
    }
    return _tagCoins;
  }
}
