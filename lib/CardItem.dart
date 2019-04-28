import 'package:endlisch/AssetLoader.dart';
import 'package:endlisch/Place.dart';
import 'package:endlisch/MyColors.dart';
import 'package:endlisch/RatingWidgetBuilder.dart';
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
      @required this.merchant,
      this.selected: false})
      : assert(animation != null),
        assert(merchant != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  //final VoidCallback onTap;
  final Merchant merchant;
  final bool selected;
  final double itemHeight = 100;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle textStyle2 = Theme.of(context).textTheme.body2;

    final infoBoxBackgroundColor =
        MyColors.getCardInfoBoxBackgroundColor(merchant.type);
    final actionButtonBackgroundColor =
        MyColors.getCardActionButtonBackgroundColor(merchant.type);
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
/*/TODO load placeholder
  loadPlaceHolder() {
    rootBundle.load('assets/placeholder640x480.png').then((data) {
      return data.buffer.asUint8List();
    });
  }*/

  Stack buildContentStack(
      Color infoBoxBackgroundColor, TextStyle textStyle, TextStyle textStyle2) {
    var gifUrl = "https://realbitcoinclub-" +
        (merchant.serverId.contains('-')
            ? merchant.serverId.split('-')[0]
            : merchant.serverId) +
        ".firebaseapp.com/gif/" +
        merchant.id +
        ".gif";

    var img;

    //try {
    img = FadeInImage.memoryNetwork(
      //TODO add sexy fadeinCurvee
      fit: BoxFit.contain,
      fadeInDuration: Duration(milliseconds: 300),
      placeholder: kTransparentImage,
      //TODO load images from splitted servers
      //TODO add images, add placeholder for currently missing images
      //TODO add placeholder image with first frame of animation
      //TODO offer low data version which only shows one image and loads more images on tap of carditem
      image: gifUrl,
      height: 320,
      alignment: Alignment.bottomCenter,
    );
    //} catch (e) {
    //TODO add fallback if image can not be loaded or internet connection is not available
    //  img = Image.asset("assets/placeholder640x480.png");
    //}

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0.0),
          child: img,
        ),
        Stack(
          children: <Widget>[
            buildGradientContainer(infoBoxBackgroundColor),
            Container(
              height: itemHeight,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            ),
            ItemInfoStackLayer(
                item: merchant,
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
          /*GestureDetector(

              onTap: () {
                handleReviewClick(context, merchant);
              }, //TODO Navigate to give a rating
              child:*/
          Row(
              children: <Widget>[
            RatingWidgetBuilder.buildRatingWidgetIfReviewsAvailable(
                merchant, Theme.of(context).textTheme.body2),
            SizedBox(
              width: 20,
            )
          ]),
          buildFlatButtonPay(context),
          buildFlatButtonReview(context),
          buildFlatButtonVisit(context),
        ],
      ),
    );
  }

  FlatButton buildFlatButtonVisit(BuildContext context) {
    return FlatButton(
          child: Column(
            children: <Widget>[
              buildIcon(Icons.directions_run,
                  getToggleColor(merchant.place != null)),
              buildSpacer(),
              Text(
                'VISIT',
                style: TextStyle(
                    fontSize: 14,
                    color: getToggleColor(merchant.place != null)),
              )
            ],
          ),
          onPressed: () {
            if (merchant.place == null) {
              showPlaceNotFoundOnGmaps(context);
              return;
            }
            launchVisitUrl(context, merchant.place);
          },
        );
  }

  FlatButton buildFlatButtonPay(BuildContext context) {
    return FlatButton(
          child: Column(
            children: <Widget>[
              buildIcon(Icons.payment, getToggleColor(merchant.isPayEnabled)),
              buildSpacer(),
              Text('PAY',
                  style:
                      TextStyle(color: getToggleColor(merchant.isPayEnabled)))
            ],
          ),
          onPressed: () {
            handlePayButton(context);
          },
        );
  }

  FlatButton buildFlatButtonReview(BuildContext context) {
    return FlatButton(
          child: Column(
            children: <Widget>[
              buildIcon(
                  Icons.rate_review, getToggleColor(merchant.place != null)),
              buildSpacer(),
              Text(
                'REVIEW',
                style:
                    TextStyle(color: getToggleColor(merchant.place != null)),
              )
            ],
          ),
          onPressed: () {
            handleReviewClick(context, merchant);
          },
        );
  }

  Future handlePayButton(BuildContext context) async {
    bothReceivingAddresses =
        await AssetLoader.loadReceivingAddress(merchant.id);
    if (merchant.isPayEnabled)
      showPayDialog(context);
    else {
      showMissingAddrDialog(context);
    }
  }

  Color getToggleColor(isEnabled) => isEnabled ? Colors.white : Colors.white54;

  Icon buildIcon(final icon, final color) => Icon(
        icon,
        size: 25,
        color: color,
      );

  SizedBox buildSpacer() {
    return const SizedBox(
      height: 5,
    );
  }
}

