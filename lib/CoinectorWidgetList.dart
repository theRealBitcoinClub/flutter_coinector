import 'dart:async';
import 'dart:convert';

import 'package:Coinector/AssetLoader.dart';
import 'package:Coinector/InternetConnectivityChecker.dart';
import 'package:Coinector/ItemInfoStackLayer.dart';
import 'package:Coinector/Snackbars.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/translator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart' as synchro;

import 'AddNewPlaceWidget.dart';
import 'CardItemBuilder.dart';
import 'Dialogs.dart';
import 'FileCache.dart';
import 'ListModel.dart';
import 'LocationSuggestions.dart';
import 'MapSample.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'PieChartCoins.dart';
import 'SearchDemoSearchDelegate.dart';
import 'TabPageCategory.dart';
import 'TagBrands.dart';
import 'TagCoinector.dart';
import 'UrlLauncher.dart';

const bool isManagerModeRelease = false;

class CoinectorWidget extends StatefulWidget {
  final String search;

  CoinectorWidget(String search) : this.search = search;

  @override
  _CoinectorWidgetState createState() => _CoinectorWidgetState(search);
}

class _CoinectorWidgetState extends State<CoinectorWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver, TagFilterCallback {
  SearchDemoSearchDelegate searchDelegate;

  Map<String, List> _cachedDecodedDataBase = Map();
  Map<String, List<Merchant>> _cachedMerchants = Map();

  _CoinectorWidgetState(String search) {
    urlSearch = search;
  }

  String urlSearch;
  StreamSubscription subscriptionConnectivityChangeListener;

  static var isInitialized = false;
  List<ScrollController> _scrollControlList = [];

  NestedScrollView appContent;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var scaffoldKey;
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController tabController;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  Map<String, Merchant> _uniqueMerchantMap = Map();
  List<Merchant> names = []; // names we get from API
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

  //Animation<Color> searchIconBlinkAnimation;
  //AnimationController searchIconBlinkAnimationController;

  static bool latestPositionWasCoarse = false;
/*
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
  }*/

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
    //if (_verticalScroller != null) _verticalScroller.close();
    WidgetsBinding.instance.removeObserver(this);
    InternetConnectivityChecker.pauseAutoChecker();
    Snackbars.close();
    InternetConnectivityChecker.close();
    if (positionStream != null) positionStream.cancel();
    isInitialized = false;
    //isUpdatingPosition = false;
    isCheckingForUpdates = false;
    //isUnfilteredList = false;
    checkDataUpdateTimerIsCancelled = true;
    Dialogs.dismissDialog();
    if (subscriptionConnectivityChangeListener != null)
      subscriptionConnectivityChangeListener.cancel();

