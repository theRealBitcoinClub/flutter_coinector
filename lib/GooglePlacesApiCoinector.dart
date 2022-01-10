import 'dart:typed_data';

import 'package:Coinector/ConfigReader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class GooglePlacesApiCoinector {
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
