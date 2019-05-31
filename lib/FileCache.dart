import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
const _kNotificationsPrefs = "initLastVersionKey";

class FileCache {
  static Future<String> initLastVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return getCounterFromPrefsWithDefaultValue(prefs, _kNotificationsPrefs);
  }

  static String getCounterFromPrefsWithDefaultValue(SharedPreferences prefs, key) {
    var lastCheckSum = prefs.getString(key);
    return lastCheckSum != null ? lastCheckSum : 0;
  }

  static Future incrementAndPersistToastCounter(sharedPrefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var checkSum =
    getCounterFromPrefsWithDefaultValue(prefs, sharedPrefKey);
    prefs.setString(sharedPrefKey, checkSum);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/' + fileName + '.txt');
  }

  Future<String> readCache(String fileName) async {
    try {
      final file = await localFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  Future<File> writeCache(String fileName, String content) async {
    final file = await localFile(fileName);
    // Write the file
    return file.writeAsString(content, flush: true);
  }
}
