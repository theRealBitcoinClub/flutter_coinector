import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Toaster {
  static void showToastEmailNotConfigured() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: "E-Mail client not configured?!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red[800].withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showToastMaxTagCountReached() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: "4 tags are enough! Thank you!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red[800].withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showInstructionToast(
      showToastCount, hintCountTotal, msgProvider) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msgProvider(showToastCount, hintCountTotal),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.primaries[(showToastCount % hintCountTotal) * 2]
            .withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static Future<int> initToastCounter(prefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return getCounterFromPrefsWithDefaultValue(prefs, prefKey);
  }

  static int getCounterFromPrefsWithDefaultValue(SharedPreferences prefs, key) {
    var counterTmp = prefs.getInt(key);
    return counterTmp != null ? counterTmp : 0;
  }

  static Future incrementAndPersistToastCounter(sharedPrefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var counterToastSpecific =
        getCounterFromPrefsWithDefaultValue(prefs, sharedPrefKey);
    prefs.setInt(sharedPrefKey, counterToastSpecific);
  }

  static String getGeneralToastHint(counterToastGeneral, totalHintCounter) {
    switch (counterToastGeneral % totalHintCounter) {
      case 0:
        return "MARKER: Tap any marker to see more information of that selected place.";
      case 1:
        return "LOCATION: Tap the location button (top right) to zoom to your current location.";
      case 2:
        return "CLOSE: Tap the close button (bottom) to see the complete list of all places worldwide.";
    }
    return "";
  }

  static String getMerchantSpecificToastHint(counterToastSpecific, totalHintCounter) {
    switch (counterToastSpecific % totalHintCounter) {
      case 0:
        return "DETAILS: Tap the info box to load the details of that place.";
      case 1:
        return "ROUTE: Tap the route button (bottom right), to navigate to the selected place.";
      case 2:
        return "MAP: Tap the map at any free space, to close the info box of a selected place.";
    }
    return "";
  }
}
