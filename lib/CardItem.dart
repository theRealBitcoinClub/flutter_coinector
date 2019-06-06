import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'CustomBoxShadow.dart';
import 'Dialogs.dart';
import 'ItemInfoStackLayer.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'RatingWidgetBuilder.dart';
import 'Toaster.dart';
import 'UrlLauncher.dart';

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

  FlatButton buildSendEmailButton(BuildContext ctx) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.alternate_email),
          Text(FlutterI18n.translate(ctx, "send_email"))
        ],
      ),
      onPressed: () {
        Navigator.of(ctx).pop();
        UrlLauncher.launchEmailClientUpdatePaymentDetails(ctx, merchant, () {
          Toaster.showToastEmailNotConfigured(ctx);
        });
      },
    );
  }

  void showPlaceNotFoundOnGmaps(ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext buildCtx) {
          return AlertDialog(
            actions: [
              buildSendEmailButton(buildCtx),
              Dialogs.buildCloseDialogButton(buildCtx)
            ],
            //TODO Optimize by offering a form to submit the data
            title: Text(
                FlutterI18n.translate(buildCtx, "dialog_missing_gmaps_title"),
                style: TextStyle(color: Colors.white)),
            content: Text(
                FlutterI18n.translate(buildCtx, "dialog_help_grow_adoption")),
          );
        });
  }

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
          margin:
              EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 20.0),
          elevation: 0.0,
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
    var gifUrl =
        'https://github.com/theRealBitcoinClub/BITCOINMAP.CASH---Browser-PWA/raw/master/public/img/app/' +
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
              margin: EdgeInsets.all(0.0),
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
                merchant: merchant,
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
                    merchant.distance.toString(),
                    style: textStyle2,
                  ),
                )
              : Container(),
        ),
        RatingWidgetBuilder.hasReviews(merchant)
            ? Positioned(
                right: 0.0,
                bottom: 5.0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Colors.grey[900].withOpacity(0.8)),
                  child:
                      RatingWidgetBuilder.buildRatingWidgetIfReviewsAvailable(
                          merchant, Theme.of(ctx).textTheme.body2),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  String getServerId() {
    return (merchant.serverId.contains('-')
        ? merchant.serverId.split('-')[0]
        : merchant.serverId);
  }

  Widget onLoadImageFailed() {
    final img = "assets/placeholder640x480.jpg";
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
          padding: EdgeInsets.all(10.0),
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.end,
            children: <Widget>[
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
          Dialogs.buildIcon(Icons.directions_run, Colors.white),
          Dialogs.buildSpacer(),
          Text(
            FlutterI18n.translate(context, 'VISIT'),
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
      onPressed: () {
        if (merchant.place == null) {
          UrlLauncher.launchCoordinatesUrl(context, merchant);
        } else {
          UrlLauncher.launchVisitUrl(context, merchant);
        }
      },
    );
  }

  void handleReviewClick(ctx) async {
    if (merchant.place == null) {
      showPlaceNotFoundOnGmaps(ctx);
      return;
    }
    UrlLauncher.launchReviewUrl(ctx, merchant.place);
  }

  FlatButton buildFlatButtonReview(BuildContext ctx) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(Icons.rate_review,
              Dialogs.getToggleColor(merchant.place != null)),
          Dialogs.buildSpacer(),
          Text(
            FlutterI18n.translate(ctx, 'REVIEW'),
            style: TextStyle(
                color: Dialogs.getToggleColor(merchant.place != null)),
          )
        ],
      ),
      onPressed: () {
        handleReviewClick(ctx);
      },
    );
  }
}
