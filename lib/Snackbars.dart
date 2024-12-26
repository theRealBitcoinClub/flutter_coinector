import 'package:Coinector/Dialogs.dart';
import 'package:Coinector/InternetConnectivityChecker.dart';
import 'package:Coinector/translator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'TagCoinector.dart';
import 'UrlLauncher.dart';

class Snackbars {
  static void _showSnackBar(
      GlobalKey<ScaffoldState> _scaffoldKey, BuildContext ctx, String msgId,
      {String additionalText = "",
      snackbarAction,
      duration = const Duration(milliseconds: 5000),
      removeLatest = false}) {
    if (_isWidgetUnmounted(ctx, _scaffoldKey)) return;
    if (removeLatest) ScaffoldMessenger.of(ctx).removeCurrentSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
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

  static bool _isWidgetUnmounted(
          BuildContext ctx, GlobalKey<ScaffoldState> _scaffoldKey) =>
      ctx.widget == null ||
      _scaffoldKey == null ||
      _scaffoldKey.currentState == null ||
      !_scaffoldKey.currentState!.mounted;

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

  static void showFilterSearchSnackBar(scaffoldKey, ctx, bool isLocationFilter,
      String search, TagCoinector ?tag) {
    if (isLocationFilter)
      _showSnackBar(scaffoldKey, ctx, "snackbar_filtered_by_location",
          additionalText: search);
    else if (tag != null)
      _showSnackBar(scaffoldKey, ctx, "snackbar_filtered_by_tag",
          additionalText: search);
    else
      _showSnackBar(scaffoldKey, ctx, "snackbar_merchant",
          additionalText: search);
  }

  static void showSnackBarUnfilteredList(scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "snackbar_showing_unfiltered_list");
  }

  static void showSnackBarAfterAddPlace(scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "snackbar_you_are_satoshi");
  }

  static void showSnackBarRestartApp(scaffoldKey, ctx) {
    String text = Translator.translate(ctx, "toast_update_succesfull");
    _showSnackBar(scaffoldKey, ctx, "",
        duration: Duration(seconds: 30),
        additionalText:
            text.isEmpty ? "App updated, restart now ->" : text + " ->",
        snackbarAction: SnackBarAction(
          label: Translator.translate(ctx, "RESTART"),
          onPressed: () {
            Phoenix.rebirth(ctx);
          },
        ));
  }

  static void showSnackBarGPS(scaffoldKey, ctx) {
    _showSnackBar(scaffoldKey, ctx, "", additionalText: "Updated GPS!");
    //TODO I want to check periodically if GPS changed, use a listener, then update carditems silently
  }

  static void showSnackBarPlayStore(scaffoldKey, ctx) {
    //THIS METHOD IS ONLY FOR THE WEB APP, in case that someone opens the web app with a mobile phone
    if (!kIsWeb) return;
    String appstore = "Android";
    String chosenUrl = "https://bmap.app/android";
    final iphoneUrl = "https://bitcoinmap.cash/iphone";

    try {
      /*
      if (browser.isSafari || operatingSystem.isMac) {
        appstore = "iPhone";
        chosenUrl = iphoneUrl;
      } else if (operatingSystem.isWindows && browser.isInternetExplorer) {
        appstore = "iPhone";
        chosenUrl = iphoneUrl;
      }*/

      _showSnackBar(scaffoldKey, ctx, "",
          duration: Duration(seconds: 20),
          additionalText: appstore + " app available ->",
          snackbarAction: SnackBarAction(
            label: "Install",
            onPressed: () {
              UrlLauncher.launchURI(chosenUrl, forceWebView: true);
            },
          ));
    } catch (e) {
      //UNSUPPORTED ERROR
      //debugPrint(e);
    }
  }
}
