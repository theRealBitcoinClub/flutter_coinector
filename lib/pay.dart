import 'package:flutter/material.dart';

import 'AssetLoader.dart';
import 'Dialogs.dart';
//import 'package:clipboard_manager/clipboard_manager.dart';

import 'Merchant.dart';
import 'Place.dart';
import 'UrlLauncher.dart';

class Pay {
  TextButton buildTextButtonPay(BuildContext context, Merchant merchant) {
    return TextButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(
              Icons.payment, Dialogs.getToggleColor(merchant.isPayEnabled)),
          Dialogs.buildSpacer(),
          Text('PAY',
              style: TextStyle(
                  color: Dialogs.getToggleColor(merchant.isPayEnabled)))
        ],
      ),
      onPressed: () {
        handlePayButton(context, merchant);
      },
    );
  }

  void copyAddressToClipAndShowDialog(String data, BuildContext context) {
    //Navigator.of(context).pop();
   /* ClipboardManager.copyToClipBoard(data).then((result) {
      showDialog(
          context: context,
          builder: (buildCtx) {
            return AlertDialog(
              content: Text(
                  "Address was copied to clipboard!\n\nOpen your favorite Wallet to send a transaction.\n\nIf you have a compatible Wallet installed it should open now!\n\nClick here to install a compatible free Wallet."),
              title: Text("Copied to clipboard!",
                  style: TextStyle(color: Colors.white)),
            );
          });
    });*/
  }

  Widget buildAddressDetailDialogBCH(BuildContext context) {
    var data = getBCHAddress();
    if (isAddressEmpty(data)) {
      return AlertDialog(
        content: Text(
            "This merchant does not yet accept BCH payments, please pay with DASH or explain the benefits of accepting BCH to the merchant!"),
        actions: <Widget>[Dialogs.buildCloseDialogButton(context)],
      );
    } else
      return AlertDialog(
        title: Text("BCH (donate to coinspice.io)",
            style: TextStyle(color: Colors.white)),
        actions: [Dialogs.buildCloseDialogButton(context)],
        content: new InkWell(
            child: new Text(getBCHAddress()),
            onTap: () {
              copyAddressToClipAndShowDialog(data, context);
              UrlLauncher.launchURI(data);
              //launch(data);
            }),
      );
  }

  bool isAddressEmpty(data) => data == '-';

  getBCHAddress() => bothReceivingAddresses.split(",")[0];

  Future handlePayButton(BuildContext ctx, Merchant merchant) async {
    bothReceivingAddresses = await AssetLoader.loadReceivingAddress(merchant
        .id!); //TODO load receiving address before creating the carditem so that the item is truly stateless

    if (bothReceivingAddresses != null) {
      merchant.isPayEnabled = true;
    }

    if (merchant.isPayEnabled)
      showPayDialog(ctx);
    else {
      showMissingAddrDialog(ctx);
    }
  }

  var bothReceivingAddresses;

  bool isPlaceMissing(Place place) => place == null || place.placesId.isEmpty;

  showPayDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        /*var isEmptyBCH = isAddressEmpty(getBCHAddress());
        var isEmptyDASH = isAddressEmpty(getDASHAddress());*/

        return AlertDialog(
          //title: Text("Pay now"),
          elevation: 10.0,
          titlePadding: EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 10.0),
          contentPadding: EdgeInsets.fromLTRB(35.0, 20.0, 30.0, 15.0),
          //content: Text("Dash or Bitcoin Cash?"),
          actions: [
            Dialogs.buildCloseDialogButton(context),
            TextButton(
              //TODO use new BUttonStyle once activate pay
              //shape: roundedRectangleBorder(),
              child: Text("DASH"),
              //color: isEmptyDASH ? Colors.blue.withOpacity(0.3) : Colors.blue,
              onPressed: () {
                closeChooseDialogAndShowAddressDialog(
                    context, buildAddressDetailDialogDASH);
              },
            ),
            TextButton(
              //shape: roundedRectangleBorder(),
              //color: isEmptyBCH ? Colors.green.withOpacity(0.3) : Colors.green,
              child: Text("BCH"),
              onPressed: () {
                closeChooseDialogAndShowAddressDialog(
                    context, buildAddressDetailDialogBCH);
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        );
      },
    );
  }

  void showMissingAddrDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              actions: [Dialogs.buildCloseDialogButton(context)],
              title: Text("Missing address",
                  style: TextStyle(color: Colors.white)),
              content: new InkWell(
                  child: Text(
                      "This merchant has not yet provided any payment receiving address!\n\nInformation can be provided to trbc@bitcoinmap.cash"),
                  onTap: () async {
                    /*Toaster.showToastLaunchingEmailClient()
                  UrlLauncher.launchEmailClientUpdatePaymentDetails(merchant, () {
                    Toaster.showToastEmailNotConfigured();
                  });*/
                    //TODO show dialog that there was not found any supported email client and forward the user to a sign up form
                    //TODO forward the user to the new app for moderators
                  }));
        });
  }

  RoundedRectangleBorder roundedRectangleBorder() {
    return RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)));
  }

  void closeChooseDialogAndShowAddressDialog(BuildContext context, method) {
    //Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: method,
    );
  }

  Widget buildAddressDetailDialogDASH(BuildContext context) {
    var data = getDASHAddress();
    if (isAddressEmpty(data)) {
      return AlertDialog(
        content: Text(
            "This merchant does not yet accept DASH payments, please pay with BCH or explain the benefits of accepting DASH to the merchant!"),
        actions: <Widget>[Dialogs.buildCloseDialogButton(context)],
      );
    } else
      return AlertDialog(
          title: Text("DASH (donate to dashboost.org)",
              style: TextStyle(color: Colors.white)),
          content: new InkWell(
              child: new Text(data),
              onTap: () {
                copyAddressToClipAndShowDialog(data, context);
                UrlLauncher.launchURI(data);
                //launch(data);
              }),
          actions: [Dialogs.buildCloseDialogButton(context)]);
  }

  getDASHAddress() => bothReceivingAddresses.split(",")[1];
}
