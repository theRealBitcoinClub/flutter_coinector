import 'package:Coinector/translator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dialogs.dart';

class Toaster {
  static const DEFAULT_BACKGROUND_OPACITY = 0.9;
  static const double DEFAULT_FONT_SIZE = 16.0;
  static const Color DEFAULT_TEXT_COLOR = Colors.white;
  static Color DEFAULT_BACKGROUND_COLOR = Colors.yellow[900];
  static const int DEFAULT_TIME_FOR_IOS_AND_WEB = 3;
  static const Toast DEFAULT_TIME_FOR_ANDROID = Toast.LENGTH_LONG;
  static const ToastGravity DEFAULT_TOAST_GRAVITY = ToastGravity.TOP;

  static void showToastInternetError(ctx) {
    _showWarning(Dialogs.INTERNET_ERROR);
  }

  static void showToastAttractCustomers(ctx) {
    _showWarning(
        Translator.translate(ctx, "Please select a suggestion from the list!"));
  }

  static void showToastSelectSuggestion() {
    _showWarning("Please select a suggestion from the list!");
  }

  static void showToastLaunchingEmailClient(ctx) {
    _showWarning(Translator.translate(ctx, "toaster_select_email_client"));
  }

  static void showToastEmailNotConfigured(ctx) {
    _showWarning(Translator.translate(ctx, "toaster_email_not_configured"));
  }

  static var isToasting = false;

  static void _showWarning(message) async {
    if (!await cancel()) isToasting = true;
    showToast(message, DEFAULT_BACKGROUND_COLOR);
  }

  static Future<bool> cancel() async {
    if (isToasting) await Fluttertoast.cancel();
    isToasting = false;
    return isToasting;
  }

  static void showAddName(ctx) {
    _showWarning(Translator.translate(
        ctx, "toaster_enter_name_atleast_five_characters"));
  }

  static void showAddExactlyFourTags(ctx) {
    _showWarning(Translator.translate(ctx, "toaster_minimum_four_tags"));
  }

  static void showAddAtleastOneReceivingAddress(ctx) {
    _showWarning(Translator.translate(ctx, "toaster_atleast_one_bitcoin_adr"));
  }

  static void showAddFullAdr(ctx) {
    _showWarning(Translator.translate(ctx, "toaster_full_adr"));
  }

  static void showInstructionToast(
      ctx, showToastCount, hintCountTotal, msgProvider) {
    Fluttertoast.cancel();
    showToast(msgProvider(ctx, showToastCount, hintCountTotal),
        getBackGroundColor(showToastCount, hintCountTotal));
  }

  static void showToast(msgProvider, backgroundColorProvider) {
    Fluttertoast.showToast(
        msg: msgProvider,
        toastLength: DEFAULT_TIME_FOR_ANDROID,
        gravity: DEFAULT_TOAST_GRAVITY,
        timeInSecForIosWeb: DEFAULT_TIME_FOR_IOS_AND_WEB,
        backgroundColor: backgroundColorProvider,
        textColor: DEFAULT_TEXT_COLOR,
        fontSize: DEFAULT_FONT_SIZE);
  }

  static Color getBackGroundColor(showToastCount, hintCountTotal) {
    return Colors.primaries[(showToastCount % hintCountTotal) * 2]
        .withOpacity(DEFAULT_BACKGROUND_OPACITY);
  }

  static Future<int> initToastCounter(prefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return getCounterFromPrefsWithDefaultValue(prefs, prefKey);
  }

  static int getCounterFromPrefsWithDefaultValue(SharedPreferences prefs, key) {
    var counterTmp = prefs.getInt(key);
    return counterTmp != null ? counterTmp : 0;
  }

  static Future persistToastCounter(sharedPrefKey, newCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(sharedPrefKey, newCount);
  }

  static String getGeneralToastHint(
      ctx, counterToastGeneral, totalHintCounter) {
    switch (counterToastGeneral % totalHintCounter) {
      case 0:
        return Translator.translate(ctx, "toast_instructions_marker");
      case 1:
        return Translator.translate(ctx, "toast_instructions_location");
    }
    return "";
  }

  static String getMerchantSpecificToastHint(
      ctx, counterToastSpecific, totalHintCounter) {
    switch (counterToastSpecific % totalHintCounter) {
      case 0:
        return Translator.translate(ctx, "toast_instructions_details");
      case 1:
        return Translator.translate(ctx, "toast_instructions_route");
      case 2:
        return Translator.translate(ctx, "toast_instructions_map");
    }
    return "";
  }
}
