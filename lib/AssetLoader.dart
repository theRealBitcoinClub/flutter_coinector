import 'package:endlisch/Place.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AssetLoader {
  static Future<List<dynamic>> loadAndEncodeAsset(final String fileName) async {
    String asset = await rootBundle.loadString(fileName);
    return json.decode(asset);
  }

  static Future<String> loadReceivingAddress(String id) async {
    String addr = "";
    List addresses = await AssetLoader.loadAndEncodeAsset("assets/addr.json");
    addresses.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        addr = item['b'];
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

  static Future<Place> loadPlace(String id) async {
    List addresses =
        await AssetLoader.loadAndEncodeAsset("assets/placesId.json");
    Place result;
    addresses.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        result = Place.fromJson(item);
      }
    });
    return result;
  }
}