    tabController.dispose();
    /*if (searchIconBlinkAnimationController != null)
      searchIconBlinkAnimationController.dispose();*/
    super.dispose();
  }

  void loadAssets(
      ctx, TagCoinector tagFilter, String locationOrTitleFilter) async {
    updateCurrentPosition();

    if (tagFilter == null && locationOrTitleFilter == null) {
      _updateDistanceToAllMerchantsIfNotDoneYet();
      if (isUnfilteredList) return;
      //if (unfilteredLists.length != 0) updateListModel(unfilteredLists);
      this.isUnfilteredList = true;
    } else {
      this.isUnfilteredList = false;
    }

    initListModel();

    _loadAndParseAllPlaces(tagFilter, locationOrTitleFilter);
  }

  var isCheckingForUpdates = false;
  var checkDataUpdateTimerIsCancelled = false;

  void _checkForUpdatedData(ctx) async {
    if (kIsWeb) return;
    if (isCheckingForUpdates || checkDataUpdateTimerIsCancelled) return;
    isCheckingForUpdates = true;
    bool hasUpdatedData = await checkDataUpdateShowSnackbarUpdateCache(ctx);
    if (hasUpdatedData) {
      checkDataUpdateTimerIsCancelled = true;
      isCheckingForUpdates = false;
      return;
    }
    Timer.periodic(Duration(seconds: 30), (timer) async {
      if (checkDataUpdateTimerIsCancelled) timer.cancel();
      try {
        bool hasUpdatedData = await checkDataUpdateShowSnackbarUpdateCache(ctx);
        if (hasUpdatedData) {
          checkDataUpdateTimerIsCancelled = true;
        }
        isCheckingForUpdates = false;
      } catch (e) {
        FileCache.forceUpdateNextTime();
      }
    });
  }

  Future<bool> checkDataUpdateShowSnackbarUpdateCache(ctx) async {
    FileCache.initLastVersion((String version) {
      //has new version
      if (checkDataUpdateTimerIsCancelled) return false;
      _updateAllCachedContent(ctx, version);
      return true;
    });
    return false;
  }

  void _updateAllCachedContent(ctx, String version) async {
    if (kIsWeb) return;

    if (await FileCache.loadFromWebAndPersistCache('am') &&
        await FileCache.loadFromWebAndPersistCache('as') &&
        await FileCache.loadFromWebAndPersistCache('au') &&
        await FileCache.loadFromWebAndPersistCache('e')) {
      // await FileCache.loadFromWebAndPersistCache('addr');
      // await FileCache.loadFromWebAndPersistCache('placesId');

      Snackbars.showSnackBarRestartApp(_scaffoldKey, ctx);
      _cachedDecodedDataBase = Map();
      _cachedMerchants = Map();
      AssetLoader.cachedAssets = Map();
      FileCache.memoryCache = Map();
      // Future.delayed(Duration(seconds: 30), () {
      //   Phoenix.rebirth(ctx);
      // });
      FileCache.persistCacheVersionCounter(version);
    }
  }

  void _loadAndParseAllPlaces(TagCoinector tag, String locationFilter) async {
    await _loadAndParseAsset(tag, locationFilter, 'am');
    await _loadAndParseAsset(tag, locationFilter, 'as');
    await _loadAndParseAsset(tag, locationFilter, 'au');
    await _loadAndParseAsset(tag, locationFilter, 'e');
    // printUniqueMerchantMap();
  }

  Future _loadAndParseAsset(
      TagCoinector tag, String locationOrTitleFilter, String fileName) async {
    if (_cachedDecodedDataBase[fileName] == null)
      _cachedDecodedDataBase[fileName] =
          await FileCache.loadAndDecodeAsset(fileName);

    parseAssetUpdateListModel(
        tag, locationOrTitleFilter, _cachedDecodedDataBase[fileName], fileName);
  }

  Future<void> parseAssetUpdateListModel(TagCoinector tag,
      String locationTitleFilter, List places, String fileName) async {
    initTempListModel();
    bool isLocation = false;
    if (locationTitleFilter != null && locationTitleFilter != "null") {
      locationTitleFilter = locationTitleFilter.toLowerCase();
      isLocation = LocationSuggestions.locations.contains(locationTitleFilter);
    } else
      locationTitleFilter = null;

    if (_cachedMerchants[fileName] == null) _cachedMerchants[fileName] = [];

    for (int i = 0; i < places.length; i++) {
      Merchant m2;
      if (_cachedMerchants[fileName].length < places.length) {
        m2 = Merchant.fromJson(places.elementAt(i));
        _cachedMerchants[fileName].add(m2);
      } else
        m2 = _cachedMerchants[fileName][i];

      // checkDuplicate(m2);
      // addToUniqueMerchantMap(fileName, m2);
      //at the moment there is no PAY feature: m2.isPayEnabled = await AssetLoader.loadReceivingAddress(m2.id) != null;
      int brandFilter = -1;
      bool isTitle = true;
      String coinFilter = "";
      if (locationTitleFilter != null) {
        brandFilter = checkForBrandFilter(m2, locationTitleFilter);
        coinFilter = checkForCoinFilter(m2, locationTitleFilter);
        //TODO CURRENTLY TITLE IS CHECKED WHEN ALL OTHER CHECKS ARE RESULTLESS
        // isTitle = SuggestionsTitles.titleTags.contains(locationTitleFilter);
      }
      _insertIntoTempList(m2, tag, locationTitleFilter, isLocation, isTitle,
          brandFilter, coinFilter);
    }

    //TODO IMPROVE MAP POSITIONING
    if (locationTitleFilter == null && tag == null) mapPosition = null;

    if (unfilteredLists.length == 0) initUnfilteredLists();

    updateListModel(tempLists);
  }

  String checkForCoinFilter(Merchant m2, String locationTitleFilter) {
    return m2.acceptedCoins != null ? _containsCoin(locationTitleFilter) : "";
  }

  int checkForBrandFilter(Merchant m2, String locationTitleFilter) {
    return m2.brand != null ? _containsBrand(locationTitleFilter) : -1;
  }

  void addToUniqueMerchantMap(String fileName, Merchant m2) {
    if (kReleaseMode) return;
    // if (!m2.id.startsWith("ChI")) return;

    var key = fileName + ";" + m2.id;
    Merchant uniqueMerchant = _uniqueMerchantMap[key];
    if (uniqueMerchant == null)
      _uniqueMerchantMap[key] = m2;
    else {
      if (int.parse(uniqueMerchant.reviewCount) < int.parse(m2.reviewCount)) {
        _uniqueMerchantMap[key] = m2;
      } else if (int.parse(uniqueMerchant.reviewCount) ==
          int.parse(m2.reviewCount)) {
        if (uniqueMerchant.tagsDatabaseFormat
                .contains(TagCoinector.PLACEHOLDER_TAG) &&
            !m2.tagsDatabaseFormat.contains(TagCoinector.PLACEHOLDER_TAG)) {
          _uniqueMerchantMap[key] = m2;
        }
      }
    }
  }

  int _containsBrand(String locationTitleFilter) {
    // print("\nBRAND" + m2.brand.toString());
    int brandIndex = -1;

    for (int x = 0; x < TagBrand.getBrands().length; x++) {
      TagBrand e = TagBrand.getBrands().elementAt(x);
      brandIndex = checkBrand(e, locationTitleFilter);
      if (brandIndex != -1) break;
    }

    // print("\brandIndex" + brandIndex.toString());
    return brandIndex;
  }

  String _containsCoin(String locationTitleFilter) {
    // print("\nCOINS" + m2.acceptedCoins.toString());
    StringBuffer coins = new StringBuffer();
    TagCoin.getTagCoins()
        .forEach((TagCoin e) => checkCoin(e, locationTitleFilter, coins));
    return coins.toString();
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

    double distanceInMeters = GeolocatorPlatform.instance
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

  void animateToFirstResult(Merchant merchant) async {
    if (tabController.indexIsChanging) return;

    if (merchant != null) {
      animateToTab(merchant);
      return;
    }

    for (int i = 0; i < _lists.length; i++) {
      ListModel<Merchant> model = _lists[i];
      for (int x = 0; x < model.length; x++) {
        Merchant m = model[x];
        animateToTab(m);
        return;
      }
    }
  }

  void animateToTab(Merchant merchant) {
    tabController.animateTo(TabPages.getTabIndex(merchant));
  }

  void initUnfilteredLists() {
    initListModelSeveralTimes(unfilteredLists, false);
    updateList(unfilteredLists, tempLists, false);
  }

  bool matchesFilteredTag(Merchant m, TagCoinector filterTag) {
    var splittedTags = m.tagsDatabaseFormat.split(',');
    for (int i = 0; i < splittedTags.length; i++) {
      try {
        //TODO use merchants tags int list only use text for db
        int currentTag = int.parse(splittedTags[i]);
        if (currentTag == filterTag.id) {
          return true;
        }
      } catch (e) {
        print("Illegal character in tag attribute array for merchant:" +
            m.id.toString());
      }
    }
    return false;
  }

  bool _containsLocationPrefilled(Merchant m, String location) {
    return _containsString(m.location, location.split(" ")[0]);
  }

  bool _containsLocationFreeSearch(Merchant m, String location) {
    String locationClean = location.split(" - ")[0];
    return _containsString(m.location, locationClean) ||
        _containsString(locationClean, m.location);
  }

  bool _containsTitle(Merchant m, String title) {
    String titleClean = title.split(" - ")[0].split(",")[0];
    return _containsString(m.name, titleClean) ||
        _containsString(titleClean, m.name);
  }

  bool _containsString(String src, String pattern) {
    if (pattern == null || pattern.isEmpty || src == null || src.isEmpty)
      return false;

    return src.toLowerCase().contains(pattern.toLowerCase().trim());
  }

  void _insertIntoTempList(
      Merchant m2,
      TagCoinector tag,
      String locationTitleOrTag,
      bool isLocation,
      bool isTitle,
      int brand,
      String coin) {
    if (coin.isNotEmpty && !m2.acceptedCoins.contains(coin)) {
      if (!kReleaseMode) print("coinfilter");
      return;
    }
    if (brand != -1 && m2.brand != brand) {
      if (!kReleaseMode) print("brandfilter");
      return;
    }
    if (tag != null && filterWordIndexDoesNotMatch(tag, m2)) {
      if (!kReleaseMode) print("tagfilter");
      return;
    }
    if (locationTitleOrTag != null) {
      if (isLocation && !_containsLocationPrefilled(m2, locationTitleOrTag)) {
        if (!kReleaseMode) print("locationPrefilledFilter");
        return;
      }
      if (tag == null &&
          !isLocation &&
          coin.isEmpty &&
          brand == -1 &&
          isTitle &&
          !_containsTitle(m2, locationTitleOrTag) &&
          !_containsLocationFreeSearch(m2, locationTitleOrTag)) {
        if (!kReleaseMode) print("titlefilter");
        return;
      }
    }

    if (tag == null &&
        locationTitleOrTag !=
            null) //TODO why is this setting the position on every single merchant????
      mapPosition = Position(
          latitude: m2.x,
          longitude: m2.y,
          speedAccuracy: 0.0,
          altitude: 0.0,
          accuracy: 0.0,
          heading: 0.0,
          speed: 0.0,
          timestamp: DateTime.now());

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

  bool filterWordIndexDoesNotMatch(TagCoinector filterTag, Merchant m2) {
    return filterTag == null ||
        (filterTag != null && !matchesFilteredTag(m2, filterTag));
  }

  void initListModelSeveralTimes(List lists, bool keepListKeys) {
    lists.clear();
    if (keepListKeys) _listKeys.clear();
    for (int i = 0; i < TabPages.pages.length + 1; i++) {
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
    /*setState(() {
      if (_verticalScroller != null &&
          _verticalScroller.state != null &&
          _verticalScroller.state.mounted) {
        _verticalScroller.state.resetOffset();
      }
    });*/
    if (!isFilteredList()) updateTitleToCurrentlySelectedTab();
    updateAddButtonCategory();
    initCurrentPositionIfNotInitialized()
        .then((value) => _updateDistanceToAllMerchantsIfNotDoneYet());
  }

  void updateCurrentListItemCounter() {
    currentListItemCounter = _lists[tabController.index].length;
  }

  void requestCurrentPosition() async {
    if (kIsWeb) {
      return null;
    }
    try {
      LocationPermission p = await Geolocator.requestPermission();
      if (p == LocationPermission.whileInUse ||
          p == LocationPermission.always) {
        updateCurrentPosition()
            .then((value) => _updateDistanceToAllMerchantsIfNotDoneYet());
      }
    } catch (e) {
      FlutterError.presentError(e);
    }
  }

  Future<bool> initCurrentPositionIfNotInitialized() async {
    if (userPosition != null) return false;

    return await updateCurrentPosition();
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

  //static var isUpdatingPosition = false;

  Future<bool> updateCurrentPosition() async {
    //if (isUpdatingPosition) return false;
    //isUpdatingPosition = true;
    //ALWAYS GET LOCATION VIA IP FIRST TO HAVE SOMETHING AT STARTUP
    //if (kIsWeb) {
    //_getCurrentLocationWeb();
    //return true;
    // } else {
    if (!kIsWeb && await Permission.locationWhenInUse.isGranted) {
      Position pos = await GeolocatorPlatform.instance.getLastKnownPosition();
      //setState(() {
      userPosition = pos;
      //});
//TODO FIND BUG AFTER RELOAD WITH POSITION THE APP HANGS ON START
      //try {
      if (await setLatestPosition(pos)) {
        if (latestPositionWasCoarse) _onGetAccurateGPSFirstTime();
      }
      /*} catch (e) {
        debugPrint("\n\n\”dgfdbvevgreave\n\n\n" + e.toString());
      }*/
      latestPositionWasCoarse = false;
    } else if (await setLatestPosition(await _getCoarseLocationViaIP())) {
      //TODO silently update the data
      latestPositionWasCoarse = true;
      //_updateDistanceToAllMerchantsNow();
      //showSnackBarGPS();
      //After getting coarse location we do nothing
    }
    //latestPositionWasCoarse = true;
    //isUpdatingPosition = false;
    return true;
    //}
    //return false;
  }

  void _onGetAccurateGPSFirstTime() async {
    if (!mounted) return;
    //TODO find out how to update the distance and repaint the tree
    Snackbars.showSnackBarGPS(_scaffoldKey, context);

    Future.delayed(
      Duration(seconds: 3),
    ).whenComplete(() {
      if (!mounted) return;
      Phoenix.rebirth(context);
    });
  }

/*
  Future<bool> initDataSaverOfflineMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tmp = prefs.getBool("sjlfsjlfjsjnwfuinsnvsdjnvsn");

    isDataSaverOfflineMode = tmp != null ? tmp : false;
    return isDataSaverOfflineMode;
  }
*/
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
    print("START initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition");
    var position = await getLatestSavedPosition();
    print("START initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition1");
    if (position != null && position.isNotEmpty) {
      setState(() {
        userPosition = Position(
            latitude: parseDouble(position, 0),
            longitude: parseDouble(position, 1),
            speedAccuracy: 0.0,
            altitude: 0.0,
            accuracy: 0.0,
            heading: 0.0,
            speed: 0.0,
            timestamp: DateTime.now());
      });
    }

    if (urlSearch != null && urlSearch.isNotEmpty && urlSearch.length > 2) {
      print("START initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition3");
      startProcessSearch(ctx, urlSearch, true);
    } else {
      print("START initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition4");
      loadAssetsUnfiltered(ctx);
    }
    requestCurrentPosition();
    print("START initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition5");
  }

  double parseDouble(String position, int piece) =>
      double.parse(position.split(";")[piece]);

  @override
  void initState() {
    super.initState();
    print("START initState");
    TagCoinector.initFromFiles();
    print("START initState2");

    if (_scrollControlList.isEmpty)
      TabPages.pages.forEach((element) {
        _scrollControlList.add(ScrollController());
      });
    //_verticalScroller = buildCustomScroller();
    WidgetsBinding.instance.addObserver(this);
    scaffoldKey = _scaffoldKey;
    subscriptionConnectivityChangeListener = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!kIsWeb)
        InternetConnectivityChecker.checkInternetConnectivityShowSnackbar(this,
            (onConnectionLoss) {
          Snackbars.showInternetErrorSnackbar(this);
        });
    });
    print("START initState3");
    initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition(context);
    print("START initState4");
    //OneSignal.initOneSignalPushMessages(); //TODO maybe activate Signal again, I want to ask users for reviews!
    tabController = TabController(vsync: this, length: TabPages.pages.length);
    tabController.addListener(_handleTabSelection);
    initListModel();

    print("START initState5");
    updateCurrentListItemCounter();

    print("START initState6");
    Future.delayed(Duration(seconds: 5), () {
      Snackbars.showSnackBarPlayStore(_scaffoldKey, context);
    });
    //initPositionStream();
    /*if (urlSearch == "statistics") {
      Future.delayed(Duration(seconds: 3), () {
        handleStatsButtonClick(context);
      });
    }*/
  }

  void initPositionStream() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  StreamSubscription<Position> positionStream;

  void loadAssetsUnfiltered(ctx) => loadAssets(ctx, null, null);

  //TODO test if I can simply call that in the build function (once) to avoid calling it from different locations
  void _updateDistanceToAllMerchantsIfNotDoneYet() {
    if (userPosition == null) return;

    _updateDistanceToAllMerchantsNow().then((updateSuccess) {
      if (updateSuccess) _loadAndParseAllPlaces(null, null);
    });
  }

  Future<bool> _updateDistanceToAllMerchantsNow() async {
    for (int i = 0; i < _lists.length; i++) {
      ListModel<Merchant> model = _lists[i];
      for (int x = 0; x < model.length; x++) {
        Merchant m = model[x];

        if (m.distance != null) return false;

        calculateDistanceUpdateMerchant(userPosition, m);
      }
    }
    return true;
  }

  void updateTitleToCurrentlySelectedTab() {
    setState(() {
      titleActionBar = getTitleOfSelectedTab();
    });
  }

  void updateAddButtonCategory() {
    setState(() {
      addButtonCategory = TabPages.pages[tabController.index].short;
    });
  }

  String getTitleOfSelectedTab() => TabPages.pages[tabController.index].long;

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
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 545,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.resize(800, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ],
            background: Container(color: hexToColor("#303030"))),
        localizationsDelegates: [
          FlutterI18nDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: supportedLocales(),
        theme: buildTheme(),
        home: new WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            key: _scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: buildFloatingActionButton(),
            body: new Builder(builder: (BuildContext ctx) {
              buildWithinScopeOfTranslator(ctx);
              appContent = NestedScrollView(
                headerSliverBuilder:
                    (BuildContext buildCtx, bool innerBoxIsScrolled) {
                  return <Widget>[
                    buildSliverAppBar(buildCtx),
                  ];
                },
                body: TabBarView(
                    controller: tabController,
                    children: buildAllTabContainer(ctx)),
              );
              return appContent;
            }),
          ),
        ));
  }

  void buildWithinScopeOfTranslator(BuildContext ctx) {
    _checkForUpdatedData(ctx);
    /*if (kIsWeb) {
      InternetConnectivityChecker.pauseAutoChecker();
    } else {*/
    //InternetConnectivityChecker.resumeAutoChecker();
    InternetConnectivityChecker.checkInternetConnectivityShowSnackbar(this,
        (onConnectionLoss) {
      Snackbars.showInternetErrorSnackbar(this);
    });
    //}
  }

  /* void scrollCallBack(DragUpdateDetails dragUpdate) {
    const SCROLL_SPEED_MULTIPLIER = 5;
    setState(() {
      _scrollControl.position.moveTo(dragUpdate.localPosition.dy *
          (dragUpdate.localPosition.dy / SCROLL_SPEED_MULTIPLIER));
    });
  }*/

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  List<Locale> supportedLocales() {
    return [
      const Locale('de'),
      const Locale('it'),
      const Locale('es'),
      const Locale('en'),
      const Locale('ja'),
      const Locale('id'),
      const Locale('fr'),
      const Locale('ru'),
      const Locale('pt'),
      const Locale('ar'),
      const Locale('hi'),
      const Locale('ch'),
      const Locale('sl')
    ];
  }

  Builder buildFloatingActionButton() {
    return Builder(
      builder: (builderCtx) => FloatingActionButton.extended(
          backgroundColor: getColorOfSelectedTab(),
          foregroundColor: Colors.white,
          onPressed: () {
            openAddNewPlaceWidget(builderCtx);
          },
          label: Text(Translator.translate(builderCtx, "floatbutton_add") +
              Translator.translate(
                  builderCtx, addButtonCategory.toUpperCase())),
          icon: Icon(Icons.add_location)),
    );
  }

  ThemeData buildTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey[900],
      primaryColor: Colors.grey[900],
      secondaryHeaderColor: Colors.white,
      fontFamily: 'OpenSans',
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black),
        headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            fontSize: 17.0,
            fontFamily: 'Hind',
            color: Colors.white,
            fontWeight: kIsWeb ? FontWeight.w100 : FontWeight.w400),
        bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Colors.white.withOpacity(0.8)),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext buildCtx) {
    return SliverAppBar(
        elevation: 2,
        shape:
            kIsWeb //TODO check if user is on mobile with web, then it shall not have rounded corners like in native app
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  )
                : null,
        forceElevated: true,
        leading: buildHomeButton(buildCtx),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: TabPages.pages.map<Tab>((TabPageCategory page) {
            return buildColoredTab(page);
          }).toList(),
        ),
        actions: <Widget>[
          buildIconButtonStats(buildCtx),
          buildIconButtonMap(buildCtx),
        ],
        title: buildTitleWidget(),
        floating: true,
        snap: true,
        pinned: false);
  }

  Padding buildTitleWidget() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: /*AnimatedSwitcher(
            //TODO fix animation, how to switch animated with a fade transition?
            duration: Duration(milliseconds: 500),x
            child: */
            Center(
                child: Text(
          titleActionBar,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: kIsWeb ? FontWeight.w100 : FontWeight.w300,
              fontStyle: FontStyle.normal,
              //decoration: TextDecoration.underline,
              color: Colors.white.withOpacity(0.5)),
        )));
  }

  Tab buildColoredTab(TabPageCategory page) {
    return _lists[page.tabIndex].length > 0
        ? Tab(
            text: page.short,
            icon: Icon(
              page.icon,
              color: MyColors.getTabColor(page.typeIndex),
              size: 22,
            ))
        : Tab(
            icon: Icon(
            page.icon,
            color: Colors.white.withOpacity(0.5),
            size: 22,
          ));
  }

  bool zoomMapAfterSelectLocation = false;

  Widget buildIconButtonMap(ctx) {
    return IconButton(
        tooltip: "Map",
        icon: Icon(Icons.map),
        color: Colors.lightBlueAccent,
        onPressed: () {
          handleMapButtonClick(ctx);
        });
  }

  Widget buildIconButtonStats(ctx) {
    return IconButton(
        tooltip: "Statistics",
        icon: Icon(Icons.pie_chart),
        color: Colors.lightBlueAccent,
        onPressed: () {
          handleStatsButtonClick(ctx);
        });
  }

  void handleMapButtonClick(ctx) async {
    if (kIsWeb)
      UrlLauncher.launchBitcoinMap();
    else {
      //InternetConnectivityChecker.pauseAutoChecker();
      Merchant result;
      try {
        result = await Navigator.push(
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
      } catch (e) {}
      _updateDistanceToAllMerchantsIfNotDoneYet();
      if (result != null) {
        showFilterResults(false, ctx, result.name);
        animateToTab(result);
        // showSnackBar("Showing selected merchant: " + result.name);
      } else {
        showUnfilteredLists(ctx);
      }
    }
  }

  void handleStatsButtonClick(ctx) async {
    if (kIsWeb)
      UrlLauncher.launchURI("http://bmap.app/android");
    else
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (buildCtx) => PieChartCoins()),
      );
  }

  List<Widget> buildAllTabContainer(ctx) {
    var builder =
        CardItemBuilder(ctx, _lists, this /*, isDataSaverOfflineMode*/);
    return [
      buildTabContainer(ctx, _listKeys[0], _lists[0],
          builder.buildItemRestaurant, TabPages.pages[0].long),
      buildTabContainer(ctx, _listKeys[1], _lists[1], builder.buildItemTogo,
          TabPages.pages[1].long),
      buildTabContainer(ctx, _listKeys[2], _lists[2], builder.buildItemBar,
          TabPages.pages[2].long),
      buildTabContainer(ctx, _listKeys[3], _lists[3], builder.buildItemMarket,
          TabPages.pages[3].long),
      buildTabContainer(ctx, _listKeys[4], _lists[4], builder.buildItemShop,
          TabPages.pages[4].long),
      buildTabContainer(ctx, _listKeys[5], _lists[5], builder.buildItemHotel,
          TabPages.pages[5].long),
      buildTabContainer(ctx, _listKeys[6], _lists[6], builder.buildItemWellness,
          TabPages.pages[6].long),
    ];
  }

  bool isFilterEmpty() => _searchTerm == null || _searchTerm.isEmpty;

  Future<bool> _saveLatestSavedPosition(String value) async {
    if (value == null) return false;

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
      tooltip: 'Reset',
      icon: Icon(
        Icons.close,
        color: Colors.red,
        //progress: getSearchDelegate().transitionAnimation,
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
    return /*searchIconBlinkAnimation != null
        ? AnimatedBuilder(
            animation: searchIconBlinkAnimation,
            builder: (BuildContext buildCtx, Widget child) {
              return buildIconButtonSearchContainer(ctx);
            })
        : */
        buildIconButtonSearchContainer(ctx);
  }

  IconButton buildIconButtonSearchContainer(BuildContext ctx) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: /*searchIconBlinkAnimation != null && hasNotHitSearch()
            ? searchIconBlinkAnimation.value
            : */
            Colors.lightBlueAccent,
        //progress: getSearchDelegate().transitionAnimation,
      ),
      onPressed: () async {
        InternetConnectivityChecker.pauseAutoChecker();
        try {
          getSearchDelegate(ctx).buildHistory();
          final String selected = await showSearch<String>(
            context: ctx,
            delegate: getSearchDelegate(ctx),
          );
          startProcessSearch(ctx, selected, false);
        } finally {
          InternetConnectivityChecker.resumeAutoChecker();
        }
      },
      tooltip: 'Search',
    );
  }

  void startProcessSearch(BuildContext ctx, String selected, hideInfoBox) {
    InternetConnectivityChecker.resumeAutoChecker();
    print("START startProcessSearch");
/* TODO BRING BACK THE INFO BOX
    if (/*hasNotHitSearch() && */ !hideInfoBox) {
      Dialogs.showInfoDialogWithCloseButton(ctx);
      //handleSearchButtonAnimationAndPersistHit();
    }*/
    //TODO ask users to rate the app as they are using this advanced feature multiple times

    if (selected != null) {
      print("START startProcessSearch2");
      filterListUpdateTitle(ctx, selected);
    } else {
      print("START startProcessSearch3");
      _updateDistanceToAllMerchantsIfNotDoneYet();
      showUnfilteredLists(ctx);
    }
  }
