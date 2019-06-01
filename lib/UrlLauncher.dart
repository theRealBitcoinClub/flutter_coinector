import 'AddNewPlaceWidget.dart';

import 'package:url_launcher/url_launcher.dart';

import 'Merchant.dart';
import 'Toaster.dart';

class UrlLauncher {
  static void launchMapInBrowser() async {
    //LaunchReview.launch(androidAppId: "club.therealbitcoin.bchmap");
    //LaunchReview.launch();
    var url =
        'https://play.google.com/store/apps/details?id=club.therealbitcoin.bchmap';
    launchURI(url);
  }

  static void launchURI(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //TODO detect IPhone and forward them to bitcoinmap.cash
  //TODO use this plugin: https://pub.dartlang.org/packages/launch_review
  //LaunchReview.launch(writeReview: false,iOSAppId: "585027354");
  //LaunchReview.launch(androidAppId: "com.iyaffle.rangoli",
  //                    iOSAppId: "585027354");

  static void launchMapInPlayStoreFallbackToBrowser() async {
    var url = 'market://details?id=club.therealbitcoin.bchmap';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      launchMapInBrowser();
    }
  }

  static void launchReviewUrl(context, place) async {
    var url =
        'http://search.google.com/local/writereview?placeid=' + place.placesId;
    launchURI(url);
  }

  static void launchCoordinatesUrl(context, Merchant merchant) async {
    var url = buildGoogleMapsSearchQueryUrl(merchant);
    launchURI(url);
  }

  static String buildGoogleMapsSearchQueryUrl(Merchant merchant) =>
      'http://www.google.com/maps/search/?api=1&query=' +
      merchant.x +
      ',' +
      merchant.y;

  static void launchVisitUrl(context, Merchant merchant) async {
    var url = buildGoogleMapsSearchQueryUrl(merchant) +
        '&query_place_id=' +
        merchant.place.placesId;
    launchURI(url);
  }

  static String getDASHReceiverAdr(hasInput) {
    return hasInput ? ",en-dash@therealbitcoin.club" : "";
  }

  static String getBCHReceiverAdr(hasInput) {
    return hasInput ? ",en-bch@therealbitcoin.club" : "";
  }

  static void launchEmailClientAddPlace(String inputDASH, String inputBCH,
      String content, onEmailClientNotFound) async {
    var urlString =
        "mailto:bitcoinmap@fire.fundersclub.com,incoming+bmap-cash-bmap-cash-12646634-issue-@incoming.gitlab.com,en-bmap.cash@therealbitcoin.club,en-anypay@therealbitcoin.club" +
            (hasInput(inputDASH)
                ? getDASHReceiverAdr(hasInput(inputDASH))
                : getBCHReceiverAdr(hasInput(inputBCH))) +
            "?subject=" +
            (hasInput(inputDASH) ? inputDASH : inputBCH) +
            "&body=Welcome to http://bmap.cash!\n\nYou can optionally attach Images to this email now!\n\nSend this E-Mail to submit the place!\n\nWe will notify you as soon as the place is available inside the app!\n\nDo not modify the content of this E-Mail!\n\nTo add any further details please send another E-Mail to trbc@bitcoinmap.cash!\n\nYou are Satoshi Nakamoto!\n\nThanks!\n\n" +
            content;
    await _launchEmail(urlString, onEmailClientNotFound);
  }

  //TODO CREATE LIGHTWEIGHT SIGN UP VERSION OF COINECTOR/BMAP.CASH

  static bool hasInput(String input) => input.length > MIN_INPUT_BCHyDASH;

  static Future _launchEmail(String urlString, onEmailClientNotFound) async {
    Toaster.showToastLaunchingEmailClient();
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      onEmailClientNotFound();
    }
  }

  static void launchEmailClientUpdatePaymentDetails(
      Merchant m, onEmailClientNotFound) {
    var urlString =
        "mailto:trbc@bitcoinmap.cash?subject=Update Coinector: " + m.id;
    _launchEmail(urlString, onEmailClientNotFound);
  }
}
