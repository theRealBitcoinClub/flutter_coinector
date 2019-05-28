import 'package:flutter/material.dart';

class Dialogs {
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
}