/*
  void handleSearchButtonAnimationAndPersistHit() async {
    if (searchIconBlinkAnimationController != null) {
      searchIconBlinkAnimationController.reset();
    }

    setState(() {
      hasHitSearch = true;
    });

    persistHasHitSearch();
  }*/

  //bool hasNotHitSearch() => hasHitSearch == null || !hasHitSearch;

  void filterListUpdateTitle(ctx, String selectedLocationOrTag) {
    print("START filterListUpdateTitle");
    var selectedArray =
        selectedLocationOrTag.split(LocationSuggestions.separator);
    final String title = selectedArray[0];
    print("START filterListUpdateTitle2");
    final String search = title.split(" - ")[0];
    //if selectedItem contains separator ; it has the filename attached
    final bool isLocationFilter = selectedArray.length > 1 ? true : false;
    //TODO Optimize performance by managing lists in memory, this optimization here is only valid in edge case
    print("START filterListUpdateTitle3");
    showFilterResults(isLocationFilter, ctx, search);
    print("START filterListUpdateTitle4");
  }

  void showFilterResults(bool isLocationFilter, ctx, String search) {
    print("START showFilterResults " + search);
    zoomMapAfterSelectLocation = false;

    //TODO get the tag index directly from the search without having to find it afterwards, just like location is also returned fully but displayed differently
    //beware that the tag returned by clicking tags is different than the one in search
    TagCoinector tag;
    try {
      tag = TagCoinector.findTag(search);
    } catch (e) {}
    print("START showFilterResults2");

    Snackbars.showFilterSearchSnackBar(
        _scaffoldKey, ctx, isLocationFilter, capitalize(search), tag);

    print("START showFilterResults3");
    loadAssets(ctx, tag, tag != null ? null : search);

    print("START showFilterResults4");
    setState(() {
      _searchTerm = search;
      titleActionBar = tag == null ? capitalize(search) : tag.toUI();
    });
    print("START showFilterResults5");
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
            child: ImprovedScrolling(
                scrollController: _scrollControlList[tabController.index],
                /*
                onScroll: (scrollOffset) => debugPrint(
                      'Scroll offset: $scrollOffset',
                    ),
                onMMBScrollStateChanged: (scrolling) => debugPrint(
                      'Is scrolling: $scrolling',
                    ),
                onMMBScrollCursorPositionUpdate:
                    (localCursorOffset, scrollActivity) => debugPrint(
                          'Cursor position: $localCursorOffset\n'
                          'Scroll activity: $scrollActivity',
                        ),*/
                enableMMBScrolling: true,
                enableKeyboardScrolling: true,
                enableCustomMouseWheelScrolling: true,
                keyboardScrollConfig: KeyboardScrollConfig(
                  arrowsScrollAmount: 250.0,
                  homeScrollDurationBuilder:
                      (currentScrollOffset, minScrollOffset) {
                    return const Duration(milliseconds: 100);
                  },
                  endScrollDurationBuilder:
                      (currentScrollOffset, maxScrollOffset) {
                    return const Duration(milliseconds: 2000);
                  },
                ),
                customMouseWheelScrollConfig:
                    const CustomMouseWheelScrollConfig(
                  scrollAmountMultiplier: 2.0,
                ),
                child: Scrollbar(
                  trackVisibility: false,
                  controller: _scrollControlList[tabController.index],
                  thumbVisibility: true,
                  thickness: kIsWeb ? 8.0 : 2.0,
                  radius: Radius.circular(kIsWeb ? 5.0 : 3.0),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: buildAnimatedList(listKey, list, builderMethod),
                )),
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          )
        : !isInitialized
            ? Center(
                child: LoadingBouncingLine.circle(
                  //inverted: true,
                  size: 32.0,
                  borderSize: 5.0,
                  borderColor: Colors.grey[800],
                  backgroundColor: Colors.white24,
                ),
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

  AnimatedList buildAnimatedList(listKey, list, builderMethod) {
    return AnimatedList(
      physics: const ClampingScrollPhysics(),
      controller: _scrollControlList[tabController.index],
      key: listKey,
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 60.0),
      initialItemCount: list.length,
      itemBuilder: builderMethod,
    );
  }

