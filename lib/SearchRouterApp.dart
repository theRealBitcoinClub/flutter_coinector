import 'package:Coinector/SearchRouterDelegate.dart';
import 'package:flutter/material.dart';

import 'SearchRouteInformationParser.dart';

void main() {
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

  WidgetsFlutterBinding.ensureInitialized();
  runApp(SearchRouterApp());
}

class SearchRouterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchRouterAppState();
}

class _SearchRouterAppState extends State<SearchRouterApp> {
  SearchRouterDelegate _routerDelegate = SearchRouterDelegate();
  SearchRouteInformationParser _routeInformationParser =
      SearchRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Coinector - Coinecting to coimunity...',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
