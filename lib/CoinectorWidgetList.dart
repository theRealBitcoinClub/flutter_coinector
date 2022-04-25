import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Coinector/InternetConnectivityChecker.dart';
import 'package:Coinector/ItemInfoStackLayer.dart';
import 'package:Coinector/Snackbars.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/translator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
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
import 'AssetLoader.dart';
import 'CardItemBuilder.dart';
import 'Dialogs.dart';
import 'FileCache.dart';
import 'ListModel.dart';
import 'LocationSuggestions.dart';
import 'MapSample.dart';
import 'Merchant.dart';
import 'MyColors.dart';
import 'SearchDemoSearchDelegate.dart';
import 'TabPageCategory.dart';
import 'TagBrands.dart';
import 'TagCoinector.dart';
import 'UrlLauncher.dart';

const bool isManagerModeRelease = true;

class CoinectorWidget extends StatefulWidget {
  final String search;

  CoinectorWidget(String search) : this.search = search;

  @override
  _CoinectorWidgetState createState() => _CoinectorWidgetState(search);
}

class _CoinectorWidgetState extends State<CoinectorWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver, TagFilterCallback {
  SearchDemoSearchDelegate searchDelegate;

  _CoinectorWidgetState(String search) {
    urlSearch = search;
  }

  String urlSearch;
  StreamSubscription subscriptionConnectivityChangeListener;

  static var isInitialized = false;
  ScrollController _scrollControl;

  NestedScrollView appContent;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var scaffoldKey;
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController tabController;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  var assetLoader = AssetLoader();
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

  void loadAssets(ctx, TagCoinector tagFilter, String locationOrTitleFilter,
      String fileName) async {
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

    if (!kReleaseMode || fileName == null) {
      _loadAndParseAllPlaces(tagFilter, locationOrTitleFilter);
    } else {
      _loadAndParseAsset(tagFilter, locationOrTitleFilter, fileName);
    }
  }

  var isCheckingForUpdates = false;
  var checkDataUpdateTimerIsCancelled = false;

  void _checkForUpdatedData(ctx) async {
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
    FileCache.initLastVersion(() {
      //has new version
      if (checkDataUpdateTimerIsCancelled) return false;
      _updateAllCachedContent(ctx);
      return true;
    });
    return false;
  }

  void _updateAllCachedContent(ctx) async {
    await FileCache.loadFromWebAndPersistCache('am');
    await FileCache.loadFromWebAndPersistCache('as');
    await FileCache.loadFromWebAndPersistCache('au');
    await FileCache.loadFromWebAndPersistCache('e');

    await FileCache.loadFromWebAndPersistCache('addr');
    await FileCache.loadFromWebAndPersistCache('placesId');

    Snackbars.showSnackBarRestartApp(_scaffoldKey, ctx);
    /*Future.delayed(Duration(seconds: 30), () {
        Phoenix.rebirth(ctx);
      }); MAYBE THE USER IS ALREADY OK WITH THE DATA AND THERE IS NO NEED TO RESTART*/
  }

  void _loadAndParseAllPlaces(TagCoinector tag, String locationFilter) {
    /*if (!kReleaseMode)
      _loadAndParseAsset(tag, locationFilter, "places");
    else {*/
    _loadAndParseAsset(tag, locationFilter, 'am');
    _loadAndParseAsset(tag, locationFilter, 'as');
    _loadAndParseAsset(tag, locationFilter, 'au');
    _loadAndParseAsset(tag, locationFilter, 'e');
  }

  Future _loadAndParseAsset(
      TagCoinector tag, String locationOrTitleFilter, String fileName) async {
    var decoded
        /*;
    if (!kReleaseMode)
      decoded = await FileCache.loadAndDecodeAsset("places");
    else {
      decoded */
        = await FileCache.loadAndDecodeAsset(fileName);

    parseAssetUpdateListModel(tag, locationOrTitleFilter, decoded, fileName);
  }

  Future<void> parseAssetUpdateListModel(
      TagCoinector tag,
      String locationTitleFilter,
      List places,
      String serverIdOrFileName) async {
    initTempListModel();
    for (int i = 0; i < places.length; i++) {
      Merchant m2 = Merchant.fromJson(places.elementAt(i));
      m2.serverIdOrFileName = serverIdOrFileName;
      //at the moment there is no PAY feature: m2.isPayEnabled = await AssetLoader.loadReceivingAddress(m2.id) != null;
      bool isLocation = false;
      int brand = -1;
      bool isTitle = true;
      String coins = "";
      if (locationTitleFilter != null && locationTitleFilter != "null") {
        locationTitleFilter = locationTitleFilter.toLowerCase();
        isLocation =
            LocationSuggestions.locations.contains(locationTitleFilter);
        brand = m2.brand != null ? containsBrand(m2, locationTitleFilter) : -1;
        coins = m2.acceptedCoins != null
            ? containsCoin(m2, locationTitleFilter)
            : "";
        //TODO CURRENTLY TITLE IS CHECKED WHEN ALL OTHER CHECKS ARE RESULTLESS
        // isTitle = SuggestionsTitles.titleTags.contains(locationTitleFilter);
      }
      _insertIntoTempList(
          m2, tag, locationTitleFilter, isLocation, isTitle, brand, coins);
    }

    //TODO FIX MAP POSITIONING
    if (locationTitleFilter == null && tag == null) mapPosition = null;

    if (unfilteredLists.length == 0) initUnfilteredLists();

    updateListModel(tempLists);
  }

