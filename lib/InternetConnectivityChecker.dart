import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class InternetConnectivityChecker {
  static var lastWarningInMillis = 0;
  static var pauseInternetChecker = false;

  static void close() {
    resumeAutoChecker();
  }

  static void pauseAutoChecker() {
    pauseInternetChecker = true;
  }

  static void resumeAutoChecker() {
    pauseInternetChecker = false;
  }

  static void checkInternetConnectivityShowSnackbar(that, _onError) async {
    if (pauseInternetChecker || kIsWeb) return;
    pauseInternetChecker = true;
    //DONT CHECK MORE THAN EVERY 9 SECONDS
    var milliSecondsNow = DateTime.now().millisecondsSinceEpoch;
    if (that.mounted &&
        lastWarningInMillis != 0 &&
        lastWarningInMillis + 8500 > milliSecondsNow) {
      pauseInternetChecker = false;
      return;
    }
    lastWarningInMillis = milliSecondsNow;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network. all fine
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // wifi activated doesnt assura having internet
      checkConnectionWithRequest(that, (abc) {
        _onError(that);
      });
    } else {
      _onError(that);
    }
    pauseInternetChecker = false;
  }

  static Future checkConnectionWithRequest(that, _onError) async {
    try {
      Response response = await Dio().get('https://google.com').catchError((e) {
        _onError(that);
      });
      if (response == null || response.statusCode != HttpStatus.ok) {
        _onError(that);
      }
    } catch (e) {
      _onError(that);
    }
  }
}
