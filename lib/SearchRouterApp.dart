import 'package:Coinector/SearchRouterDelegate.dart';
import 'package:flutter/material.dart';

import 'SearchRouteInformationParser.dart';

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
