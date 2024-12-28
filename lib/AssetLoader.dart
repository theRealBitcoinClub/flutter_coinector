import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'FileCache.dart';
import 'Place.dart';

class AssetLoader {
  static Map<String, List<dynamic>> cachedAssets = new Map();

  static dynamic decodeJSON(String input) {
    return json.decode(input);
  }

  static Future<List<dynamic>> loadAndDecodeAsset(final String fileName) async {
    List? cached = cachedAssets[fileName];
    if (cached != null) return cached;

    String asset = await loadString(fileName);
    var decoded = json.decode(asset);
    cachedAssets[fileName] = decoded;
    return decoded;
  }

  static Future<String> loadString(String fileName) async =>
      rootBundle.loadString(fileName, cache: false);

  static Future<String> loadReceivingAddress(String id) async {
    var addresses = await AssetLoader.loadAndDecodeAsset("assets/addr.json");

    String addr="";
    addresses.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        addr = item['b'];
        return;
      }
    });
    return addr;
  }

  var placesIdCache;

  //TODO split contents in one file for each continent
  Future<Place?> loadPlace(String ?id) async {
    if (id == null || id.isEmpty) return null;

    if (id.startsWith("ChI")) return Place(id, id);

    if (placesIdCache == null) {
      String data =
          await FileCache.getCachedAssetWithDefaultFallback("placesId");
      if (data.isNotEmpty) {
        placesIdCache = json.decode(data);
      } else {
        var response;
        try {
          response = await new Dio().get(
              'https://github.com/theRealBitcoinClub/flutter_coinector/raw/master/assets/placesId.json');
        } catch (e) {}
        if (response == null) return null;
        placesIdCache = json.decode(response.data);
        FileCache.writeCache("placesId", response.data.toString());
      }
    }
    //var p = await AssetLoader.loadAndDecodeAsset("assets/placesId.json");

    Place ?result=null;
    placesIdCache.forEach((item) {
      var itemId = item['p'];
      if (itemId == id) {
        result = Place.fromJson(item);
        return result;
      }
    });
    return result;
  }
}
