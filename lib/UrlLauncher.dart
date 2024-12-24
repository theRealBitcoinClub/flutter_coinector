import 'dart:io';

import 'package:Coinector/translator.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'AddNewPlaceWidget.dart';
import 'Merchant.dart';
import 'Toaster.dart';

class UrlLauncher {
  static void launchURI(url, {bool forceWebView = false}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url,
          mode: forceWebView
              ? LaunchMode.inAppWebView
              : LaunchMode.platformDefault,
          webViewConfiguration: WebViewConfiguration(
              enableDomStorage: true, enableJavaScript: true),
          webOnlyWindowName: "BMAP - TRBC");
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchDonateUrl() async {
    var url =
        'https://bitcoinmap.cash/bitcoin-bch-dash-qr-code-generator?bch=qqp0kpntfxygx3e6d4mr9c5ef5ucxdcjk5zkgtevss&dash=XiHdw8SVoNtJqno6GnxKQS2Snxh7BTuR39';
    launchURI(url);
  }

  //TODO detect IPhone and forward them to bitcoinmap.cash
  //TODO use this plugin: https://pub.dartlang.org/packages/launch_review
  //LaunchReview.launch(writeReview: false,iOSAppId: "585027354");
  //LaunchReview.launch(androidAppId: "com.iyaffle.rangoli",
  //                    iOSAppId: "585027354");

  static void launchReviewUrl(context, place) async {
    var url =
        'https://search.google.com/local/writereview?placeid=' + place.placesId;
    launchURI(url);
  }

  static void launchReportUrl(context, String prefill) async {
    var url =
        'https://docs.google.com/forms/d/e/1FAIpQLSdWIaDcf983QSJdj_u59fwUOR_Jo6cFTQnomCydHFUm3v4YCQ/viewform?usp=pp_url&entry.1825017039=' +
            prefill;
    launchURI(url);
  }

  static void launchCoordinatesUrl(context, Merchant merchant) async {
    var url = buildGoogleMapsSearchQueryUrl(merchant);
    launchURI(url);
  }

  static String buildGoogleMapsSearchQueryUrl(Merchant merchant) =>
      'https://www.google.com/maps/search/?api=1&query=' +
      merchant.x.toString() +
      ',' +
      merchant.y.toString();

  static void launchVisitUrl(context, Merchant merchant) async {
    var url = buildGoogleMapsSearchQueryUrl(merchant) +
        '&query_place_id=' +
        merchant.place.placesId;
    launchURI(url);
  }

  static void launchSubmitForm() {
    if (kIsWeb) {
      launchURI("https://bmap.app/add");
      return;
    }

    //TODO LAUNCH LANGUAGE SPECIFIC GOOGLE FORM, EASY FIRST STEP
    String append = "add";
    try {
      String langCode = Platform.localeName.split("_")[0];
      switch (langCode) {
        case "es":
        case "ja":
        case "jp":
        case "it":
        case "fr":
        case "de":
        case "id":
          append = langCode;
          break;
        default:
          break;
      }
      launchURI("https://bmap.app/" + append);
      /*, forceWebView: true TEST IF THAT FIXES THE ERROR ON DEVICE*/
    } catch (e) {
      launchURI("https://bmap.app/add");
    }
  }

  static void launchBitcoinMap() {
    launchURI("https://bitcoinmap.cash");
  }

  static void launchQrCodeGeneratorUrl(
      {String bch = "", String dash = ""}) async {
    String targetUrl =
        "https://bitcoinmap.cash/bitcoin-bch-dash-qr-code-generator";
    if (bch.isNotEmpty) {
      targetUrl += "?bch=" + bch;
      if (dash.isNotEmpty) {
        targetUrl += "&dash=" + dash;
      }
    } else if (dash.isNotEmpty) {
      targetUrl += "?dash=" + dash;
    }

    launchURI(targetUrl);
  }

  static String getDASHReceiverAdr(hasInput, countryCode) {
    return hasInput ? "," + countryCode + "-dash@therealbitcoin.club" : "";
  }

  static String getBCHReceiverAdr(hasInput, countryCode) {
    return hasInput ? "," + countryCode + "-bch@therealbitcoin.club" : "";
  }

  static Future<void> launchEmailClientAddPlace(ctx, String inputDASH,
      String inputBCH, String content, onEmailClientNotFound) async {
    //String countryCode = getLocale(ctx);
    //print("countryCode:" + countryCode);
    var urlString = "mailto:" +
        "trbcwindoof@protonmail.com" +
        /*
        countryCode +
        "-bmap.cash@therealbitcoin.club," +
        countryCode +
        "-anypay@therealbitcoin.club" +*/
        /*(hasInput(inputDASH)
            ? getDASHReceiverAdr(hasInput(inputDASH), countryCode)
            : getBCHReceiverAdr(hasInput(inputBCH), countryCode)) +*/
        "?subject=" +
        "Add Place Coinector" +
        /* (hasInput(inputDASH) ? inputDASH : inputBCH) +*/
        "&body=" +
        Translator.translate(ctx, "email_text_add_new_place") +
        content;
    await _launchEmail(ctx, urlString, onEmailClientNotFound(content));
  }

  static bool hasInput(String input) => input.length > MIN_INPUT_BCHyDASH;

  static Future _launchEmail(
      ctx, String urlString, onEmailClientNotFound) async {
    Toaster.showToastLaunchingEmailClient(ctx);
    if (await canLaunchUrlString(urlString)) {
      await launchUrlString(urlString);
    } else {
      onEmailClientNotFound();
    }
  }

  static void launchEmailClientUpdatePaymentDetails(
      ctx, Merchant m, onEmailClientNotFound) {
    var urlString = "mailto:trbc@bitcoinmap.cash?subject=Update Coinector: " +
        //"mailto:trbc@bitcoinmap.cash,bitcoinmap@fire.fundersclub.com,incoming+bmap-cash-bmap-cash-12646634-issue-@incoming.gitlab.com?subject=Update Coinector: " +
        m.id;
    _launchEmail(ctx, urlString, onEmailClientNotFound);
  }

  static launchRegisterOnGmaps() {
    launchURI("https://business.google.com/create/new", forceWebView: true);
  }
}
