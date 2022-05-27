// Identifier b

import 'package:flutter/material.dart';

class TagContinent {
  static Set<TagContinent> _continents;
  int index;
  String short;
  String long;
  Color color;
  IconData icon;

  TagContinent(this.index, this.short, this.long, this.color);

  static Set<TagContinent> getContinents() {
    if (_continents == null) {
      _continents = {};
      _continents.add(TagContinent(0, "AS", "Asia", Colors.yellow[800]));
      _continents.add(TagContinent(1, "AU", "Australia", Colors.red[800]));
      _continents.add(TagContinent(2, "E", "Europe", Colors.blue[800]));
      _continents.add(TagContinent(3, "AM", "America", Colors.green[800]));
    }
    return _continents;
  }
}
