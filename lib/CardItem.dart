import 'package:Coinector/TabPageCategory.dart';
import 'package:Coinector/TagBrands.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/translator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/widgets/I18nText.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'AddNewPlaceWidget.dart';
import 'AssetLoader.dart';
import 'CustomBoxShadow.dart';
import 'Dialogs.dart';
import 'ItemInfoStackLayer.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'RatingWidgetBuilder.dart';
import 'Toaster.dart';
import 'UrlLauncher.dart';

class CardItem extends StatelessWidget {
  //final bool isDataSaveOfflineMode;
  final TagFilterCallback tagFilterCallback;
  final int index;
  final Animation<double> animation;
  final Merchant merchant;
  final bool selected;
  final bool isWebMobile;

  double getItemInfoHeight() {
    return isWebMobile
        ? 85
        : kIsWeb
            ? 75
            : 80;
  }

  const CardItem({
    Key key,
    @required this.animation,
    @required this.index,
    @required this.merchant,
    @required this.tagFilterCallback,
    @required this.isWebMobile,
    this.selected: false,
    /*this.isDataSaveOfflineMode: false*/
  })  : assert(animation != null),
        assert(merchant != null),
        assert(index != null),
        super(key: key);

  TextButton buildSendEmailButton(BuildContext ctx) {
    return TextButton(
      child: Row(
        children: <Widget>[Icon(Icons.alternate_email), I18nText("send_email")],
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
            title: I18nText("dialog_missing_gmaps_title",
                child: Text("", style: TextStyle(color: Colors.white))),
            content: I18nText("dialog_help_grow_adoption"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleBody1 = Theme.of(context).textTheme.bodyText1;
    TextStyle textStyleBody2 = Theme.of(context).textTheme.bodyText2;

    /*final infoBoxBackgroundColor =
        MyColors.getCardInfoBoxBackgroundColor(merchant.type).withOpacity(1.0);
    final actionButtonBackgroundColor = Colors.grey[900].withOpacity(0.0);*/
    return SizedBox(
      child: Card(
          clipBehavior: Clip.none,
          margin:
              EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 20.0),
          elevation: 0.0,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              buildContentStack(
                  context, textStyleBody1, textStyleBody2, tagFilterCallback),
              buildButtonTheme(context),
            ],
          )),
    );
  }