  containsBrand(Merchant m2, String locationTitleFilter) {
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

  String containsCoin(Merchant m2, String locationTitleFilter) {
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
      String coins) {
    if (coins.isNotEmpty && !m2.acceptedCoins.contains(coins)) {
      print("coinfilter");
      return;
    }
    if (brand != -1 && m2.brand != brand) {
      print("brandfilter");
      return;
    }
    if (tag != null && filterWordIndexDoesNotMatch(tag, m2)) {
      print("tagfilter");
      return;
    }
    if (locationTitleOrTag != null) {
      if (isLocation && !_containsLocationPrefilled(m2, locationTitleOrTag)) {
        print("locationPrefilledFilter");
        return;
      }
      if (tag == null &&
          !isLocation &&
          coins.isEmpty &&
          brand == -1 &&
          isTitle &&
          !_containsTitle(m2, locationTitleOrTag) &&
          !_containsLocationFreeSearch(m2, locationTitleOrTag)) {
        print("titlefilter");
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
    updateCurrentListItemCounter();
    if (!isFilteredList()) updateTitleToCurrentlySelectedTab();
    updateAddButtonCategory();
    await initCurrentPositionIfNotInitialized();
    _updateDistanceToAllMerchantsIfNotDoneYet();
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
        await updateCurrentPosition();
        _updateDistanceToAllMerchantsIfNotDoneYet();
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
    var position = await getLatestSavedPosition();
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

    if (urlSearch != null &&
        urlSearch.isNotEmpty &&
        urlSearch.length > 2 &&
        !urlSearch.contains("1") &&
        !urlSearch.contains("2") &&
        !urlSearch.contains("3") &&
        !urlSearch.contains("4") &&
        !urlSearch.contains("5") &&
        !urlSearch.contains("6") &&
        !urlSearch.contains("7") &&
        !urlSearch.contains("8") &&
        !urlSearch.contains("9") &&
        !urlSearch.contains("0"))
      startProcessSearch(ctx, urlSearch, true);
    else
      loadAssetsUnfiltered(ctx);

    requestCurrentPosition();
  }

  double parseDouble(String position, int piece) =>
      double.parse(position.split(";")[piece]);

  @override
  void initState() {
    super.initState();
    _scrollControl = ScrollController();
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
    initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition(context);
    //OneSignal.initOneSignalPushMessages(); //TODO maybe activate Signal again, I want to ask users for reviews!
    tabController = TabController(vsync: this, length: TabPages.pages.length);
    tabController.addListener(_handleTabSelection);
    initListModel();
    /*if (hasNotHitSearch()) {
      initHasHitSearch().then((hasHit) {
        if (!hasHit) initBlinkAnimation();
      });
    }*/

    updateCurrentListItemCounter();

    Future.delayed(Duration(seconds: 5), () {
      Snackbars.showSnackBarPlayStore(_scaffoldKey, context);
    });
    //initPositionStream();
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

  void loadAssetsUnfiltered(ctx) => loadAssets(ctx, null, null, null);

  //TODO test if I can simply call that in the build function (once) to avoid calling it from different locations
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
      addButtonCategory = TabPages.pages[tabController.index].text;
    });
  }

  String getTitleOfSelectedTab() => TabPages.pages[tabController.index].title;

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
    if (kReleaseMode) _checkForUpdatedData(ctx);
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

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    const SCROLL_SPEED_MULTIPLIER = 5;
    setState(() {
      _scrollControl.position.moveTo(dragUpdate.localPosition.dy *
          (dragUpdate.localPosition.dy / SCROLL_SPEED_MULTIPLIER));
    });
  }

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
      const Locale('fr')
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
            text: page.text,
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

