import 'package:url_launcher/url_launcher.dart';

import 'Merchant.dart';
import 'Toaster.dart';
//import 'package:launch_review/launch_review.dart';

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
    return hasInput ? ",info@discoverdash.com" : "";
  }
  static String getBCHReceiverAdr(hasInput) {
    return hasInput ? ",info@acceptbitcoin.cash,info@bitcoin.com,jbrack14@gmail.com" : "";
  }

  static void launchEmailClientAddPlace(bool hasInputDASH, bool hasInputBCH,
      String content, onEmailClientNotFound) async {
    var urlString = "mailto:bmap.cash@therealbitcoin.club" +
        getDASHReceiverAdr(hasInputDASH) +
        getBCHReceiverAdr(hasInputBCH) +
        "?subject=Add Place Coinector&body=Welcome to bitcoinmap.cash!\n\nSend this E-Mail now to submit the place!\n\nWe will notify you as soon as the place is available inside the app!\n\nDo not modify the content of this E-Mail!\n\nTo add any further details please send another E-Mail to trbc@bitcoinmap.cash!\n\nYou are Satoshi Nakamoto!\n\nThanks!\n\n" +
        content;
    await _launchEmail(urlString, onEmailClientNotFound);
  }

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
