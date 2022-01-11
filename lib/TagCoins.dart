// Identifier w

class TagCoin {
  static Set<TagCoin> _tagCoins;
  int index;
  String long;
  String short;

  TagCoin(this.index, this.long, this.short);

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
    }
    return _tagCoins;
  }
}
