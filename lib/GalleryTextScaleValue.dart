import 'package:flutter/material.dart';

class CoinectorTextScalevalue {
  const CoinectorTextScalevalue(this.scale, this.label);

  final double scale;
  final String label;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final CoinectorTextScalevalue typedOther = other;
    return scale == typedOther.scale && label == typedOther.label;
  }

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<CoinectorTextScalevalue> kAllCoinectorTextScalevalues =
    <CoinectorTextScalevalue>[
  CoinectorTextScalevalue(1.0, 'System Default'),
  CoinectorTextScalevalue(0.8, 'Small'),
  CoinectorTextScalevalue(1.0, 'Normal'),
  CoinectorTextScalevalue(1.3, 'Large'),
  CoinectorTextScalevalue(2.0, 'Huge'),
];
