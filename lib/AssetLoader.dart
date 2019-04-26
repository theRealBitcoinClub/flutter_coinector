import 'package:endlisch/Place.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AssetLoader {
  static Future<List<dynamic>> loadAndEncodeAsset(final String fileName) async {
    String asset = await rootBundle.loadString(fileName);
    return json.decode(asset);
  }

  static List addresses;

  static Future<String> loadReceivingAddress(String id) async {
    if (addresses == null)
      addresses = await AssetLoader.loadAndEncodeAsset("assets/addr.json");

    String addr = "";
    addresses.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        addr = item['b'];
        return;
      }
    });
    return addr;
  }

  /*static Future<String> loadPlacesId(String id) async {
    String addr = "";
    List addresses =
        await AssetLoader.loadAndEncodeAsset("assets/placesId.json");
    addresses.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        addr = item['id'];
      }
    });
    return addr;
  }*/
  static List places;

  static Future<Place> loadPlace(String id) async {
    if (places == null)
      places = await AssetLoader.loadAndEncodeAsset("assets/placesId.json");

    Place result;
    places.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        result = Place.fromJson(item);
        return;
      }
    });
    return result;
  }
}