/*
  CustomScroller buildCustomScroller() {
    return CustomScroller(
      //Pass a reference to the ScrollCallBack function into the scrollbar
      scrollCallBack,

      scrollBarHeightPercentage: 1.0,
      //Add optional values
      scrollBarBackgroundColor: Colors.transparent,
      scrollBarWidth: 20.0,
      dragHandleColor: Colors.white,
      dragHandleBorderRadius: 5.0,
      dragHandleHeight: 60.0,
      dragHandleWidth: 6.0,
    );

  }
 */

  SearchDemoSearchDelegate getSearchDelegate(ctx) {
    if (searchDelegate == null ||
        searchDelegate.hintText == null ||
        searchDelegate.hintText.isEmpty) {
      final t = Translator.translate(ctx, "search_hint");
      searchDelegate = SearchDemoSearchDelegate(hintText: t);
      searchDelegate.hintText = t;
    }
    return searchDelegate;
  }

  SizedBox buildSeparator() {
    return const SizedBox(
      height: 20,
    );
  }

  void openAddNewPlaceWidget(BuildContext ctx) async {
    if (!isManagerModeRelease) {
      UrlLauncher.launchSubmitForm();
      return;
    } else {
      AddNewPlaceWidget.getLastReviewableCountAndIndex()
          .then((String countAndIndex) async {
        String index;
        String count;
        if (countAndIndex != null && countAndIndex.isNotEmpty) {
          count = countAndIndex.split(",")[0];
          index = countAndIndex.split(",")[1];
        }
        await Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (buildCtx) => AddNewPlaceWidget(
                  selectedType: tabController.index,
                  accentColor: getAccentColorOfSelectedTab(),
                  actionBarColor: getDarkColorOfSelectedTab(),
                  typeTitle: addButtonCategory,
                  lastReviewableIndex: index,
                  lastReviewableCount: count)),
        );

        _updateDistanceToAllMerchantsIfNotDoneYet();
        Snackbars.showSnackBarAfterAddPlace(_scaffoldKey, ctx); //
      });
    }
  }

  Future<Position> _getCoarseLocationViaIP() async {
    if ((userPosition =
            await tryGetCoarseLocation('https://coinector.app/geolocation')) ==
        null) if ((userPosition =
            await tryGetCoarseLocation('https://bmap.app/geolocation')) ==
        null) if ((userPosition = await tryGetCoarseLocation(
            'https://geolocation-db.com/json/index.html')) ==
        null) if ((userPosition =
            await tryGetCoarseLocation('/geolocation')) ==
        null) {}

    return userPosition;
  }

  Future<Position> tryGetCoarseLocation(String url) async {
    try {
      Map<String, dynamic> headers = new Map();
      //headers["Origin"] = "*";
      headers["Access-Control-Allow-Origin"] = "*";
      headers["Access-Control-Allow-Credentials"] = "true";

      var response = await new Dio().get(url,
          options: Options(
              contentType: "application/json",
              followRedirects: true,
              headers: headers));
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
        return new Position(
            longitude: longitude,
            latitude: latitude,
            speedAccuracy: 0.0,
            altitude: 0.0,
            accuracy: 0.0,
            heading: 0.0,
            speed: 0.0,
            timestamp: DateTime.now());
      else
        print(
            "RECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER");
    } catch (e) {
      print("URL\n" + url);
      print("COARSE LOCATION PROVIDER\nCOARSE LOCATION PROVIDER");
      print(e.toString());
    }
    return null;
  }

  var currentListItemCounter = 0;

  int currentListItemCount() {
    return currentListItemCounter == 0
        ? currentListItemCounter = _lists[tabController.index].length
        : currentListItemCounter;
  }

  bool hasScrollableContent() {
    return currentListItemCounter > 1;
  }

  @override
  doFilter(String search) {
    return startProcessSearch(context, search, true);
  }

  int checkBrand(TagBrand e, String locationTitleFilter) {
    // print("checkBrand" + e.index.toString());
    // print("filter" + locationTitleFilter);
    var filter = locationTitleFilter.toLowerCase().trim();
    if (e.long.toLowerCase().trim() == filter) {
      // print("checkBrandSUCCESS");
      return e.index;
    }
    // print("checkBrandFAIL");
    return -1;
  }

  void checkCoin(TagCoin currentCoin, String locationTitleFilter,
      StringBuffer resultCoin) {
    // print("checkCoin" + e.index.toString());
    var filter = locationTitleFilter.toLowerCase().trim();
    if (currentCoin.short.toLowerCase().trim() == filter ||
        currentCoin.long.toLowerCase().trim() == filter) {
      // print("checkCoinSUCCESS");
      resultCoin.write(currentCoin.index.toString());
    }
  }

  int lastUniqueMerchMapSize = 0;

  void printUniqueMerchantMap() {
    if (lastUniqueMerchMapSize == _uniqueMerchantMap.length) return;

    lastUniqueMerchMapSize = _uniqueMerchantMap.length;

    if (kReleaseMode) return;

    StringBuffer buff = StringBuffer();
    int index = 0;
    buff.writeln("[");
    String lastFile = "";
    _uniqueMerchantMap.forEach((key, value) {
      var currentFile = key.split(";")[0];
      if (lastFile != currentFile) {
        lastFile = currentFile;
        buff.writeln("FILECHANGE " + currentFile);
      }
      index++;
      buff.writeln(value.getBmapDataJson() + ",");
    });
    buff.writeln("]");
    Clipboard.setData(ClipboardData(text: buff.toString()));
  }
}
