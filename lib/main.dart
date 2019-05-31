import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal/onesignal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

import 'AddNewPlaceWidget.dart';
import 'AssetLoader.dart';
import 'CardItemBuilder.dart';
import 'ListModel.dart';
import 'MapSample.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'SearchDemoSearchDelegate.dart';
import 'Suggestions.dart';
import 'Tag.dart';
import 'pages.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample>
    with TickerProviderStateMixin {
  final SearchDemoSearchDelegate searchDelegate = SearchDemoSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController tabController;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  var assetLoader = AssetLoader();
  List<Merchant> names = new List<Merchant>(); // names we get from API
  List<ListModel<Merchant>> tempLists = [];
  List<ListModel<Merchant>> unfilteredLists = [];
  String _title = "Coinector";
  bool isUnfilteredList = false;
  bool
      hasHitSearch; //TODO count user activity by how often he hits search, how much he interacts with the app, reward him for that with badges
  var sharedPrefKeyHasHitSearch = "sharedPrefKeyHasHitSearch";
  String _searchTerm;
  Position userPosition;
  Position mapPosition;

  Animation<Color> searchIconBlinkAnimation;
  AnimationController searchIconBlinkAnimationController;

  initBlinkAnimation() {
    searchIconBlinkAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final CurvedAnimation curve = CurvedAnimation(
        parent: searchIconBlinkAnimationController, curve: Curves.decelerate);
    searchIconBlinkAnimation =
        ColorTween(begin: Colors.white, end: Colors.lightGreen).animate(curve);
    searchIconBlinkAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        searchIconBlinkAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        searchIconBlinkAnimationController.forward();
      }
      setState(() {});
    });
    searchIconBlinkAnimationController.forward();
  }

  @override
  void dispose() {
    tabController.dispose();
    if (searchIconBlinkAnimationController != null)
      searchIconBlinkAnimationController.dispose();
    super.dispose();
  }

  void loadAssets(
      int filterWordIndex, String locationFilter, String fileName) async {
    updateCurrentPosition();

    if (isUnfilteredSearch(filterWordIndex)) {
      updateDistanceToAllMerchantsIfNotDoneYet();
      if (isUnfilteredList) return;
      //if (unfilteredLists.length != 0) updateListModel(unfilteredLists);
      this.isUnfilteredList = true;
    } else {
      this.isUnfilteredList = false;
    }
/*
    if (response == null)
      response =
          await dio.get('https://raw.githubusercontent.com/theRealBitcoinClub/BITCOINMAP.CASH---Browser-PWA/master/public/places8.json');
          //TODO get data from server, add push notifications for new spots, in that case apps looses offline capabilities...
         //TODO manually confirm places, create gif with online tools, upload it to github, once inside of github and reviewed it is published on the map
          //TODO get data from server, additionally to the places which are hardcoded, simply load another additional list which gets synced each month with a new release of the app
  */

    initListModel();

    if (fileName == null) {
      //TODO internationalize the tags, let users search for hamburguesa instead of burger or hamburger, all should lead to the same results which then display the short term "burger"
      //TODO internationalize the app, translate the strings, let users search locations in their language (Köln a.k.a. Cologne, Colonia, Brüssel, Brussels)
      parseAssetUpdateListModel(filterWordIndex, locationFilter,
          'assets/am.json', 'am', fileName != null);
      parseAssetUpdateListModel(filterWordIndex, locationFilter,
          'assets/e.json', 'e', fileName != null);
      parseAssetUpdateListModel(filterWordIndex, locationFilter,
          'assets/as.json', 'as', fileName != null);
      parseAssetUpdateListModel(filterWordIndex, locationFilter,
          'assets/au.json', 'au', fileName != null);
    } else {
      parseAssetUpdateListModel(filterWordIndex, locationFilter,
          'assets/' + fileName + '.json', fileName, fileName != null);
    }
  }

  bool isUnfilteredSearch(int filterWordIndex) => filterWordIndex == -999;

  Future<List<dynamic>> parseAssetUpdateListModel(
      int selectedTagIndex,
      String locationFilter,
      String assetUri,
      String serverId,
      bool isLocationSearch) async {
    var placesList = await AssetLoader.loadAndDecodeAsset(assetUri);
    initTempListModel();
    for (int i = 0; i < placesList.length; i++) {
      Merchant m2 = Merchant.fromJson(placesList.elementAt(i));
      m2.serverId = serverId;
      //at the moment there is no PAY feature: m2.isPayEnabled = await AssetLoader.loadReceivingAddress(m2.id) != null;
      assetLoader.loadPlace(m2.id).then((place) {
        setState(() {
          m2.place = place;
        });
      });

      _insertIntoTempList(m2, selectedTagIndex, locationFilter);
    }

    if (!isLocationSearch) mapPosition = null;

    if (unfilteredLists.length == 0) initUnfilteredLists();

    updateListModel(tempLists);
    return placesList;
  }

  Future<int> updateList(
      List destination, List tmpList, bool updateState) async {
    var totalAdded = 0;
    bool hasAnimated = false;
    for (int i = 0; i < tmpList.length; i++) {
      ListModel<Merchant> currentTmpList = tmpList[i];
      ListModel<Merchant> currentList = destination[i];
      for (int x = 0; x < currentTmpList.length; x++) {
        Merchant m = currentTmpList[x];
        var lock = Lock();
        lock.synchronized(() async {
          bool hasCalculated =
              await calculateDistanceUpdateMerchant(userPosition, m);

          if (hasCalculated)
            insertItemInOrderedPosition(currentList, m, updateState);
          else
            insertListItem(updateState, currentList, currentList.length, m);

          if (!hasAnimated) {
            hasAnimated = true;
            animateToFirstResult(m);
          }
        });
        totalAdded++;
      }
    }
    return totalAdded;
  }

  void insertItemInOrderedPosition(currentList, m, updateState) {
    for (int newListPos = 0; newListPos < currentList.length; newListPos++) {
      Merchant m2 = currentList[newListPos];
      if (m2.distanceInMeters != -1 &&
          m2.distanceInMeters > m.distanceInMeters) {
        insertListItem(updateState, currentList, newListPos, m);
        return;
      }
    }

    insertListItem(updateState, currentList, currentList.length, m);
  }

  void insertListItem(updateState, currentList, int newListPos, m) {
    if (updateState) {
      setState(() {
        currentList.insert(newListPos, m);
      });
    } else {
      currentList.insert(newListPos, m);
    }
  }

  Future<bool> calculateDistanceUpdateMerchant(
      Position position, Merchant m) async {
    if (position == null) {
      m.distance = null;
      return false;
    }

    double distanceInMeters = await Geolocator().distanceBetween(
        position.latitude,
        position.longitude,
        double.parse(m.x),
        double.parse(m.y));

    m.distanceInMeters = distanceInMeters;
    var distance = distanceInMeters.round().toString() + " meter";

    if (distanceInMeters > 1000) {
      String km = (distanceInMeters / 1000.0).toStringAsFixed(2);
      distance = km + " km";
    }

    setState(() {
      m.distance = distance;
    });
    return true;
  }

  void updateListModel(List<ListModel<Merchant>> tmpList) {
    updateList(_lists, tmpList, true);
  }

  void animateToFirstResult(merchant) async {
    if (tabController.indexIsChanging) return;
    //TODO only if the current tab does not contain  result
    //if (currentTabContainsResult()) return;

    if (merchant != null) {
      tabController.animateTo(merchant.type);
      return;
    }

    for (int i = 0; i < _lists.length; i++) {
      ListModel<Merchant> model = _lists[i];
      for (int x = 0; x < model.length; x++) {
        Merchant m = model[x];
        tabController.animateTo(m.type);
        return;
      }
    }
  }

  /*bool currentTabContainsResult() => _lists[tabController.index].length != 0; This does not work because we call it async and we never know which is the last entry added to the list so we never know if a tab is really empty*/

  void initUnfilteredLists() {
    initListModelSeveralTimes(unfilteredLists, false);
    updateList(unfilteredLists, tempLists, false);
  }

  bool matchesFilteredTag(Merchant m, int filterWordIndex) {
    var splittedTags = m.tags.split(',');
    for (int i = 0; i < splittedTags.length; i++) {
      var currentTag = int.parse(splittedTags[i]);
      if (currentTag == filterWordIndex) {
        return true;
      }
    }
    return false;
  }

  bool _containsLocation(Merchant m, String location) {
    return _containsString(m.location, location);
  }

  bool _containsTitle(Merchant m, String title) {
    return _containsString(m.name, title);
  }

  bool _containsString(String src, String pattern) {
    if (pattern == null || pattern.isEmpty || src == null || src.isEmpty)
      return false;

    return src.toLowerCase().contains(pattern.toLowerCase());
  }

  void _insertIntoTempList(Merchant m2, int filterWordIndex, String location) {
    if (!isUnfilteredRequest(filterWordIndex) &&
        filterWordIndexDoesNotMatch(filterWordIndex, m2) &&
        !_containsLocation(m2, location) &&
        !_containsTitle(m2, location)) return;
    if (filterWordIndex == -1)
      mapPosition =
          Position(latitude: double.parse(m2.x), longitude: double.parse(m2.y));

    switch (m2.type) {
      case 0:
        tempLists[0].insert(0, m2);
        break;
      case 1:
        tempLists[1].insert(0, m2);
        break;
      case 2:
        tempLists[2].insert(0, m2);
        break;
      case 3:
        tempLists[3].insert(0, m2);
        break;
      case 4:
        tempLists[4].insert(0, m2);
        break;
      case 5:
        tempLists[5].insert(0, m2);
        break;
      case 999:
        tempLists[6].insert(0, m2);
        break;
      /*case 999:
        tempLists[7].insert(0, m2);
        break;*/
    }
  }

  bool filterWordIndexDoesNotMatch(int tagFilterWordIndex, Merchant m2) {
    return !hasFilterWordIndex(tagFilterWordIndex) ||
        (hasFilterWordIndex(tagFilterWordIndex) &&
            !matchesFilteredTag(m2, tagFilterWordIndex));
  }

  bool hasFilterWordIndex(int filterWordIndex) {
    return filterWordIndex != null &&
        filterWordIndex != -1 &&
        !isUnfilteredRequest(filterWordIndex);
  }

  bool isUnfilteredRequest(int filterWordIndex) =>
      isUnfilteredSearch(filterWordIndex);

  void initListModelSeveralTimes(List lists, bool keepListKeys) {
    lists.clear();
    if (keepListKeys) _listKeys.clear();
    for (int i = 0; i < Pages.pages.length + 1; i++) {
      if (keepListKeys) _listKeys.add(GlobalKey<AnimatedListState>());
      lists.add(ListModel<Merchant>(
        tabIndex: i,
        listKey: (keepListKeys) ? _listKeys[i] : GlobalKey<AnimatedListState>(),
        removedItemBuilder: CardItemBuilder.buildRemovedItem,
      ));
    }
  }

  void initTempListModel() {
    initListModelSeveralTimes(tempLists, false);
  }

  Decoration getIndicator() {
    if (!_customIndicator) return const UnderlineTabIndicator();

    return ShapeDecoration(
      shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) +
          const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
    );
  }

  _handleTabSelection() {
    if (!isFilteredList()) updateTitle();
    initCurrentPositionIfNotInitialized();
    updateDistanceToAllMerchantsIfNotDoneYet();
  }

  void requestCurrentPosition() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.locationWhenInUse]).then(
            (Map<PermissionGroup, PermissionStatus> p) {
      updateCurrentPosition();
      updateDistanceToAllMerchantsIfNotDoneYet();
    });
  }

  void initCurrentPositionIfNotInitialized() async {
    if (userPosition != null) return;

    updateCurrentPosition();
  }

  Future<bool> updateCurrentPosition() async {
    PermissionStatus sta = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if (sta == PermissionStatus.granted) {
      Position pos = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        userPosition = pos;
      });
      return true;
    }
    return false;
  }

  Future<void> initOneSignalPushMessages() async {
    //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    await OneSignal.shared
        .init("3cfbaca5-2b90-4f68-a1fe-98aa9a168894", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setLocationShared(true);

    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  @override
  void initState() {
    super.initState();
    //TEST CRASHLYTICS Crashlytics.instance.crash();
    initOneSignalPushMessages();
    requestCurrentPosition();
    searchDelegate.buildHistory();
    tabController = TabController(vsync: this, length: Pages.pages.length);
    tabController.addListener(_handleTabSelection);
    initListModel();
    loadAssetsUnfiltered();
    if (hasNotHitSearch()) {
      initHasHitSearch().then((hasHit) {
        if (!hasHit) initBlinkAnimation();
      });
    }
  }

  void loadAssetsUnfiltered() => loadAssets(-999, null, null);

  void showInfoDialogWithCloseButton(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          var color = Colors.white;
          var textStyle = TextStyle(color: color);
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(
                "Search your favorite food:\n\n  🍔 Burger     🍰 Dessert\n\n  🥗 Salad      🐮 Vegan\n\n  🇮🇹 Italian      🍕 Pizza",
                style: textStyle),
            title: Text("Are you hungry?", style: textStyle),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: color,
                    ),
                    Text(" CLOSE", style: textStyle)
                  ],
                ),
              )
            ],
          );
        });
  }

  void updateDistanceToAllMerchantsIfNotDoneYet() {
    if (userPosition == null) return;

    for (int i = 0; i < _lists.length; i++) {
      ListModel<Merchant> model = _lists[i];
      for (int x = 0; x < model.length; x++) {
        Merchant m = model[x];

        if (m.distance != null) return;

        calculateDistanceUpdateMerchant(userPosition, m);
      }
    }
  }

  void updateTitle() {
    setState(() {
      _title = getTitleOfSelectedTab();
    });
  }

  String getTitleOfSelectedTab() => Pages.pages[tabController.index].title;

  Color getColorOfSelectedTab() =>
      MyColors.getCardInfoBoxBackgroundColor(tabController.index);

  Color getAccentColorOfSelectedTab() =>
      MyColors.getTabColor(tabController.index);

  Color getDarkColorOfSelectedTab() =>
      MyColors.getCardActionButtonBackgroundColor(tabController.index);

  void initListModel() {
    initListModelSeveralTimes(_lists, true);
  }
  //TODO make use of theme styles everywhere and add switch theme button

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        primaryColor: Colors.grey[900],
        accentColor: Colors.white,

        // Define the default Font Family
        //fontFamily: 'Montserrat',
        fontFamily: 'OpenSans',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          body1: TextStyle(
              fontSize: 17.0,
              fontFamily: 'Hind',
              color: Colors.white.withOpacity(0.85)),
          body2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Colors.white.withOpacity(0.7)),
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (builderCtx) => FloatingActionButton.extended(
              backgroundColor: getColorOfSelectedTab(),
              foregroundColor: Colors.white,
              onPressed: () {
                openAddNewPlaceWidget(builderCtx);
              },
              label: Text('ADD ' + getTitleOfSelectedTab()),
              icon: Icon(Icons.add_location)),
        ),
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext buildCtx, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  elevation: 2,
                  forceElevated: true,
                  leading: buildHomeButton(buildCtx),
                  bottom: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicator: getIndicator(),
                    tabs: Pages.pages.map<Tab>((Page page) {
                      return _lists[page.tabIndex].length > 0
                          ? Tab(
                              icon: Icon(
                                page.icon,
                                color: MyColors.getTabColor(page.typeIndex),
                                size: 22,
                              ),
                              //text: page.text)
                              /*child: Text(page.text,
                                    maxLines: 1,

                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(
                                            color: MyColors.getTabColor(
                                                page.typeIndex)))*/
                            )
                          : Tab(
                              icon: Icon(
                              page.icon,
                              color: Colors.white.withOpacity(0.5),
                              size: 22,
                            ));
                    }).toList(),
                  ),
                  actions: <Widget>[
                    buildIconButtonMap(buildCtx),
                  ],
                  title: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: AnimatedSwitcher(
                          //TODO fix animation, how to switch animted with a fade transition?
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            _title,
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Colors.white.withOpacity(0.7)),
                          ))),
                  //expandedHeight: 300.0, GOOD SPACE FOR ADS LATER
                  floating: true,
                  snap: true,
                  pinned: false),
            ];
          },
          body:
              /*Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child:*/
              TabBarView(
                  controller: tabController, children: buildAllTabContainer()),
        ),
      ),
    );
  }

  bool zoomMapAfterSelectLocation = false;

  Widget buildIconButtonMap(context) {
    return IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          handleMapButtonClick(context);
        });
  }

  void handleMapButtonClick(context) async {
    Merchant result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MapSample(
              _lists,
              mapPosition != null ? mapPosition : userPosition,
              zoomMapAfterSelectLocation
                  ? 10.0
                  : userPosition != null ? 5.0 : 0.0)),
    );
    updateDistanceToAllMerchantsIfNotDoneYet();
    if (result != null) {
      filterListUpdateTitle(result.name);
      tabController.animateTo(result.type);
      //showSnackBar("Showing selected merchant: " + result.name);
    } else {
      showUnfilteredLists();
      showSnackBar("Showing unfiltered list...");
    }
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(
        msg,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900]),
      ),
      backgroundColor: Colors.yellow[700],
    ));
  }

  List<Widget> buildAllTabContainer() {
    var builder = CardItemBuilder(_lists, userPosition);
    return [
      buildTabContainer(_listKeys[0], _lists[0], builder.buildItemRestaurant,
          Pages.pages[0].title),
      buildTabContainer(
          _listKeys[1], _lists[1], builder.buildItemTogo, Pages.pages[1].title),
      buildTabContainer(
          _listKeys[2], _lists[2], builder.buildItemBar, Pages.pages[2].title),
      buildTabContainer(_listKeys[3], _lists[3], builder.buildItemMarket,
          Pages.pages[3].title),
      buildTabContainer(
          _listKeys[4], _lists[4], builder.buildItemShop, Pages.pages[4].title),
      buildTabContainer(_listKeys[5], _lists[5], builder.buildItemHotel,
          Pages.pages[5].title),
      buildTabContainer(_listKeys[6], _lists[6], builder.buildItemWellness,
          Pages.pages[6].title),
    ];
  }

  bool isFilterEmpty() => _searchTerm == null || _searchTerm.isEmpty;

  Future<bool> initHasHitSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var tmp = prefs.getBool(sharedPrefKeyHasHitSearch);
    setState(() {
      hasHitSearch = tmp != null ? tmp : false;
    });

    return hasHitSearch;
  }

  Future<bool> persistHasHitSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(sharedPrefKeyHasHitSearch, true);
  }

  Widget buildHomeButton(context) {
    return isFilterEmpty()
        ? buildIconButtonSearch(context)
        : buildIconButtonClearFilter(context);
  }

  IconButton buildIconButtonClearFilter(ctx) {
    return IconButton(
      tooltip: 'Clear Filter',
      icon: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        color: Colors.white,
        progress: searchDelegate.transitionAnimation,
      ),
      onPressed: () {
        showUnfilteredLists();
        showSnackBar("Showing unfiltered list...");
      },
    );
  }

  /* Widget buildIconButtonMap(BuildContext ctx) {
    return IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          UrlLauncher.launchMapInPlayStoreFallbackToBrowser();
        });
  }*/

  Widget buildIconButtonSearch(BuildContext context) {
    return searchIconBlinkAnimation != null
        ? AnimatedBuilder(
            animation: searchIconBlinkAnimation,
            builder: (BuildContext context, Widget child) {
              return buildIconButtonSearchContainer(context);
            })
        : buildIconButtonSearchContainer(context);
  }

  IconButton buildIconButtonSearchContainer(BuildContext ctx) {
    return IconButton(
      icon: AnimatedIcon(
          color: searchIconBlinkAnimation != null && hasNotHitSearch()
              ? searchIconBlinkAnimation.value
              : Colors.white,
          progress: searchDelegate.transitionAnimation,
          icon: AnimatedIcons.search_ellipsis),
      onPressed: () async {
        final String selected = await showSearch<String>(
          context: ctx,
          delegate: searchDelegate,
        );
        if (hasNotHitSearch()) {
          showInfoDialogWithCloseButton(ctx);
          handleSearchButtonAnimationAndPersistHit();
        }
        //TODO ask users to rate the app

        if (selected != null) {
          filterListUpdateTitle(selected);
        } else {
          updateDistanceToAllMerchantsIfNotDoneYet();
          showUnfilteredLists();
        }
      },
      tooltip: 'Search',
    );
  }

  void handleSearchButtonAnimationAndPersistHit() async {
    if (searchIconBlinkAnimationController != null) {
      searchIconBlinkAnimationController.reset();
    }

    setState(() {
      hasHitSearch = true;
    });

    persistHasHitSearch();
  }

  bool hasNotHitSearch() => hasHitSearch == null || !hasHitSearch;

  void filterListUpdateTitle(String selectedLocationOrTag) {
    var selectedArray = selectedLocationOrTag.split(Suggestions.separator);
    final String title = selectedArray[0];
    final String search = title.split(" - ")[0];
    //if selectedItem contains separator ; it has the filename attached
    final String fileName = selectedArray.length > 1 ? selectedArray[1] : null;
    if (fileName != null) {
      zoomMapAfterSelectLocation = true;
    } else {
      zoomMapAfterSelectLocation = false;
    }

    var index = Tag.getTagIndex(selectedLocationOrTag);
    showMatchingSnackBar(fileName, search, index);

    loadAssets(index, search, fileName);

    setState(() {
      _searchTerm = search;
      _title = search;
    });
  }

  void showMatchingSnackBar(String fileName, String search, int index) {
    if (fileName != null)
      showSnackBar("Filtered by location: " + search);
    else if (index != -1 && fileName == null)
      showSnackBar("Filtered by tag: " + search);
    else
      showSnackBar("Merchant: " + search);
  }

  void showUnfilteredLists() {
    zoomMapAfterSelectLocation = false;
    mapPosition = null;
    updateTitle();
    if (isFilteredList()) {
      _searchTerm = '';
      loadAssetsUnfiltered();
    }
  }

  bool isFilteredList() => _searchTerm != null && _searchTerm.isNotEmpty;

  Widget buildTabContainer(var listKey, var list, var builderMethod, var cat) {
    return (list != null && list.length > 0)
        ? Padding(
            child: AnimatedList(
              key: listKey,
              initialItemCount: list.length,
              itemBuilder: builderMethod,
            ),
            padding: EdgeInsets.all(0.0),
          )
        : Padding(
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildSeparator(),
                Text(
                  'There are no matches in this category.',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                buildSeparator(),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: /*IconButton(icon: */ Icon(Icons.arrow_upward),
                        ),
                        const Text(
                          'Hit a colored icon to see matches.',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
                buildSeparator(),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        buildHomeButton(context),
                        const Text(
                          'Show all merchants of all categories.',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
              ],
            ));
  }

  SizedBox buildSeparator() {
    return const SizedBox(
      height: 20,
    );
  }

  void openAddNewPlaceWidget(BuildContext ctx) async {
    await Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (context) => AddNewPlaceWidget(
                selectedType: tabController.index,
                accentColor: getAccentColorOfSelectedTab(),
                actionBarColor: getDarkColorOfSelectedTab(),
                typeTitle: getTitleOfSelectedTab(),
              )),
    );
    updateDistanceToAllMerchantsIfNotDoneYet();
    showSnackBar("You are Satoshi Nakamoto!");
  }
}

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  //Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(AnimatedListSample());
}
