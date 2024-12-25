import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'CoinectorWidgetList.dart';
import 'RouterPath.dart';

class SearchRouterDelegate extends RouterDelegate<RouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterPath> {
  final GlobalKey<NavigatorState> navigatorKey;

  var search;
  bool show404 = false;

  SearchRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  RouterPath get currentConfiguration {
    if (show404) {
      return RouterPath.unknown();
    }
    return search == null ? RouterPath.home() : RouterPath.filtered(search);
  }

  @override
  Widget build(BuildContext context) {
    print("START build AllMerchantsPage SRD");

    return Navigator(
      key: navigatorKey,
      pages: [
        AllMerchantsPage(search: search)
        /*
        MaterialPage(
          key: ValueKey('AllMerchantsPage'),
          child: SizedBox(),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (search != null)
          AllMerchantsPage()*/
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        search = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouterPath path) async {
    print("START setNewRoutePath");
    if (path.isUnknown) {
      search = null;
      show404 = true;
      return;
    }

    if (path.isFilteredPage) {
      /*if (path.search.isNotEmpty || ) {
        show404 = true;
        return;
      }*/

      search = path.search;
    } else {
      search = null;
    }

    show404 = false;
  }
}

class AllMerchantsPage extends Page {
  final String search;

  AllMerchantsPage({
    required this.search,
  }) : super(key: ValueKey(search));

  Route createRoute(BuildContext context) {
    print("START createRoute");
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return Phoenix(
          child: CoinectorWidget(search),
        );
      },
    );
  }
}
