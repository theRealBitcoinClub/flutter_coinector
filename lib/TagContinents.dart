// Identifier b

import 'dart:ui';

import 'package:flutter/material.dart';

class TagContinent {
  static Set<TagContinent> _continents;
  static Set<String> _suggestions;
  int index;
  String short;
  String long;
  Color color;
  IconData icon;

  TagContinent(this.index, this.short, this.long, this.color);

  static Set<TagContinent> getContinents() {
    if (_continents == null) {
      _continents = {};
      _continents.add(TagContinent(0, "AM", "America", Colors.green));
      _continents.add(TagContinent(1, "E", "Europe", Colors.blueAccent));
      _continents.add(TagContinent(2, "AU", "Australia", Colors.redAccent));
      _continents.add(TagContinent(3, "AS", "Asia", Colors.yellowAccent));
    }
    return _continents;
  }
}
