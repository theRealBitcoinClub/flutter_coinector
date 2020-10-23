import 'package:Coinector/Dialogs.dart';
import 'package:Coinector/InternetConnectivityChecker.dart';
import 'package:Coinector/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Snackbars {
  static void _showSnackBar(
      GlobalKey<ScaffoldState> _scaffoldKey, ctx, String msgId,
      {String additionalText = "",
      snackbarAction,
      duration = const Duration(milliseconds: 5000),
      removeLatest = false}) {
    if (_scaffoldKey == null || _scaffoldKey.currentState == null) return;

    if (removeLatest) _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      action: snackbarAction,
      duration: duration,
      content: Text(
        Translator.translate(ctx, msgId) + additionalText,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900]),
      ),
      backgroundColor: Colors.yellow[700],
    ));
  }

  static var isBusySnacking = false;

  static void close() {
    isBusySnacking = false;
  }

  static void showInternetErrorSnackbar(that) async {
    //Double check internet connection before showing error
    if (isBusySnacking) return;
    isBusySnacking = true;
    try {
      InternetConnectivityChecker.checkConnectionWithRequest(that, (abc) {
        _snackBarInternetError(that.scaffoldKey, that.context);
        isBusySnacking = false;
      });
    } catch (e) {
      isBusySnacking = false;
    }
  }

  static void _snackBarInternetError(
      GlobalKey<ScaffoldState> scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "",
        removeLatest: true,
        additionalText: Dialogs.INTERNET_ERROR,
        duration: Duration(seconds: 3));
  }

  static void showMatchingSnackBar(
      scaffoldKey, ctx, String fileName, String search, int index) {
    if (fileName != null)
      _showSnackBar(scaffoldKey, ctx, "snackbar_filtered_by_location",
          additionalText: search);
    else if (index != -1 && fileName == null)
      _showSnackBar(scaffoldKey, ctx, "snackbar_filtered_by_tag",
          additionalText: search);
    else
      _showSnackBar(scaffoldKey, ctx, "snackbar_merchant",
          additionalText: search);
  }

  static void showSnackBarUnfilteredList(scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "snackbar_showing_unfiltered_list");
  }

  static void showSnackBarRestartApp(scaffoldKey, ctx) {
    String text = Translator.translate(ctx, "dialog_close");
    _showSnackBar(scaffoldKey, ctx, "",
        duration: Duration(seconds: 30),
        additionalText:
            text.isEmpty ? "App updated, restart now ->" : text + " ->",
        snackbarAction: SnackBarAction(
          label: "RESTART",
          onPressed: () {
            Phoenix.rebirth(ctx);
          },
        ));
  }

  static void showSnackBarGPS(scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "", additionalText: "Updated GPS!");
    //TODO I want to check periodically if GPS changed, use a listener, then update carditems silently
  }
}
