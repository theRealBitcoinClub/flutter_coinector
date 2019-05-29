import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Toaster {
  static const double DEFAULT_FONT_SIZE = 14.0;
  static const Color DEFAULT_TEXT_COLOR = Colors.white;
  static Color DEFAULT_BACKGROUND_COLOR = Colors.red[800].withOpacity(0.8);
  static const int DEFAULT_TIME_FOR_IOS = 3;
  static const Toast DEFAULT_TIME_FOR_ANDROID = Toast.LENGTH_LONG;
  static const ToastGravity DEFAULT_TOAST_GRAVITY = ToastGravity.CENTER;

  static void showToastLaunchingEmailClient() {
    showWarning("Please select your favorite E-Mail client!");
  }

  static void showToastMaxTagsReached() {
    showWarning("Four tags are enough! Thank you!");
  }

  static void showToastEmailNotConfigured() {
    showWarning("E-Mail client not configured?!");
  }

  static void showToastThanksForSubmitting() {
    showWarning("Thank you for growing adoption!");
  }

  static void showWarning(message) {
    Fluttertoast.cancel();
    showToast(message, DEFAULT_BACKGROUND_COLOR);
  }

  static void showAddName() {
    showWarning("Please enter a name with atleast 5 characters!");
  }

  static void showAddExactlyFourTags() {
    showWarning("Please add exactly four tags!");
  }

  static void showAddAtleastOneReceivingAddress() {
    showWarning("Please add atleast a DASH or a BCH address!");
  }

  static void showAddFullAdr() {
    showWarning(
        "Please enter the FULL ADDRESS: Street, Number, State & Country!");
  }

  static void showInstructionToast(
      showToastCount, hintCountTotal, msgProvider) {
    Fluttertoast.cancel();
    showToast(msgProvider(showToastCount, hintCountTotal),
        getBackGroundColor(showToastCount, hintCountTotal));
  }

  static void showToast(msgProvider, backgroundColorProvider) {
    Fluttertoast.showToast(
        msg: msgProvider,
        toastLength: DEFAULT_TIME_FOR_ANDROID,
        gravity: DEFAULT_TOAST_GRAVITY,
        timeInSecForIos: DEFAULT_TIME_FOR_IOS,
        backgroundColor: backgroundColorProvider,
        textColor: DEFAULT_TEXT_COLOR,
        fontSize: DEFAULT_FONT_SIZE);
  }

  static Color getBackGroundColor(showToastCount, hintCountTotal) {
    return Colors.primaries[(showToastCount % hintCountTotal) * 2]
        .withOpacity(0.8);
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

  static String getMerchantSpecificToastHint(
      counterToastSpecific, totalHintCounter) {
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