var bothReceivingAddresses;

//TODO setup various servers to host images, for each dataset one
launchVisitUrl(context, place) async {
  var url = 'https://goo.gl/maps/' + place.shareId;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    //TODO show a message to the user, his internet connection might be off
    throw 'Could not launch $url';
  }
}

launchReviewUrl(context, place) async {
  var url =
      'https://search.google.com/local/writereview?placeid=' + place.placesId;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

bool isPlaceMissing(Place place) => place == null || place.placesId.isEmpty;

void showPlaceNotFoundOnGmaps(context) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          actions: [buildCloseDialogButton(ctx)],
          //TODO Optimize by offering a form to submit the data
          title: Text("Missing Google Maps link!"),
          content: Text(
              "Help to grow adoption!\n\nSend the missing information to:\n\nbitcoinmap.cash@protonmail.com"),
        );
      });
} //TODO Fix textoverflow

showPayDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var isEmptyBCH = isAddressEmpty(getBCHAddress());
      var isEmptyDASH = isAddressEmpty(getDASHAddress());

      return AlertDialog(
        //title: Text("Pay now"),
        elevation: 10.0,
        titlePadding: EdgeInsets.fromLTRB(30.0, 25.0, 30.0, 10.0),
        contentPadding: EdgeInsets.fromLTRB(35.0, 20.0, 30.0, 15.0),
        //content: Text("Dash or Bitcoin Cash?"),
        actions: [
          buildCloseDialogButton(context),
          FlatButton(
            shape: roundedRectangleBorder(),
            child: Text("DASH"),
            color: isEmptyDASH ? Colors.blue.withOpacity(0.3) : Colors.blue,
            onPressed: () {
              closeChooseDialogAndShowAddressDialog(
                  context, buildAddressDetailDialogDASH);
            },
          ),
          FlatButton(
            shape: roundedRectangleBorder(),
            color: isEmptyBCH ? Colors.green.withOpacity(0.3) : Colors.green,
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
                    "This merchant has not yet provided any payment receiving address!\n\nExplain to the merchant the benefits of providing an address!\n\nTouch here to send an email to:\n\nbitcoinmap.cash@protonmail.com"),
                onTap: () async {
                  var urlString =
                      "mailTo:bitcoinmap.cash@protonmail.com?subject=Coinecccctorrrrr";
                  var hasEmailClient = await canLaunch(urlString);
                  if (hasEmailClient) {
                    await launch(urlString);
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
          "This merchant does not yet accept DASH payments, please pay with BCH or explain the benefits of accepting BCH to the merchant!"),
      actions: <Widget>[buildCloseDialogButton(context)],
    );
  } else
    return AlertDialog(
        title: Text("DASH (donate to dashboost.org)"),
        content: new InkWell(
            child: new Text(data),
            onTap: () {
              copyAddressToClipAndShowDialog(data, context);
              //launch(data);
            }),
        actions: [buildCloseDialogButton(context)]);
}

getDASHAddress() => bothReceivingAddresses.split(",")[1];

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
  var data = getBCHAddress();
  if (isAddressEmpty(data)) {
    return AlertDialog(
      content: Text(
          "This merchant does not yet accept BCH payments, please pay with DASH or explain the benefits of accepting BCH to the merchant!"),
      actions: <Widget>[buildCloseDialogButton(context)],
    );
  } else
    return AlertDialog(
      title: Text("BCH (donate to coinspice.io)"),
      actions: [buildCloseDialogButton(context)],
      content: new InkWell(
          child: new Text(getBCHAddress()),
          onTap: () {
            copyAddressToClipAndShowDialog(data, context);
            //launch(data);
          }),
    );
}

bool isAddressEmpty(data) => data == '-';

getBCHAddress() => bothReceivingAddresses.split(",")[0];

void copyAddressToClipAndShowDialog(String data, BuildContext context) {
  //Navigator.of(context).pop();
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

void handleReviewClick(context, merchant) async {
  if (merchant.place == null) {
    showPlaceNotFoundOnGmaps(context);
    return;
  }
  launchReviewUrl(context, merchant.place);
}
