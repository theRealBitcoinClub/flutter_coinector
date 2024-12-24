import 'package:flutter/material.dart';

class MyColors {
  static Color getTabColor(typeIndex) {
    switch (typeIndex) {
      case 0:
        return Colors.deepOrange[400];
      case 1:
        return Colors.red[400];
      case 2:
        return Colors.yellow[700];
      case 3:
        return Colors.teal[400];
      case 4:
        return Colors.pink[400];
      case 5:
        return Colors.green[400];
      case 99:
        return Colors.green[400];
      case 999:
      case 6: //Add this case to work with tabindex
        return Colors.deepPurple[400];
    }
    return null;
  }

  static Color getCardInfoBoxBackgroundColor(typeIndex) {
    switch (typeIndex) {
      case 0:
        return Colors.deepOrange[700];
      case 1:
        return Colors.red[700];
      case 2:
        return Colors.yellow[900];
      case 3:
        return Colors.teal[800];
      case 4:
        return Colors.pink[700];
      case 5:
        return Colors.green[800];
      case 99:
        return Colors.green[800];
      case 999:
      case 6: //Add this case to work with tabindex
        return Colors.purple[700];
    }
    return null;
  }

  static Color getCardActionButtonBackgroundColor(typeIndex) {
    switch (typeIndex) {
      case 0:
        return Colors.deepOrange[900];
      case 1:
        return Colors.red[800];
      case 2:
        return Colors.yellow[900];
      case 3:
        return Colors.teal[900];
      case 4:
        return Colors.pink[800];
      case 5:
        return Colors.green[900];
      case 99:
        return Colors.green[900];
      case 999:
      case 6:
        return Colors.purple[900];
    }
    return null;
  }
}