  Widget buildContentStack(BuildContext ctx, TextStyle textStyle,
      TextStyle textStyle2, TagFilterCallback tagFilterCallback) {
    var imgUrl =
        'https://raw.githubusercontent.com/theRealBitcoinClub/bmap_gif/main/' +
            merchant.id +
            ".gif";

    if (merchant.id.startsWith("ChI"))
      imgUrl =
          "https://raw.githubusercontent.com/theRealBitcoinClub/bmap_webp/main/jpg/" +
              merchant.id +
              ".jpg";

    if (!kReleaseMode) print("\n" + imgUrl);

    var backGroundColor = Colors.grey[900].withOpacity(0.80);
    return Stack(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            child: kReleaseMode
                ? buildImageContainer(imgUrl, ctx)
                : buildPlaceHolderOfflineVersion(ctx)),
        buildStackInfoTextWithBackgroundAndShadow(
            backGroundColor, textStyle, textStyle2, tagFilterCallback),
        buildPositionedContainerDistance(ctx, backGroundColor, textStyle2),
        buildPositionedContainerBrand(ctx, backGroundColor, textStyle2),
        buildPositionedContainerAcceptedCoins(backGroundColor, ctx, textStyle2),
        RatingWidgetBuilder.hasReviews(merchant)
            ? buildPositionedContainerReviews(backGroundColor, ctx)
            : SizedBox(),
      ],
    );
  }

  SizedBox buildPlaceHolderOfflineVersion(ctx) {
    return SizedBox(
      height: 160,
      width: 640,
      child: DecoratedBox(
        /*child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                //child: GestureDetector(
                //  onTap: onTapActivateOnlineMode(ctx),
                child: Text(
                  "Offline Data Saver Mode or Image missing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54),
                  textScaleFactor: 0.9,
                ))), //),*/
        decoration: BoxDecoration(color: Colors.grey[900]),
      ),
    );
  }

  Widget buildImageContainer(String imgUrl, BuildContext ctx) {
    bool isGif = imgUrl.endsWith("gif");
    double jpgHeightWeb = 360;
    double imgHeight = kIsWeb
        ? isWebMobile
            ? isGif
                ? 260
                : jpgHeightWeb
            : isGif
                ? 280
                : jpgHeightWeb
        : isGif
            ? 228
            : jpgHeightWeb - 40;
    double imgWidth = 640;
    return Stack(children: <Widget>[
      SizedBox(
          height: 160,
          width: imgWidth,
          child: Align(
            alignment: Alignment.bottomCenter,
            //child: GestureDetector(
            //  onTap: () => onTapActivateDataSaverOfflineMode(ctx),
            child: LoadingBouncingLine.circle(
              size: 32.0,
              borderSize: 5.0,
              borderColor: Colors.grey[800],
              backgroundColor: Colors.white24,
            ),
          )), //),
      FadeInImage.memoryNetwork(
        imageErrorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return buildPlaceHolderOfflineVersion(ctx);
        },
        placeholderErrorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return buildPlaceHolderOfflineVersion(ctx);
        },
        fadeInCurve: Curves.decelerate,
        fit: BoxFit.fitWidth,
        fadeInDuration: Duration(milliseconds: 500),
        placeholder: kTransparentImage,
        image: imgUrl,
        width: imgWidth,
        height: imgHeight,
        alignment: Alignment.center,
      )
    ]);
  }

  Stack buildStackInfoTextWithBackgroundAndShadow(
      Color backGroundColor,
      TextStyle textStyle,
      TextStyle textStyle2,
      TagFilterCallback tagFilterCallback) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(0.0),
          height: getItemInfoHeight(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                CustomBoxShadow(
                    color: backGroundColor.withOpacity(1),
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.0),
                    blurStyle: BlurStyle.outer)
              ],
              color: backGroundColor),
        ),
        ItemInfoStackLayer(
          filterCallback: tagFilterCallback,
          merchant: merchant,
          textStyleMerchantTitle: textStyle,
          textStyleMerchantLocation: textStyle2,
          height: getItemInfoHeight(),
          isWebMobile: isWebMobile,
        )
      ],
    );
  }

  Positioned buildPositionedContainerBrand(
      BuildContext ctx, Color backGroundColor, TextStyle textStyle2) {
    return Positioned(
      left: 0.0,
      bottom: 33,
      child: merchant.brand != null
          ? Container(
              padding: EdgeInsets.fromLTRB(8.8, 5.0, 10.0, 4.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: buildRadius(), bottomRight: buildRadius()),
                  color: backGroundColor),
              child: Text(TagBrand.getBrands().elementAt(merchant.brand).long,
                  style: TextStyle(color: Colors.white70)),
            )
          : Container(),
    );
  }

  Positioned buildPositionedContainerAcceptedCoins(
      Color backGroundColor, BuildContext ctx, TextStyle tStyle) {
    return Positioned(
      left: 0.0,
      bottom: 4,
      child: merchant.acceptedCoins != null
          ? Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: buildRadius(), bottomRight: buildRadius()),
                  color: backGroundColor),
              child: Wrap(
                spacing: 10.0,
                children: merchant.acceptedCoins
                    .split(",")
                    .map((e) => Text(
                          TagCoin.getTagCoins().elementAt(int.parse(e)).short,
                          style: tStyle.copyWith(fontWeight: FontWeight.bold),
                        ))
                    .toList(),
              ),
            )
          : Container(),
    );
  }

  Positioned buildPositionedContainerDistance(
      BuildContext ctx, Color backGroundColor, TextStyle textStyle2) {
    return Positioned(
      right: 0.0,
      bottom: 33,
      child: merchant.distance != null
          ? GestureDetector(
              onTap: () {
                _handleButtonVisit(ctx);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: buildRadius(), bottomLeft: buildRadius()),
                    color: backGroundColor),
                child: Text(
                  merchant.distance.toString(),
                  style: textStyle2,
                ),
              ))
          : Container(),
    );
  }

  Positioned buildPositionedContainerReviews(
      Color backGroundColor, BuildContext ctx) {
    return Positioned(
        right: 0.0,
        bottom: 4,
        child: GestureDetector(
          onTap: () {
            handleReviewClick(ctx);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: buildRadius(), bottomLeft: buildRadius()),
                color: backGroundColor),
            child: RatingWidgetBuilder.buildRatingWidgetIfReviewsAvailable(
                merchant, Theme.of(ctx).textTheme.bodyText2),
          ),
        ));
  }

  Radius buildRadius() => Radius.circular(10);

  //TODO use REGEX to improve searchalgorithm, search for matched words instead of matched anything "gin" or identify tags and dont searcg
  //TODO get data from places ip to accelerate search on addresses with all zipcpde search, cities and states

  String getServerId() {
    return (merchant.serverIdOrFileName.contains('-')
        ? merchant.serverIdOrFileName.split('-')[0]
        : merchant.serverIdOrFileName);
  }

  Container buildGradientContainer(Color infoBoxBackgroundColor) {
    return Container(
      height: getItemInfoHeight(),
      decoration: BoxDecoration(
        color: infoBoxBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }

  Container buildButtonTheme(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            CustomBoxShadow(
                color: Colors.black.withOpacity(0.65),
                blurRadius: 1.0,
                offset: Offset(0.0, 0.0),
                blurStyle: BlurStyle.outer)
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0)),
          color: Colors.grey[900].withOpacity(0.1)),
      child: buildButtons(context),
    );
  }

  ButtonBarTheme buildButtons(BuildContext context) {
    return ButtonBarTheme(
        data: ButtonBarThemeData(),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ButtonBar(
              buttonPadding:
                  EdgeInsets.fromLTRB(0.0, 10.0, kIsWeb ? 25.0 : 12.0, 10.0),
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                kIsWeb ? SizedBox() : buildTextButtonManager(context),
                buildTextButtonShare(context),
                kIsWeb ? SizedBox() : buildTextButtonReview(context),
                buildTextButtonVisit(context),
              ],
            )));
  }

  TextButton buildTextButtonVisit(BuildContext context) {
    return TextButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(Icons.directions_run, Colors.white),
          Dialogs.buildSpacer(),
          Text(
            Translator.translate(context, 'VISIT'),
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
      onPressed: () {
        _handleButtonVisit(context);
      },
    );
  }

  void _handleButtonVisit(BuildContext context) {
    if (merchant.place == null) {
      loadPlace(() {
        if (merchant.place == null) {
          UrlLauncher.launchCoordinatesUrl(context, merchant);
        } else {
          UrlLauncher.launchVisitUrl(context, merchant);
        }
      });
    } else {
      UrlLauncher.launchVisitUrl(context, merchant);
    }
  }

  void loadPlace(afterLoadCallback) async {
    new AssetLoader().loadPlace(merchant.id).then((place) {
      if (place == null) return;
      merchant.place = place;
      afterLoadCallback();
    });
  }

  void handleReviewClick(ctx) async {
    if (merchant.place == null) {
      loadPlace(() {
        if (merchant.place == null)
          debugPrint("MISSING PLACE ID");
        // showPlaceNotFoundOnGmaps(ctx);
        else
          UrlLauncher.launchReviewUrl(ctx, merchant.place);
      });
    } else {
      UrlLauncher.launchReviewUrl(ctx, merchant.place);
    }
  }

  TextButton buildTextButtonManager(BuildContext ctx) {
    return TextButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(Icons.update, Colors.white),
          Dialogs.buildSpacer(),
          Text(
            Translator.translate(ctx, 'UPDATE'),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onPressed: () {
        if (merchant.place == null) {
          loadPlace(() {
            if (merchant.place != null) {
              launchAddNewPlaceWithPlacesId(ctx);
            }
          });
        } else {
          launchAddNewPlaceWithPlacesId(ctx);
        }
      },
    );
  }

  void launchAddNewPlaceWithPlacesId(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (buildCtx) {
      int type = merchant.type;
      return AddNewPlaceWidget(
        pId: merchant.place.placesId,
        selectedType: type,
        accentColor: MyColors.getTabColor(type),
        actionBarColor: MyColors.getCardActionButtonBackgroundColor(type),
        typeTitle: TabPages.pages.elementAt(type).long,
      );
    }));
  }

  TextButton buildTextButtonShare(BuildContext ctx) {
    return TextButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(Icons.share, Colors.white),
          Dialogs.buildSpacer(),
          Text(
            Translator.translate(ctx, 'SHARE'),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onPressed: () {
        if (kIsWeb) {
          UrlLauncher.launchURI("https://coinector.app/share.html?search=" +
              Uri.encodeComponent(merchant.name) +
              "&location=" +
              Uri.encodeComponent(merchant.location));
          return;
        }
        Share.share(
            'https://coinector.app/#/' + Uri.encodeComponent(merchant.name),
            subject: 'Coinector - coinecting to coimunity...');
      },
    );
  }

  TextButton buildTextButtonReview(BuildContext ctx) {
    return TextButton(
      child: Column(
        children: <Widget>[
          Dialogs.buildIcon(Icons.rate_review, Colors.white),
          Dialogs.buildSpacer(),
          Text(
            Translator.translate(ctx, 'REVIEW'),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onPressed: () {
        handleReviewClick(ctx);
      },
    );
  }

  //TODO ACTIVATE DATA SAVE MODE ON TOUCH OF LOADER THEN DEACTIVATE ON TOUCH OF TEXTHINT
  /*persistDataSaverOfflineMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("sjlfsjlfjsjnwfuinsnvsdjnvsn", true);
  }

  removeDataSaverOfflineMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("sjlfsjlfjsjnwfuinsnvsdjnvsn");
  }

  onTapActivateDataSaverOfflineMode(ctx) {
    persistDataSaverOfflineMode();
    //Phoenix.rebirth(ctx);
  }

  onTapActivateOnlineMode(ctx) {
    removeDataSaverOfflineMode();
    //Phoenix.rebirth(ctx);
  }*/
}
