import 'package:flutter/cupertino.dart';

import 'RouterPath.dart';

class SearchRouteInformationParser extends RouteInformationParser<RouterPath> {
  @override
  Future<RouterPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return RouterPath.home();
    }
    if (uri.pathSegments.length == 1) {
      var s = uri.pathSegments[0];
      String search = s.toString();
      if (search.isEmpty) return RouterPath.unknown();
      return RouterPath.filtered(search);
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'search') return RouterPath.unknown();
      var remaining = uri.pathSegments[1];
      String search = remaining.toString();
      if (search.isEmpty) return RouterPath.unknown();
      return RouterPath.filtered(search);
    }

    // Handle unknown routes
    return RouterPath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(RouterPath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isFilteredPage) {
      return RouteInformation(location: '/search/${path.search}');
    }
    return RouteInformation(location: '/');
  }
}