  void handleMapButtonClick(ctx) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        //InternetConnectivityChecker.pauseAutoChecker();
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
          showFilterResults(null, result.name, ctx, result.name);
          animateToTab(result);
          // showSnackBar("Showing selected merchant: " + result.name);
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
    var builder =
        CardItemBuilder(ctx, _lists, this /*, isDataSaverOfflineMode*/);
    return [
      buildTabContainer(ctx, _listKeys[0], _lists[0],
          builder.buildItemRestaurant, TabPages.pages[0].title),
      buildTabContainer(ctx, _listKeys[1], _lists[1], builder.buildItemTogo,
          TabPages.pages[1].title),
      buildTabContainer(ctx, _listKeys[2], _lists[2], builder.buildItemBar,
          TabPages.pages[2].title),
      buildTabContainer(ctx, _listKeys[3], _lists[3], builder.buildItemMarket,
          TabPages.pages[3].title),
      buildTabContainer(ctx, _listKeys[4], _lists[4], builder.buildItemShop,
          TabPages.pages[4].title),
      buildTabContainer(ctx, _listKeys[5], _lists[5], builder.buildItemHotel,
          TabPages.pages[5].title),
      buildTabContainer(ctx, _listKeys[6], _lists[6], builder.buildItemWellness,
          TabPages.pages[6].title),
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
/* TODO BRING BACK THE INFO BOX
    if (/*hasNotHitSearch() && */ !hideInfoBox) {
      Dialogs.showInfoDialogWithCloseButton(ctx);
      //handleSearchButtonAnimationAndPersistHit();
    }*/
    //TODO ask users to rate the app as they are using this advanced feature multiple times

    if (selected != null) {
      filterListUpdateTitle(ctx, selected);
    } else {
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
    var selectedArray =
        selectedLocationOrTag.split(LocationSuggestions.separator);
    final String title = selectedArray[0];
    final String search = title.split(" - ")[0];
    //if selectedItem contains separator ; it has the filename attached
    final String fileName = selectedArray.length > 1 ? selectedArray[1] : null;
    showFilterResults(fileName, selectedLocationOrTag, ctx, search);
  }

  void showFilterResults(String fileName, String selectedLocationOrTag, ctx,
      String locationTitleOrTag) {
    if (fileName != null) {
      zoomMapAfterSelectLocation = true;
    } else {
      zoomMapAfterSelectLocation = false;
    }

    //TODO get the tag index directly from the search without having to find it afterwards, just like location is also returned fully but displayed differently
    //beware that the tag returned by clicking tags is different than the one in search
    TagCoinector tag = selectedLocationOrTag == locationTitleOrTag
        ? TagCoinector.findTag(selectedLocationOrTag)
        : null;

    Snackbars.showFilterSearchSnackBar(
        _scaffoldKey, ctx, fileName, capitalize(locationTitleOrTag), tag);

    loadAssets(ctx, tag, tag != null ? null : selectedLocationOrTag, fileName);

    setState(() {
      _searchTerm = locationTitleOrTag;
      titleActionBar = capitalize(locationTitleOrTag);
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
            child: Stack(children: [
              AnimatedList(
                controller: _scrollControl,
                key: listKey,
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 60.0),
                initialItemCount: list.length,
                itemBuilder: builderMethod,
              ),
              /*(!kIsWeb || !hasScrollableContent())
                  ? SizedBox()
                  : _verticalScroller*/
            ]),
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
    if (!isManagerModeRelease || kIsWeb) {
      UrlLauncher.launchSubmitForm();
      return;
    } else
      await Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (buildCtx) => AddNewPlaceWidget(
                  selectedType: tabController.index,
                  accentColor: getAccentColorOfSelectedTab(),
                  actionBarColor: getDarkColorOfSelectedTab(),
                  typeTitle: addButtonCategory,
                )),
      );
    _updateDistanceToAllMerchantsIfNotDoneYet();
    Snackbars.showSnackBarAfterAddPlace(_scaffoldKey, ctx);
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
        userPosition = new Position(
            longitude: longitude,
            latitude: latitude,
            speedAccuracy: 0.0,
            altitude: 0.0,
            accuracy: 0.0,
            heading: 0.0,
            speed: 0.0,
            timestamp: DateTime.now());
      else
        debugPrint(
            "RECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER\nRECEIVING INVALID DATA FROM COARSE LOCATION PROVIDER");
    } catch (e) {
      debugPrint(e.toString());
    }
    return userPosition;
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

  int checkBrand(TagBrand e, locationTitleFilter) {
    // print("checkBrand" + e.index.toString());
    // print("filter" + locationTitleFilter);
    if (e.long.toLowerCase().contains(locationTitleFilter)) {
      // print("checkBrandSUCCESS");
      return e.index;
    }
    // print("checkBrandFAIL");
    return -1;
  }

  void checkCoin(TagCoin e, String locationTitleFilter, StringBuffer coins) {
    // print("checkCoin" + e.index.toString());
    if (e.long.toLowerCase().contains(locationTitleFilter)) {
      // print("checkCoinSUCCESS");
      if (coins.isEmpty) {
        coins.write(e.index);
      } else {
        coins.write(",");
        coins.write(e.index);
      }
    }
  }
}
