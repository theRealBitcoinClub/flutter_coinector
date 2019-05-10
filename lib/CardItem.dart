import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:coinector/AssetLoader.dart';
import 'package:coinector/CustomBoxShadow.dart';
import 'package:coinector/MyColors.dart';
import 'package:coinector/Place.dart';
import 'package:coinector/RatingWidgetBuilder.dart';
import 'package:coinector/UrlLauncher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ItemInfoStackLayer.dart';
import 'Merchant.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:geolocator/geolocator.dart';

class CardItem extends StatelessWidget {
  final Position position;

  const CardItem(
      {Key key,
      @required this.animation,
      //  this.onTap,
      @required this.merchant,
      this.position,
      this.selected: false})
      : assert(animation != null),
        assert(merchant != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final Merchant merchant;
  final bool selected;
  final double itemHeight = 95;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleBody1 = Theme.of(context).textTheme.body1;
    TextStyle textStyleBody2 = Theme.of(context).textTheme.body2;

    final infoBoxBackgroundColor =
        MyColors.getCardInfoBoxBackgroundColor(merchant.type).withOpacity(1.0);
    final actionButtonBackgroundColor =
        MyColors.getCardActionButtonBackgroundColor(merchant.type)
            .withOpacity(0.8);
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
              buildContentStack(context, infoBoxBackgroundColor, textStyleBody1,
                  textStyleBody2),
              buildButtonTheme(context),
            ],
          )),
    );
  }

  Stack buildContentStack(BuildContext ctx, Color infoBoxBackgroundColor,
      TextStyle textStyle, TextStyle textStyle2) {
    var gifUrl = "http://realbitcoinclub-" +
        getServerId() +
        ".firebaseapp.com/gif/" +
        merchant.id +
        ".gif";

    return Stack(
      children: <Widget>[
        Positioned(
          top: 180.0,
          left: MediaQuery.of(ctx).size.width / 2 - 20,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: FadeInImage.memoryNetwork(
            fadeInCurve: Curves.decelerate,
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: kTransparentImage,
            image: gifUrl,
            height: 320,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Stack(
          children: <Widget>[
            buildGradientContainer(Colors.grey[900]),
            Container(
              height: itemHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(30, 15),
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  boxShadow: [
                    CustomBoxShadow(
                        color: infoBoxBackgroundColor.withOpacity(0.5),
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.0),
                        blurStyle: BlurStyle.outer)
                  ],
                  color: Colors.grey[900].withOpacity(0.8)),
            ),
            ItemInfoStackLayer(
                item: merchant,
                textStyleMerchantTitle: textStyle,
                textStyleMerchantLocation: textStyle2,
                height: itemHeight)
          ],
        ),
        Positioned(
          left: 0.0,
          bottom: 5.0,
          child: merchant.distance != null
              ? Container(
                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.grey[900].withOpacity(0.8)),
                  child: Text(
                    merchant.distance != null
                        ? merchant.distance.toString()
                        : "",
                    style: textStyle2,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  String getServerId() {
    return (merchant.serverId.contains('-')
        ? merchant.serverId.split('-')[0]
        : merchant.serverId);
  }

  Widget loadImage(String gifUrl) {
    var img;
    /*try {
      /*img = Image(
        image: AdvancedNetworkImage(
          gifUrl,
          //TODO is header necessary? header: "",
          header:  {'':''},
          fallbackAssetImage: "assets/placeholder640x480.png",
          useDiskCache: true,
          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
        ),
        fit: BoxFit.cover,
      );*/
      img = FadeInImage.memoryNetwork(
        fadeInCurve: Curves.decelerate,
        fit: BoxFit.contain,
        fadeInDuration: Duration(milliseconds: 500),
        placeholder: kTransparentImage,
        //TODO offer low data version which only shows one image and loads more images on tap of carditem
        image: gifUrl,
        height: 320,
        alignment: Alignment.bottomCenter,
      );
    } catch (e) {
      */
    //img = onLoadImageFailed();
    //}
    return img;
  }

  Widget onLoadImageFailed() {
    final img = "assets/placeholder640x480.png";
    return FadeInImage.assetNetwork(placeholder: img, image: img);
  }

  Container buildGradientContainer(Color infoBoxBackgroundColor) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.elliptical(30, 15)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //infoBoxBackgroundColor,
              infoBoxBackgroundColor,
              infoBoxBackgroundColor.withOpacity(0.95),
              infoBoxBackgroundColor.withOpacity(0.9),
              infoBoxBackgroundColor.withOpacity(0.8),
              infoBoxBackgroundColor.withOpacity(0.7),
              infoBoxBackgroundColor.withOpacity(0.6),
              infoBoxBackgroundColor.withOpacity(0.5),
            ]),
      ),
    );
  }

  Container buildButtonTheme(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            CustomBoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurRadius: 1.0,
                offset: Offset(0.0, 0.0),
                blurStyle: BlurStyle.outer)
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(15, 15),
              bottomLeft: Radius.elliptical(15, 15)),
          color: Colors.grey[900].withOpacity(0.1)),
      child: ButtonTheme.bar(
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
                color: Colors.white, width: 1.0, style: BorderStyle.solid)),*/
          //splashColor: Colors.white,
          padding: EdgeInsets.all(10.0),
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              /*GestureDetector(

              onTap: () {
                handleReviewClick(context, merchant);
              },
              child:*/
              //buildFlatButtonPay(context),
              Row(children: <Widget>[
                RatingWidgetBuilder.buildRatingWidgetIfReviewsAvailable(
                    merchant, Theme.of(context).textTheme.body2),
                SizedBox(
                  width: 10.0,
                )
              ]),
              buildFlatButtonReview(context),
              buildFlatButtonVisit(context),
            ],
          )),
    );
  }

  FlatButton buildFlatButtonVisit(BuildContext context) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          buildIcon(
              Icons.directions_run, getToggleColor(merchant.place != null)),
          buildSpacer(),
          Text(
            'VISIT',
            style: TextStyle(
                fontSize: 14, color: getToggleColor(merchant.place != null)),
          )
        ],
      ),
      onPressed: () {
        if (merchant.place == null) {
          showPlaceNotFoundOnGmaps(context);
          return;
        }
        UrlLauncher.launchVisitUrl(context, merchant.place);
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
              style: TextStyle(color: getToggleColor(merchant.isPayEnabled)))
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
          buildIcon(Icons.rate_review, getToggleColor(merchant.place != null)),
          buildSpacer(),
          Text(
            'REVIEW',
            style: TextStyle(color: getToggleColor(merchant.place != null)),
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

bool isPlaceMissing(Place place) => place == null || place.placesId.isEmpty;

void showPlaceNotFoundOnGmaps(context) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          actions: [buildCloseDialogButton(ctx)],
          //TODO Optimize by offering a form to submit the data
          title: Text("Missing Google Maps link!",
              style: TextStyle(color: Colors.white)),
          content: Text(
              "Help to grow adoption!\n\nSend the missing information to:\n\ntrbc@bitcoinmap.cash"),
        );
      });
}

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
            title:
                Text("Missing address", style: TextStyle(color: Colors.white)),
            content: new InkWell(
                child: Text(
                    "This merchant has not yet provided any payment receiving address!\n\nExplain to the merchant the benefits (Proof of Adoption) of providing an address and touch here to send an email to:\n\ntrbc@bitcoinmap.cash"),
                onTap: () async {
                  /*copyAddressToClipAndShowDialog(
                      "trbc@bitcoinmap.cash", context);
                  UrlLauncher.launchEmailClient(() {
                    showAboutDialog(
                        context: context,
                        applicationName: "Coinector",
                        applicationVersion: "v1.2.0",
                        applicationIcon:
                            Image.asset("assets/placeholder640x480.png"),
                        children: [Text("trbc@bitcoinmap.cash")]);

                    //TODO show dialog that there was not found any supported email client and forward the user to a sign up form
                  });*/
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
        title: Text("DASH (donate to dashboost.org)",
            style: TextStyle(color: Colors.white)),
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
      title: Text("BCH (donate to coinspice.io)",
          style: TextStyle(color: Colors.white)),
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
            title: Text("Copied to clipboard!",
                style: TextStyle(color: Colors.white)),
          );
        });
  });
}

void handleReviewClick(context, merchant) async {
  if (merchant.place == null) {
    showPlaceNotFoundOnGmaps(context);
    return;
  }
  UrlLauncher.launchReviewUrl(context, merchant.place);
}
