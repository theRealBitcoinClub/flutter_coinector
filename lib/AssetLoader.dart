import 'dart:convert';

import 'package:coinector/Place.dart';
import 'package:flutter/services.dart';

class AssetLoader {
  static List<dynamic> assetsAm;
  static List<dynamic> assetsAmVen;
  static List<dynamic> assetsAmVenCar;
  static List<dynamic> assetsAs;
  static List<dynamic> assetsAsJap;
  static List<dynamic> assetsAu;
  static List<dynamic> assetsE;
  static List<dynamic> assetsESpa;
  static List addresses;
  static List places;

  static void putDecodedAssetInCache(String key, List<dynamic> asset) {
    switch (key) {
      case "assets/am.json":
        assetsAm = asset;
        return;
      case "assets/am-ven.json":
        assetsAmVen = asset;
        return;
      case "assets/am-ven-car.json":
        assetsAmVenCar = asset;
        return;
      case "assets/as.json":
        assetsAs = asset;
        return;
      case "assets/as-jap.json":
        assetsAsJap = asset;
        return;
      case "assets/au.json":
        assetsAu = asset;
        return;
      case "assets/e.json":
        assetsE = asset;
        return;
      case "assets/e-spa.json":
        assetsESpa = asset;
        return;
      case "assets/addr.json":
        addresses = asset;
        return;
      case "assets/placesId.json":
        places = asset;
        return;
    }
  }

  static List<dynamic> getDecodedCachedAsset(String key) {
    switch (key) {
      case "assets/am.json":
        return assetsAm;
      case "assets/am-ven.json":
        return assetsAmVen;
      case "assets/am-ven-car.json":
        return assetsAmVenCar;
      case "assets/as.json":
        return assetsAs;
      case "assets/as-jap.json":
        return assetsAsJap;
      case "assets/au.json":
        return assetsAu;
      case "assets/e.json":
        return assetsE;
      case "assets/e-spa.json":
        return assetsESpa;
      case "assets/addr.json":
        return addresses;
      case "assets/placesId.json":
        return places;
    }
    return null;
  }

  static Future<List<dynamic>> loadAndEncodeAsset(final String fileName) async {
    //List<dynamic> cached = getDecodedCachedAsset(fileName);
    //if (cached != null) return cached;

    String asset = await rootBundle.loadString(fileName, cache: true);
    var decoded = json.decode(asset);
    //putDecodedAssetInCache(fileName, decoded);
    return decoded;
  }

  static Future<String> loadReceivingAddress(String id) async {
    var addresses = await AssetLoader.loadAndEncodeAsset("assets/addr.json");

    String addr;
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
  static Future<Place> loadPlace(String id) async {
    var places = await AssetLoader.loadAndEncodeAsset("assets/placesId.json");

    Place result;
    places.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        result = Place.fromJson(item);

        return result.placesId;
      }
    });
    return result;
  }
}
