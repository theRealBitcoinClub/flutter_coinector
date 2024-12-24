import 'package:Coinector/SearchRouterApp.dart';
import 'package:flutter/cupertino.dart';

import 'ConfigReader.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  //Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    //Crashlytics.instance.onError(details);
    //just ignore the errors for now to have less library dependencies
  };

  ConfigReader.initialize();
  //configureApp();
  runApp(SearchRouterApp());
}
