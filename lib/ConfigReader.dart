import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'AssetLoader.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config;

  static Future<void> initialize() async {
    // final configString = await rootBundle.loadString('config/app_config.json');
    final configString2 =
        await AssetLoader.loadString('assets/app_config.json');
    final configString3 =
        await AssetLoader.loadString('config/app_config.json');
    _config = json.decode(configString2) as Map<String, dynamic>;
    if (!kReleaseMode) debugPrint("CONFIG:" + _config.toString());
  }

  static String getGithubKey() {
    return _config['GITHUB_KEY'] as String;
  }

  static String getGooglePlacesKey() {
    return _config['GOOGLE_PLACES_KEY'] as String;
  }
}
