import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AssetLoader.dart';
import 'CoinectorWidgetList.dart';

const _kNotificationsPrefs = "initLastVersionKey";

/*
* Strategy would be to load contents from File if available,
* then check the version in the background and update file contents in the background,
* if new data is downloaded notify the user about it,
* offer him to restart the app to load the new data.
*
* */

class FileCache {
  static Future<String> getLatestContentFromWeb(String fileName) async {
    var response;
    try {
      response = await new Dio().get(
          'https://raw.githubusercontent.com/theRealBitcoinClub/flutter_coinector/master/assets/' +
              fileName +
              '.json');
    } catch (e) {}
    return response == null ? null : response.data;
  }

  static Future<void> initLastVersion(onHasNewVersionCallback) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentVersion = int.parse(
        getLastVersionNumberFromPrefsWithDefaultValue(
            prefs, _kNotificationsPrefs));
    var response;
    if ((response = await tryGet('https://bmap.app/updatecheck')) ==
        null) if ((response =
            await tryGet(COINECTOR_URL + '/updatecheck')) ==
        null) if ((response = await tryGet('/updatecheck')) == null) {}

    if (response == null) return;
    if (int.parse(response.data) > currentVersion) {
      onHasNewVersionCallback(response.data);
    }
  }

  static Future<dynamic> tryGet(String url) async {
    try {
      var response = await new Dio().get(url);
      return response;
    } catch (e) {}
    return null;
  }

  static String getLastVersionNumberFromPrefsWithDefaultValue(
      SharedPreferences prefs, key) {
    var lastVersion = prefs.getString(key);
    return lastVersion != null ? lastVersion : "0";
  }

  static Future forceUpdateNextTime() async {
    persistCacheVersionCounter("0");
  }

  static Future persistCacheVersionCounter(String versionNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_kNotificationsPrefs, versionNumber);
  }

  static Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  static Future<File> localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/' + fileName + '.txt');
  }

  static Future<String> readCache(String fileName) async {
    if (kIsWeb) return "";

    final file = await localFile(fileName);
    return await file.readAsString();
  }

  static Map<String, List<dynamic>> memoryCache = new Map();

  static Future loadAndDecodeAsset(String fileName) async {
    if (memoryCache[fileName] != null) return memoryCache[fileName];

    String cachedAsset = await getCachedAssetWithDefaultFallback(fileName);
    var decoded = AssetLoader.decodeJSON(cachedAsset);
    if (!kReleaseMode) print(cachedAsset);
    memoryCache[fileName] = decoded;
    return decoded;
  }

  static Future<String> getCachedAssetWithDefaultFallback(
      String fileName) async {
    String cachedAsset;
    try {
      cachedAsset = await FileCache.readCache(fileName);
      if (cachedAsset == null || cachedAsset.isEmpty) {
        cachedAsset =
            await AssetLoader.loadString('assets/' + fileName + '.json');
        FileCache.writeCache(fileName, cachedAsset);
      }
    } catch (e) {
      cachedAsset =
          await AssetLoader.loadString('assets/' + fileName + '.json');
    }
    return cachedAsset;
  }

  static Future<bool> loadFromWebAndPersistCache(String fileName) async {
    String latestContent = await FileCache.getLatestContentFromWeb(fileName);
    if (latestContent == null) return false;
    return await FileCache.writeCache(fileName, latestContent);
  }

  static Future<bool> writeCache(String fileName, String content) async {
    if (kIsWeb) return false;

    try {
      final file = await localFile(fileName);
      file.writeAsString(content, flush: true);
    } catch (e) {
      return false;
    }
    return true;
  }
}
