import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Coinector/InternetConnectivityChecker.dart';
import 'package:Coinector/Snackbars.dart';
import 'package:Coinector/translator.dart';
import 'package:connectivity/connectivity.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart' as synchro;

import 'AssetLoader.dart';
import 'CardItemBuilder.dart';
import 'Dialogs.dart';
import 'FileCache.dart';
import 'ListModel.dart';
import 'MapSample.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'SearchDemoSearchDelegate.dart';
import 'Suggestions.dart';
import 'Tag.dart';
import 'UrlLauncher.dart';
import 'pages.dart';

//import 'package:geohash/geohash.dart';
//import 'package:clustering_google_maps/clustering_google_maps.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final SearchDemoSearchDelegate searchDelegate = SearchDemoSearchDelegate();

  NestedScrollView appContent;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var scaffoldKey;
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController tabController;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  var assetLoader = AssetLoader();
  List<Merchant> names = new List<Merchant>(); // names we get from API
  List<ListModel<Merchant>> tempLists = [];
  List<ListModel<Merchant>> unfilteredLists = [];
  String titleActionBar = "Coinector";
  String addButtonCategory = "EAT";
  bool isUnfilteredList = false;
  bool
      hasHitSearch; //TODO count user activity by how often he hits search, how much he interacts with the app, reward him for that with badges or BMAP tokens
  var sharedPrefKeyHasHitSearch = "sharedPrefKeyHasHitSearch";
  var sharedPrefKeyLastLocation = "dsfdsfdsfdsfwer3e3r3";
  String _searchTerm;
  Position userPosition;
  Position mapPosition;

  Animation<Color> searchIconBlinkAnimation;
  AnimationController searchIconBlinkAnimationController;

  static bool latestPositionWasCoarse = false;

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //TODO CHECK IF THIS IS REALLY WORKING AS EXPECTED
    if (state == AppLifecycleState.resumed) {
      InternetConnectivityChecker.resumeAutoChecker();
    } else if (state == AppLifecycleState.paused) {
      InternetConnectivityChecker.pauseAutoChecker();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    InternetConnectivityChecker.pauseAutoChecker();
    Snackbars.close();
    InternetConnectivityChecker.close();
    if (positionStream != null) positionStream.cancel();
    isInitialized = false;
    isUpdatingPosition = false;
    isCheckingForUpdates = false;
    //isUnfilteredList = false;
    timerIsCancelled = true;
    Dialogs.dismissDialog();
    if (subscription != null) subscription.cancel();

    tabController.dispose();
    if (searchIconBlinkAnimationController != null)
      searchIconBlinkAnimationController.dispose();
    super.dispose();
  }

  void loadAssets(
      ctx, int filterWordIndex, String locationFilter, String fileName) async {
    updateCurrentPosition();

    if (_isUnfilteredSearch(filterWordIndex)) {
      _updateDistanceToAllMerchantsIfNotDoneYet();
      if (isUnfilteredList) return;
      //if (unfilteredLists.length != 0) updateListModel(unfilteredLists);
      this.isUnfilteredList = true;
    } else {
      this.isUnfilteredList = false;
    }

    initListModel();

    if (fileName == null) {
      _loadAndParseAllPlaces(filterWordIndex, locationFilter);
    } else {
      _loadAndParseAsset(filterWordIndex, locationFilter, fileName);
    }
  }

  var isCheckingForUpdates = false;
  var timerIsCancelled = false;

  void _checkForUpdatedData(ctx) async {
    if (isCheckingForUpdates || timerIsCancelled) return;
    isCheckingForUpdates = true;
    await checkDataUpdateShowSnackbarUpdateCache(ctx);
    Timer.periodic(Duration(seconds: 10), (timer) async {
      if (timerIsCancelled) timer.cancel();
      //if (timer.tick == 0) return; //skip first iteration
      try {
        await checkDataUpdateShowSnackbarUpdateCache(ctx);
        isCheckingForUpdates = false;
      } catch (e) {
        FileCache.forceUpdateNextTime();
      }
    });
  }

  Future<bool> checkDataUpdateShowSnackbarUpdateCache(ctx) async {
    FileCache.initLastVersion(() {
      //has new version
      if (timerIsCancelled) return false;
      _updateAllCachedContent(ctx);
      return true;
    });
    return false;
  }

  void _updateAllCachedContent(ctx) async {
    await FileCache.loadFromWebAndPersistCache('am');
    await FileCache.loadFromWebAndPersistCache('as');
    await FileCache.loadFromWebAndPersistCache('au');
    await FileCache.loadFromWebAndPersistCache('as-jap');
    await FileCache.loadFromWebAndPersistCache('am-ven-car');
    await FileCache.loadFromWebAndPersistCache('am-ven');
    await FileCache.loadFromWebAndPersistCache('e');
    await FileCache.loadFromWebAndPersistCache('e-spa');
    await FileCache.loadFromWebAndPersistCache('addr');
    await FileCache.loadFromWebAndPersistCache('placesId');
    Snackbars.showSnackBarRestartApp(_scaffoldKey, ctx);
    Future.delayed(Duration(seconds: 30), () {
      Phoenix.rebirth(ctx);
    });
  }

  void _loadAndParseAllPlaces(int filterWordIndex, String locationFilter) {
    _loadAndParseAsset(filterWordIndex, locationFilter, 'am');
    _loadAndParseAsset(filterWordIndex, locationFilter, 'as');
    _loadAndParseAsset(filterWordIndex, locationFilter, 'au');
    _loadAndParseAsset(filterWordIndex, locationFilter, 'e');
  }

  Future _loadAndParseAsset(
      int filterWordIndex, String locationFilter, String fileName) async {
    var decoded = await FileCache.loadAndDecodeAsset(fileName);
    parseAssetUpdateListModel(
        filterWordIndex, locationFilter, decoded, fileName, fileName != null);
  }

  bool _isUnfilteredSearch(int filterWordIndex) => filterWordIndex == -999;

  Future<void> parseAssetUpdateListModel(
      int selectedTagIndex,
      String locationFilter,
      List places,
      String serverId,
      bool isLocationSearch) async {
    initTempListModel();
    for (int i = 0; i < places.length; i++) {
      Merchant m2 = Merchant.fromJson(places.elementAt(i));
      m2.serverId = serverId;
      //at the moment there is no PAY feature: m2.isPayEnabled = await AssetLoader.loadReceivingAddress(m2.id) != null;

      _insertIntoTempList(m2, selectedTagIndex, locationFilter);
    }

    if (!isLocationSearch) mapPosition = null;

    if (unfilteredLists.length == 0) initUnfilteredLists();

    updateListModel(tempLists);
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
        var lock = synchro.Lock();
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
      if (mounted)
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

    double distanceInMeters = await GeolocatorPlatform.instance
        .distanceBetween(position.latitude, position.longitude, m.x, m.y);

    m.distanceInMeters = distanceInMeters;
    var distance = distanceInMeters.round().toString() + " meter";

    if (distanceInMeters > 1000) {
      String km = (distanceInMeters / 1000.0).toStringAsFixed(2);
      distance = km + " km";
    }

    if (mounted)
      setState(() {
        m.distance = distance;
      });
    return true;
  }

  void updateListModel(List<ListModel<Merchant>> tmpList) {
    updateList(_lists, tmpList, true);
    isInitialized = true;
  }

  void animateToFirstResult(merchant) async {
    if (tabController.indexIsChanging) return;

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
      mapPosition = Position(latitude: m2.x, longitude: m2.y);

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
      _isUnfilteredSearch(filterWordIndex);

  void initListModelSeveralTimes(List lists, bool keepListKeys) {
    lists.clear();
    if (keepListKeys) _listKeys.clear();
    for (int i = 0; i < Pages.pages.length + 1; i++) {
      if (keepListKeys)
        _listKeys.add(GlobalKey<AnimatedListState>(
            debugLabel: "Scaffoldkey Listmodel no." + i.toString()));
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

  _handleTabSelection() async {
    if (!isFilteredList()) updateTitleToCurrentlySelectedTab();
    updateAddButtonCategory();
    await initCurrentPositionIfNotInitialized();
    _updateDistanceToAllMerchantsIfNotDoneYet();
  }

  void requestCurrentPosition() async {
    if (kIsWeb) {
      return null;
    }
    try {
      LocationPermission p = await Geolocator.requestPermission();
      if (p == LocationPermission.whileInUse ||
          p == LocationPermission.always) {
        await updateCurrentPosition();
        _updateDistanceToAllMerchantsIfNotDoneYet();
      }
    } catch (e) {
      FlutterError.presentError(e);
    }
  }

  void initCurrentPositionIfNotInitialized() async {
    if (userPosition != null) return;

    //TODO check if that call is correct, might make sense to request permission always if necesssary?
    await updateCurrentPosition();
  }

/*
  successGetWebCoordinates(GeolocationPosition pos) {
    try {
      Position p = pos.mapToPosition();
      setLatestPosition(p);
      debugPrint("\n\n\n\n\n\n\n\n#####################################\n\n\n\n\n\n\n\n" + pos.coords.latitude.toString());
      debugPrint(pos.coords.longitude.toString());
    } catch (ex) {
      print("Exception thrown : " + ex.toString());
    }
  }

  void _getCurrentLocationWeb() async {
    if (kIsWeb) {
      getCurrentPositionWeb((pos) {
        return successGetWebCoordinates(pos);
      });
    }
  }
*/

  static var isUpdatingPosition = false;

  Future<bool> updateCurrentPosition() async {
    //if (isUpdatingPosition) return false;
    isUpdatingPosition = true;
    //ALWAYS GET LOCATION VIA IP FIRST TO HAVE SOMETHING AT STARTUP
    //if (kIsWeb) {
    //_getCurrentLocationWeb();
    //return true;
    // } else {
    if (!kIsWeb && await Permission.locationWhenInUse.isGranted) {
      Position pos = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //setState(() {
      userPosition = pos;
      //});
//TODO FIND BUG AFTER RELOAD WITH POSITION THE APP HANGS ON START
      try {
        if (await setLatestPosition(pos)) {
          if (latestPositionWasCoarse) _onGetAccurateGPSFirstTime();
        }
      } catch (e) {
        debugPrint("\n\n\”dgfdbvevgreave\n\n\n" + e.toString());
      }
      latestPositionWasCoarse = false;
    } else if (await setLatestPosition(await _getCoarseLocationViaIP())) {
      //TODO silently update the data
      latestPositionWasCoarse = true;
      //_updateDistanceToAllMerchantsNow();
      //showSnackBarGPS();
      //After getting coarse location we do nothing
    }
    //latestPositionWasCoarse = true;
    isUpdatingPosition = false;
    return true;
    //}
    //return false;
  }

  void _onGetAccurateGPSFirstTime() async {
    //TODO find out how to update the distance and repaint the tree
    Snackbars.showSnackBarGPS(_scaffoldKey, context);

    Future.delayed(
      Duration(seconds: 3),
    ).whenComplete(() {
      Phoenix.rebirth(context);
    });
  }

  Future<bool> setLatestPosition(Position pos) async {
    String position = await getLatestSavedPosition();
    var posString = _buildPosString(pos);
    if (posString != null && position == posString) return false;

    bool success = await _saveLatestSavedPosition(posString);

    setState(() {
      userPosition = pos;
    });
    return success;
  }

  String _buildPosString(Position pos) => pos != null && pos.latitude != null
      ? (pos.latitude.toString() + ";" + pos.longitude.toString())
      : null;

  initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition(ctx) async {
    var position = await getLatestSavedPosition();
    if (position != null && position.isNotEmpty) {
      setState(() {
        userPosition = Position(
            latitude: parseDouble(position, 0),
            longitude: parseDouble(position, 1));
      });
    }

    loadAssetsUnfiltered(ctx);
    requestCurrentPosition();
  }

  double parseDouble(String position, int piece) =>
      double.parse(position.split(";")[piece]);

  StreamSubscription subscription;

  static var isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    scaffoldKey = _scaffoldKey;
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!kIsWeb)
        InternetConnectivityChecker.checkInternetConnectivityShowSnackbar(
            kIsWeb, this, (abc) {
          Snackbars.showInternetErrorSnackbar(this);
        });
    });
    initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition(context);
    //OneSignal.initOneSignalPushMessages();
    searchDelegate.buildHistory();
    tabController = TabController(vsync: this, length: Pages.pages.length);
    tabController.addListener(_handleTabSelection);
    initListModel();
    if (hasNotHitSearch()) {
      initHasHitSearch().then((hasHit) {
        if (!hasHit) initBlinkAnimation();
      });
    }

    _checkForUpdatedData(context);

    Future.delayed(Duration(seconds: 5), () {
      Snackbars.showSnackBarPlayStore(kIsWeb, _scaffoldKey, context);
    });
    //initPositionStream();
  }

  void initPositionStream() async {
    positionStream = Geolocator.getPositionStream(distanceFilter: 500)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  StreamSubscription<Position> positionStream;

  void loadAssetsUnfiltered(ctx) => loadAssets(ctx, -999, null, null);

  void _updateDistanceToAllMerchantsIfNotDoneYet() {
    if (userPosition == null) return;

    _updateDistanceToAllMerchantsNow();
  }

  void _updateDistanceToAllMerchantsNow() async {
    for (int i = 0; i < _lists.length; i++) {
      ListModel<Merchant> model = _lists[i];
      for (int x = 0; x < model.length; x++) {
        Merchant m = model[x];

        if (m.distance != null) return;

        await calculateDistanceUpdateMerchant(userPosition, m);
      }
    }
  }

  void updateTitleToCurrentlySelectedTab() {
    setState(() {
      titleActionBar = getTitleOfSelectedTab();
    });
  }

  void updateAddButtonCategory() {
    setState(() {
      addButtonCategory = Pages.pages[tabController.index].text;
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
  Widget build(BuildContext ctxRoot) {
    /*new Future.delayed(Duration.zero, () async {
      Translator.currentLocale(context);
    });*/
    if (kIsWeb) {
      InternetConnectivityChecker.pauseAutoChecker();
    } else {
      InternetConnectivityChecker.resumeAutoChecker();
      InternetConnectivityChecker.checkInternetConnectivityShowSnackbar(
          kIsWeb, this, (abc) {
        Snackbars.showInternetErrorSnackbar(this);
      });
    }
    return MaterialApp(
        localizationsDelegates: [
          FlutterI18nDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('de'),
          const Locale('it'),
          const Locale('es'),
          const Locale('en'),
          const Locale('ja'),
          const Locale('id'),
          const Locale('fr')
        ],
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
        home: new WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            key: _scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Builder(
              builder: (builderCtx) => FloatingActionButton.extended(
                  backgroundColor: getColorOfSelectedTab(),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    openAddNewPlaceWidget(builderCtx);
                  },
                  label: Text(
                      Translator.translate(builderCtx, "floatbutton_add") +
                          Translator.translate(
                              builderCtx, addButtonCategory.toUpperCase())),
                  icon: Icon(Icons.add_location)),
            ),
            body: new Builder(builder: (BuildContext ctx) {
              //Translator.refresh(ctx, Locale("en"));
              /*new Future.delayed(Duration.zero, () async {
            await Translator.refresh(ctx, new Locale('de'));
          });*/
              appContent = NestedScrollView(
                headerSliverBuilder:
                    (BuildContext buildCtx, bool innerBoxIsScrolled) {
                  /*new Future.delayed(Duration.zero, () async {
                await Translator.refresh(buildCtx, new Locale('de'));
              });*/
                  return <Widget>[
                    SliverAppBar(
                        elevation: 2,
                        forceElevated: true,
                        leading: buildHomeButton(buildCtx),
                        bottom: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          indicator: getIndicator(),
                          tabs: Pages.pages.map<Tab>((Pagee page) {
                            return _lists[page.tabIndex].length > 0
                                ? Tab(
                                    icon: Icon(
                                      page.icon,
                                      color:
                                          MyColors.getTabColor(page.typeIndex),
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
                            padding: EdgeInsets.all(0.0),
                            child: AnimatedSwitcher(
                                //TODO fix animation, how to switch animted with a fade transition?
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  titleActionBar,
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
                        controller: tabController,
                        children: buildAllTabContainer(ctx)),
              );
              return appContent;
            }),
          ),
        ));
  }

  bool zoomMapAfterSelectLocation = false;

  Widget buildIconButtonMap(ctx) {
    return IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          handleMapButtonClick(ctx);
        });
  }

  void handleMapButtonClick(ctx) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        InternetConnectivityChecker.pauseAutoChecker();
        Merchant result = await Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (buildCtx) => MapSample(
                  _lists,
                  mapPosition != null ? mapPosition : userPosition,
                  zoomMapAfterSelectLocation
                      ? 10.0
                      : userPosition != null
                          ? 5.0
                          : 0.0)),
        );
        _updateDistanceToAllMerchantsIfNotDoneYet();
        if (result != null) {
          filterListUpdateTitle(ctx, result.name);
          tabController.animateTo(result.type);
          //showSnackBar("Showing selected merchant: " + result.name);
        } else {
          showUnfilteredLists(ctx);
        }
      }
    } catch (e) {
      //forward users to bitcoinmap.cash if app is started in web
      UrlLauncher.launchBitcoinMap();
    }
  }

  List<Widget> buildAllTabContainer(ctx) {
    var builder = CardItemBuilder(_lists);
    return [
      buildTabContainer(ctx, _listKeys[0], _lists[0],
          builder.buildItemRestaurant, Pages.pages[0].title),
      buildTabContainer(ctx, _listKeys[1], _lists[1], builder.buildItemTogo,
          Pages.pages[1].title),
      buildTabContainer(ctx, _listKeys[2], _lists[2], builder.buildItemBar,
          Pages.pages[2].title),
      buildTabContainer(ctx, _listKeys[3], _lists[3], builder.buildItemMarket,
          Pages.pages[3].title),
      buildTabContainer(ctx, _listKeys[4], _lists[4], builder.buildItemShop,
          Pages.pages[4].title),
      buildTabContainer(ctx, _listKeys[5], _lists[5], builder.buildItemHotel,
          Pages.pages[5].title),
      buildTabContainer(ctx, _listKeys[6], _lists[6], builder.buildItemWellness,
          Pages.pages[6].title),
    ];
  }

  bool isFilterEmpty() => _searchTerm == null || _searchTerm.isEmpty;

  Future<bool> _saveLatestSavedPosition(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefKeyLastLocation, value);
  }

  Future<String> getLatestSavedPosition() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefKeyLastLocation);
  }

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

  Widget buildHomeButton(ctx) {
    return isFilterEmpty()
        ? buildIconButtonSearch(ctx)
        : buildIconButtonClearFilter(ctx);
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
        /*setState(() {
          showLoading();
        });*/

        showUnfilteredLists(ctx);
      },
    );
  }

  void proposeReview() async {
    if (kIsWeb) return;

    try {
      final InAppReview inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }

      await inAppReview.openStoreListing(appStoreId: "1522720562");
    } catch (e) {
      debugPrint(e);
    }
  }

  var lastMilliSeconds = 0;

  Future<bool> _onWillPop() async {
    //User has to tap twice on the back button within one second to exit the app
    var milliSecondsNow = DateTime.now().millisecondsSinceEpoch;
    if (lastMilliSeconds != 0 && lastMilliSeconds + 1000 > milliSecondsNow) {
      lastMilliSeconds = milliSecondsNow;
      return true;
    }
    //TODO TEST PROPOSE REVIEW TO USER
    proposeReview();
    lastMilliSeconds = milliSecondsNow;
    return false;
  }

  /* Widget buildIconButtonMap(BuildContext ctx) {
    return IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          UrlLauncher.launchMapInPlayStoreFallbackToBrowser();
        });
  }*/

  Widget buildIconButtonSearch(BuildContext ctx) {
    return searchIconBlinkAnimation != null
        ? AnimatedBuilder(
            animation: searchIconBlinkAnimation,
            builder: (BuildContext buildCtx, Widget child) {
              return buildIconButtonSearchContainer(ctx);
            })
        : buildIconButtonSearchContainer(ctx);
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
        InternetConnectivityChecker.pauseAutoChecker();
        try {
          final String selected = await showSearch<String>(
            context: ctx,
            delegate: searchDelegate,
          );
          InternetConnectivityChecker.resumeAutoChecker();

          if (hasNotHitSearch()) {
            Dialogs.showInfoDialogWithCloseButton(ctx);
            handleSearchButtonAnimationAndPersistHit();
          }
          //TODO ask users to rate the app

          if (selected != null) {
            filterListUpdateTitle(ctx, selected);
          } else {
            _updateDistanceToAllMerchantsIfNotDoneYet();
            showUnfilteredLists(ctx);
          }
        } catch (e) {
          InternetConnectivityChecker.resumeAutoChecker();
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

  void filterListUpdateTitle(ctx, String selectedLocationOrTag) {
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
    Snackbars.showMatchingSnackBar(
        _scaffoldKey, ctx, fileName, capitalize(search), index);

    loadAssets(ctx, index, search, fileName);

    setState(() {
      _searchTerm = search;
      titleActionBar = capitalize(search);
    });
  }

  String capitalize(String search) {
    return search.substring(0, 1).toUpperCase() +
        search.substring(1, search.length);
  }

  void showUnfilteredLists(ctx) {
    zoomMapAfterSelectLocation = false;
    mapPosition = null;
    updateTitleToCurrentlySelectedTab();
    if (isFilteredList()) {
      _searchTerm = '';
      loadAssetsUnfiltered(ctx);
    }
    Snackbars.showSnackBarUnfilteredList(_scaffoldKey, ctx);
  }

  bool isFilteredList() => _searchTerm != null && _searchTerm.isNotEmpty;

  Widget buildTabContainer(
      ctx, var listKey, var list, var builderMethod, var cat) {
    return (list != null && list.length > 0)
        ? Padding(
            child: AnimatedList(
              key: listKey,
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 60.0),
              initialItemCount: list.length,
              itemBuilder: builderMethod,
            ),
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          )
        : !isInitialized
            ? Center(
                child: Loading(
                    color: Colors.white,
                    indicator: BallGridPulseIndicator(),
                    size: 40),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSeparator(),
                    Text(
                      Translator.translate(ctx, "no_matches"),
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    buildSeparator(),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: /*IconButton(icon: */ Icon(
                                  Icons.arrow_upward),
                            ),
                            Text(
                              Translator.translate(ctx, "hit_icon"),
                              style: TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        )),
                    buildSeparator(),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            buildHomeButton(ctx),
                            Text(
                              Translator.translate(ctx, "show_all_merchants"),
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
    UrlLauncher.launchSubmitForm();
    /*await Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (buildCtx) => AddNewPlaceWidget(
                selectedType: tabController.index,
                accentColor: getAccentColorOfSelectedTab(),
                actionBarColor: getDarkColorOfSelectedTab(),
                typeTitle: addButtonCategory,
              )),
    );
    updateDistanceToAllMerchantsIfNotDoneYet();
    showSnackBar(ctx, "snackbar_you_are_satoshi");*/
  }

  Future<Position> _getCoarseLocationViaIP() async {
    try {
      var response = await new Dio().get('https://geolocation-db.com/json/');
      var responseJSON = json.decode(response.data);
      var longitude = responseJSON['longitude'];
      var latitude = responseJSON['latitude'];
      if (longitude is int) {
        longitude = double.parse(longitude.toString());
      }
      if (latitude is int) {
        latitude = double.parse(latitude.toString());
      }
      if (longitude is double)
        userPosition = new Position(longitude: longitude, latitude: latitude);
      else
        debugPrint(
            "RECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER");

      return userPosition;
    } catch (e) {
      debugPrint(e.toString());
    }
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
    //Crashlytics.instance.onError(details);
    //just ignore the errors for now to have less library dependencies
  };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: AnimatedListSample()));
  //runApp(AnimatedListSample());
}
