import 'dart:typed_data';

import 'package:Coinector/ConfigReader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'Toaster.dart';

enum GoogleErrors { MULTIPLE, NOT_FOUND, INTERNET_ERROR }

class GooglePlacesApiCoinector {
  static Future<String> findPlaceId(String search, ctx) async {
    String encoded = Uri.encodeComponent(search);
    String placeId;
    String path =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?inputtype=textquery&key=" +
            ConfigReader.getGooglePlacesKey() +
            "&input=" +
            encoded;
    try {
      var result = await new Dio().get(path);
      if (!kReleaseMode) print(result.toString());
      if (result.data['status'].toString() == "ZERO_RESULTS")
        return GoogleErrors.NOT_FOUND.toString();
      var candidates = result.data['candidates'];
      if (candidates.length > 1) {
        placeId = "MULTIPLE";
        Toaster.showMerchantSearchHasMultipleResults(ctx);
        for (int x = 0; x < candidates.length; x++) {
          placeId += ";" + candidates[x]["place_id"].toString();
        }
      } else
        placeId = candidates[0]["place_id"].toString();
      if (!kReleaseMode) print(placeId);
    } catch (e) {
      print("INTERNET ERROR on " + path);
      return GoogleErrors.INTERNET_ERROR.toString();
    }
    return placeId;
  }

  static Future<Object> loadPhoto(String reference,
      {int height, int width}) async {
    var uri = "https://maps.googleapis.com/maps/api/place/photo" +
        "?key=" +
        ConfigReader.getGooglePlacesKey() +
        "&photoreference=" +
        reference;

    if (height != null) uri += "&maxheight=" + height.toString();
    if (width != null) uri += "&maxwidth=" + width.toString();

    print("URI:\n" + uri);

    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(uri)).load(uri))
        .buffer
        .asUint8List();
    return bytes;
  }

  static Future<Object> findPlaceIdDetails(String placeId) async {
    var result = await Dio().get(
        "https://maps.googleapis.com/maps/api/place/details/json" +
            "?key=" +
            ConfigReader.getGooglePlacesKey() +
            "&place_id=" +
            placeId);
    var data = result.data["result"];
    // if (!kReleaseMode) printWrapped(m.getBmapDataJson());
    return data;
  }
}
