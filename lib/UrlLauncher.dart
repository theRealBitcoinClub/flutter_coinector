import 'package:url_launcher/url_launcher.dart';
//import 'package:launch_review/launch_review.dart';

class UrlLauncher {
  static void launchMapInBrowser() async {
    //LaunchReview.launch(androidAppId: "club.therealbitcoin.bchmap");
    //LaunchReview.launch();
    var url =
        'https://play.google.com/store/apps/details?id=club.therealbitcoin.bchmap';
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
    var url =
        'market://details?id=club.therealbitcoin.bchmap';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      launchMapInBrowser();
    }
  }

  static void launchReviewUrl(context, place) async {
    var url =
        'https://search.google.com/local/writereview?placeid=' + place.placesId;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//TODO setup various servers to host images, for each dataset one
  static void launchVisitUrl(context, place) async {
    var url = 'https://goo.gl/maps/' + place.shareId;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //TODO show a message to the user, his internet connection might be off
      throw 'Could not launch $url';
    }
  }

  static void launchEmailClient(onEmailClientNotFound) async {
    var urlString =
        "mailTo:bitcoinmap.cash@protonmail.com?subject=Coinecccctorrrrr";
    var hasEmailClient = await canLaunch(urlString);
    if (hasEmailClient) {
      await launch(urlString);
    } else {
      onEmailClientNotFound();
    }
  }
}
