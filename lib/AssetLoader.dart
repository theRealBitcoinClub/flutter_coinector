import 'package:flutter/services.dart';
import 'dart:convert';

class AssetLoader {
  static Future<List<dynamic>> loadAndEncodeAsset(final String fileName) async {
    String asset = await rootBundle.loadString(fileName);
    return json.decode(asset);
  }
}