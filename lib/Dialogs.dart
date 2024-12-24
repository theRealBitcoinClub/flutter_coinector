import 'package:Coinector/translator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static var hasDialog = false;
  static AwesomeDialog dialog;
  static const String INTERNET_ERROR = "Internet Error!";

  static void showDialogInternetError(ctx) async {
    if (!hasDialog) {
      hasDialog = true;
      //TODO ICH SE H NIX AUFM HANDY
      dialog = await AwesomeDialog(
              context: ctx,
              title: "",
              headerAnimationLoop: false,
              desc: INTERNET_ERROR,
              autoHide: Duration(seconds: 7),
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              padding: EdgeInsets.all(0.0),
              onDissmissCallback: (DismissType d) {
                hasDialog = false;
                Navigator.of(ctx).pop();
              },
              btnOkOnPress: () {
                //dismiss
              })
          .show();
    }
  }

  static void dismissDialog() {
    hasDialog = false;
    if (dialog != null) dialog.dismiss();
  }

  static void confirmMakeDonation(BuildContext buildCtx, callbackYes) {
    showDialog(
        context: buildCtx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(Translator.translate(buildCtx, "make_donation_text")),
            title: Row(
              children: <Widget>[
                Icon(Icons.done_outline),
                Text(" Support adoption?",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              flatButtonNo(buildCtx),
              flatButtonYes(buildCtx, callbackYes)
            ],
          );
        });
  }
/*
  static void confirmUploadPlace(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(Translator.translate(
                context, "Upload this place to bmap.app?")),
            title: Row(
              children: <Widget>[
                Icon(Icons.email),
                Text("Upload place?",Map
                    style: TextStyle(
                        color: Colors
                            .white)) //TODO add missing translations in all dialogs
              ],
            ),
            actions: <Widget>[
              flatButtonNo(context),
              flatButtonYes(context, callbackYes)
            ],
          );
        });
  }*/

  static void confirmSendEmail(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(
                Translator.translate(context, "send_email_containing_data")),
            title: Row(
              children: <Widget>[
                Icon(Icons.email),
                Text(" Send E-Mail?", style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              flatButtonNo(context),
              flatButtonYes(context, callbackYes)
            ],
          );
        });
  }

  static void confirmDownloadPdf(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(Translator.translate(context, "download_qr_code")),
            title: Row(
              children: <Widget>[
                Icon(Icons.file_download),
                Text(" QR-Codes?", style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              flatButtonNo(context),
              flatButtonYes(context, callbackYes)
            ],
          );
        });
  }

  static TextButton flatButtonYes(BuildContext context, callbackYes) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        callbackYes();
      },
      child: Text(Translator.translate(context, "YES")),
    );
  }

  static TextButton flatButtonNo(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(Translator.translate(context, "NO")),
    );
  }

  static void confirmShowResetTags(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content:
                Text(Translator.translate(context, "reset_tags_select_again")),
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
                Text(" Reset tags?", style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              flatButtonNo(context),
              flatButtonYes(context, callbackYes)
            ],
          );
        });
  }

  static void _showInfoDialogWithCloseButton(
      BuildContext buildCtx, String title, String content) {
    showDialog(
        context: buildCtx,
        builder: (BuildContext ctx) {
          var color = Colors.white;
          var textStyle = TextStyle(color: color);
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(content, style: textStyle),
            title: Text(title, style: textStyle),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: color,
                    ),
                    Text(Translator.translate(buildCtx, "dialog_close"),
                        style: textStyle)
                  ],
                ),
              )
            ],
          );
        });
  }

  static void showInfoDialogWithCloseButton(BuildContext buildCtx) {
    _showInfoDialogWithCloseButton(
        buildCtx,
        Translator.translate(buildCtx, "dialog_are_you_hungry"),
        Translator.translate(buildCtx, "dialog_search_favo_food"));
  }

  static void showInfoDialogWithCloseButtonFreeText(
      BuildContext buildCtx, String title, String content) {
    _showInfoDialogWithCloseButton(buildCtx, title, content);
  }

  static TextButton buildCloseDialogButton(BuildContext context) {
    return TextButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.close),
          Text(Translator.translate(context, "dialog_close"))
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  static Color getToggleColor(isEnabled) =>
      isEnabled ? Colors.white : Colors.white54;

  static Icon buildIcon(final icon, final color) => Icon(
        icon,
        size: 25,
        color: color,
      );

  static SizedBox buildSpacer() {
    return const SizedBox(
      height: 5,
    );
  }
}
