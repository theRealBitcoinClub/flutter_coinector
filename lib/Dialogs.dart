import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Dialogs {
  static void confirmSendEmail(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(
                FlutterI18n.translate(context, "send_email_containing_data")),
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
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
            content: Text(FlutterI18n.translate(context, "download_qr_code")),
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
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

  static FlatButton flatButtonYes(BuildContext context, callbackYes) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
        callbackYes();
      },
      child: Text(FlutterI18n.translate(context, "YES")),
    );
  }

  static FlatButton flatButtonNo(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(FlutterI18n.translate(context, "NO")),
    );
  }

  static void confirmShowResetTags(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content:
                Text(FlutterI18n.translate(context, "reset_tags_select_again")),
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

  static void showInfoDialogWithCloseButton(BuildContext buildCtx) {
    showDialog(
        context: buildCtx,
        builder: (BuildContext ctx) {
          var color = Colors.white;
          var textStyle = TextStyle(color: color);
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(
                FlutterI18n.translate(buildCtx, "dialog_search_favo_food"),
                style: textStyle),
            title: Text(
                FlutterI18n.translate(buildCtx, "dialog_are_you_hungry"),
                style: textStyle),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: color,
                    ),
                    Text(FlutterI18n.translate(buildCtx, "dialog_close"),
                        style: textStyle)
                  ],
                ),
              )
            ],
          );
        });
  }

  static FlatButton buildCloseDialogButton(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.close),
          Text(FlutterI18n.translate(context, "dialog_close"))
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
