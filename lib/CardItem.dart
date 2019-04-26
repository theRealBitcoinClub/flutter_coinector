import 'package:endlisch/AssetLoader.dart';
import 'package:endlisch/Place.dart';
import 'package:endlisch/main.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:endlisch/MyColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Merchant.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ItemInfoStackLayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      //  this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  //final VoidCallback onTap;
  final Merchant item;
  final bool selected;
  final double itemHeight = 100;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle textStyle2 = Theme.of(context).textTheme.body2;

    final infoBoxBackgroundColor =
        MyColors.getCardInfoBoxBackgroundColor(item.type);
    final actionButtonBackgroundColor =
        MyColors.getCardActionButtonBackgroundColor(item.type);
    return SizedBox(
      child: Card(
          clipBehavior: Clip.none,
          margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: actionButtonBackgroundColor,
          child: Column(
            children: <Widget>[
              buildContentStack(infoBoxBackgroundColor, textStyle, textStyle2),
              buildButtonTheme(context),
            ],
          )),
    );
  }

  Stack buildContentStack(
      Color infoBoxBackgroundColor, TextStyle textStyle, TextStyle textStyle2) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0.0),
          child: FadeInImage.memoryNetwork(
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 300),
            placeholder: kTransparentImage,
            //TODO load images from splitted servers
            //TODO add placeholder image with first frame of animation
            //TODO offer low data version which only shows one image and loads more images on tap of carditem
            image: "https://realbitcoinclub.firebaseapp.com/img/app/" +
                item.id +
                ".gif",
            height: 320,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Stack(
          children: <Widget>[
            buildGradientContainer(infoBoxBackgroundColor),
            Container(
              height: itemHeight,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            ),
            ItemInfoStackLayer(
                item: item,
                textStyle: textStyle,
                textStyleSmall: textStyle2,
                height: itemHeight)
          ],
        ),
      ],
    );
  }

  Container buildGradientContainer(Color infoBoxBackgroundColor) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              infoBoxBackgroundColor,
              infoBoxBackgroundColor,
              infoBoxBackgroundColor.withOpacity(0.9),
              infoBoxBackgroundColor.withOpacity(0.75),
              infoBoxBackgroundColor.withOpacity(0.6)
            ]),
      ),
    );
  }

  ButtonTheme buildButtonTheme(BuildContext context) {
    return ButtonTheme.bar(
      padding: EdgeInsets.all(10.0),
      // make buttons use the appropriate styles for cards
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Column(
              children: <Widget>[
                buildIcon(Icons.rate_review),
                buildSpacer(),
                const Text(
                  'REVIEW',
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            onPressed: () {
              launchReviewUrl(item.id);
            },
          ),
          FlatButton(
            child: Column(
              children: <Widget>[
                buildIcon(Icons.payment),
                buildSpacer(),
                const Text('PAY')
              ],
            ),
            onPressed: () {
              showPayDialog(context, item.id);
            },
          ),
          FlatButton(
            child: Column(
              children: <Widget>[
                buildIcon(Icons.directions_run),
                buildSpacer(),
                const Text(
                  'VISIT',
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            onPressed: () {
              launchVisitUrl(item.id);
            },
          ),
        ],
      ),
    );
  }

  Icon buildIcon(final icon) => Icon(icon, size: 25);

  SizedBox buildSpacer() {
    return const SizedBox(
      height: 5,
    );
  }
}

//TODO setup various servers to host images, for each dataset one
launchVisitUrl(id) async {
  Place place = await AssetLoader.loadPlace(id);
  var url = 'https://goo.gl/maps/' + place.shareId;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchReviewUrl(id) async {
  Place place = await AssetLoader.loadPlace(id);
  //String place =  await AssetLoader.loadPlacesId(id);
  var url =
      'https://search.google.com/local/writereview?placeid=' + place.placesId;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

var addr;

showPayDialog(BuildContext context, String id) async {
  addr = await AssetLoader.loadReceivingAddress(id);

  if (addr.isEmpty) {
    showMissingAddrDialog(context);
  } else
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pay now"),
          elevation: 10.0,
          titlePadding: EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 10.0),
          contentPadding: EdgeInsets.fromLTRB(35.0, 20.0, 30.0, 15.0),
          content: Text("Dash or Bitcoin Cash?"),
          actions: [
            buildCloseDialogButton(context),
            FlatButton(
              shape: roundedRectangleBorder(),
              child: Text("DASH"),
              color: Colors.blue,
              onPressed: () {
                closeChooseDialogAndShowAddressDialog(
                    context, buildAddressDetailDialogDASH);
              },
            ),
            FlatButton(
              shape: roundedRectangleBorder(),
              color: Colors.green,
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
            actions: [buildCloseDialogButton(context)],
            title: Text("Missing address"),
            content: new InkWell(
                child: Text(
                    "This merchant has not yet provided any payment receiving address!\n\nTouch here to send an email to bitcoinmap.cash@protonmail.com"),
                onTap: () async {
                  var hasEmailClient = await canLaunch(
                      "mailTo:bitcoinmap.cash@protonmail.com?subject=Coinecccctorrrrr");
                  if (hasEmailClient) {
                    launch(
                        "mailTo:bitcoinmap.cash@protonmail.com?subject=Coinecccctorrrrr");
                  } else {
                    //TODO show dialog that there was not found any supported email client and forward the user to a sign up form
                  }
                }));
      });
}

RoundedRectangleBorder roundedRectangleBorder() {
  return RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(5.0)));
}

void closeChooseDialogAndShowAddressDialog(BuildContext context, method) {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: method,
  );
}

Widget buildAddressDetailDialogDASH(BuildContext context) {
  var data = addr.split(",")[1];
  if (data == '-') {
    return AlertDialog(
      content: Text(
          "This merchant does not yet accept DASH payments, please pay with BCH or explain the benefits of accepting BCH to the merchant!"),
      actions: <Widget>[buildCloseDialogButton(context)],
    );
  } else
    return AlertDialog(
        title: Text("DASH (touch address to pay)"),
        content: new InkWell(
            child: new Text(data),
            onTap: () {
              copyAddressToClipAndShowDialog(data, context);
              //launch(data);
            }),
        actions: [buildCloseDialogButton(context)]);
}

FlatButton buildCloseDialogButton(BuildContext context) {
  return FlatButton(
    child: Row(
      children: <Widget>[Icon(Icons.close), Text(' CLOSE')],
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}

Widget buildAddressDetailDialogBCH(BuildContext context) {
  var data = addr.split(",")[0];
  if (data == '-') {
    return AlertDialog(
      content: Text(
          "This merchant does not accept BCH payments, please pay with DASH or explain the benefits of accepting DASH to the merchant!"),
      actions: <Widget>[buildCloseDialogButton(context)],
    );
  } else
    return AlertDialog(
      title: Text("BCH (touch address to pay)"),
      actions: [buildCloseDialogButton(context)],
      content: new InkWell(
          child: new Text(data),
          onTap: () {
            copyAddressToClipAndShowDialog(data, context);
            //launch(data);
          }),
    );
}

void copyAddressToClipAndShowDialog(String data, BuildContext context) {
  Navigator.pop(context);
  ClipboardManager.copyToClipBoard(data).then((result) {
    showDialog(
        context: context,
        builder: (buildCtx) {
          return AlertDialog(
            content: Text(
                "Address was copied to clipboard!\n\nOpen your favorite Wallet to send a transaction.\n\nIf you have a compatible Wallet installed it should open now!\n\nClick here to install a compatible free Wallet."),
            title: Text("Copied to clipboard!"),
          );
        });
  });
}
