import 'package:flutter/material.dart';

class Dialogs {
  static void confirmDownloadPdf(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content:
                Text("Do you want to download a PDF file containing QR-Codes?"),
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
                Text(" QR-Codes?", style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("NO"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  callbackYes();
                },
                child: Text("YES"),
              )
            ],
          );
        });
  }

  static void confirmShowResetTags(BuildContext context, callbackYes) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text("Do you want to reset all tags to select again?"),
            title: Row(
              children: <Widget>[
                Icon(Icons.warning),
                Text(" Reset tags?", style: TextStyle(color: Colors.white))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("NO"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  callbackYes();
                },
                child: Text("YES"),
              )
            ],
          );
        });
  }

  static FlatButton buildCloseDialogButton(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[Icon(Icons.close), Text(' CLOSE')],
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }


  static Color getToggleColor(isEnabled) => isEnabled ? Colors.white : Colors.white54;

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
