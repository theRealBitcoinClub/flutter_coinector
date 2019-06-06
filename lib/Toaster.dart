import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Toaster {
  static const DEFAULT_BACKGROUND_OPACITY = 0.9;
  static const double DEFAULT_FONT_SIZE = 14.0;
  static const Color DEFAULT_TEXT_COLOR = Colors.white;
  static Color DEFAULT_BACKGROUND_COLOR =
      Colors.red[900].withOpacity(DEFAULT_BACKGROUND_OPACITY);
  static const int DEFAULT_TIME_FOR_IOS = 3;
  static const Toast DEFAULT_TIME_FOR_ANDROID = Toast.LENGTH_LONG;
  static const ToastGravity DEFAULT_TOAST_GRAVITY = ToastGravity.CENTER;

  static void showToastLaunchingEmailClient(ctx) {
    showWarning(FlutterI18n.translate(ctx, "toaster_select_email_client"));
  }

  static void showToastEmailNotConfigured(ctx) {
    showWarning(FlutterI18n.translate(ctx, "toaster_email_not_configured"));
  }

  static void showWarning(message) {
    Fluttertoast.cancel();
    showToast(message, DEFAULT_BACKGROUND_COLOR);
  }

  static void showAddName(ctx) {
    showWarning(FlutterI18n.translate(
        ctx, "toaster_enter_name_atleast_five_characters"));
  }

  static void showAddExactlyFourTags(ctx) {
    showWarning(FlutterI18n.translate(ctx, "toaster_minimum_four_tags"));
  }

  static void showAddAtleastOneReceivingAddress(ctx) {
    showWarning(FlutterI18n.translate(ctx, "toaster_atleast_one_bitcoin_adr"));
  }

  static void showAddFullAdr(ctx) {
    showWarning(FlutterI18n.translate(ctx, "toaster_full_adr"));
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
        timeInSecForIos: DEFAULT_TIME_FOR_IOS,
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
        return FlutterI18n.translate(ctx, "toast_instructions_marker");
      case 1:
        return FlutterI18n.translate(ctx, "toast_instructions_location");
      case 2:
        return FlutterI18n.translate(ctx, "toast_instructions_close");
    }
    return "";
  }

  static String getMerchantSpecificToastHint(
      ctx, counterToastSpecific, totalHintCounter) {
    switch (counterToastSpecific % totalHintCounter) {
      case 0:
        return FlutterI18n.translate(ctx, "toast_instructions_details");
      case 1:
        return FlutterI18n.translate(ctx, "toast_instructions_route");
      case 2:
        return FlutterI18n.translate(ctx, "toast_instructions_map");
    }
    return "";
  }
}
