import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'package:geolocator/geolocator.dart';
import 'package:in_app_review/in_app_review.dart';
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

var lastWarningInMillis = 0;

void checkInternetConnectivityShowSnackbar(that, _onError) async {
//DONT CHECK MORE THAN EVERY 9 SECONDS
  var milliSecondsNow = DateTime.now().millisecondsSinceEpoch;
  if (lastWarningInMillis != 0 &&
      lastWarningInMillis + 8500 > milliSecondsNow) {
    return;
  }
  lastWarningInMillis = milliSecondsNow;

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
// I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
// I am connected to a wifi network.
    checkConnectionWithRequest(that, (abc) {
      _onError(that);
    });
  } else {
    _onError(that);
  }
}

Future checkConnectionWithRequest(that, _onError) async {
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

void _showInternetErrorSnackbar(that) {
//Double check internet connection before showing error
  try {
    checkConnectionWithRequest(that, (abc) {
      //Future.delayed(Duration(seconds: 1), );
      checkConnectionWithRequest(that, (abc) {
        checkConnectionWithRequest(that, (abc) {
          that.showSnackBar(that.context, "",
              additionalText: "Internet Error!");
        });
      });
    });
  } catch (e) {
    try {
      checkConnectionWithRequest(that, (abc) {
        //Future.delayed(Duration(seconds: 1), );
        that.showSnackBar(that.context, "", additionalText: "Internet Error!");
      });
    } catch (e) {
      that.showSnackBar(that.context, "", additionalText: "Internet Error!");
    }
  }
/*new AwesomeDialog(
            context: context,
            title: "Internet",
            desc: "Activate internet!!!",
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            btnOkOnPress: () {
              //dismiss
            }).show();*/
//Dialogs.showInfoDialogWithCloseButton(context);
//Dont show too many of these snackbars
}

class _AnimatedListSampleState extends State<AnimatedListSample>
    with TickerProviderStateMixin {
  final SearchDemoSearchDelegate searchDelegate = SearchDemoSearchDelegate();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
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
      updateDistanceToAllMerchantsIfNotDoneYet();
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
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (timerIsCancelled) timer.cancel();
      if (timer.tick == 0) return; //skip first iteration
      try {
        FileCache.initLastVersion(() async {
          //has new version
          showSnackBar(ctx, "", additionalText: "DATA UPDATE, RESTART APP!");
          //showSnackBar(context, "", additionalText: "APP UPDATED! DO RESTART!");
          _updateAllCachedContent();
        });
      } catch (e) {
        FileCache.forceUpdateNextTime();
      }
    });
  }

  void _updateAllCachedContent() {
    FileCache.loadFromWebAndPersistCache('am');
    FileCache.loadFromWebAndPersistCache('as');
    FileCache.loadFromWebAndPersistCache('au');
    FileCache.loadFromWebAndPersistCache('as-jap');
    FileCache.loadFromWebAndPersistCache('am-ven-car');
    FileCache.loadFromWebAndPersistCache('am-ven');
    FileCache.loadFromWebAndPersistCache('e');
    FileCache.loadFromWebAndPersistCache('e-spa');
    FileCache.loadFromWebAndPersistCache('addr');
    FileCache.loadFromWebAndPersistCache('placesId');
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

  _handleTabSelection() {
    if (!isFilteredList()) updateTitleToCurrentlySelectedTab();
    updateAddButtonCategory();
    initCurrentPositionIfNotInitialized();
    updateDistanceToAllMerchantsIfNotDoneYet();
  }

  void requestCurrentPosition() async {
    if (kIsWeb) {
      return null;
    }
    try {
      LocationPermission p = await Geolocator.requestPermission();
      if (p == LocationPermission.whileInUse ||
          p == LocationPermission.always) {
        updateCurrentPosition();
        updateDistanceToAllMerchantsIfNotDoneYet();
      }
    } catch (e) {
      FlutterError.presentError(e);
    }
  }

  void initCurrentPositionIfNotInitialized() async {
    if (userPosition != null) return;

    //TODO check if that call is correct, might make sense to request permission always if necesssary?
    updateCurrentPosition();
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
  Future<bool> updateCurrentPosition() async {
    //ALWAYS GET LOCATION VIA IP FIRST TO HAVE SOMETHING AT STARTUP
    //if (kIsWeb) {
    //_getCurrentLocationWeb();
    //return true;
    // } else {
    if (!kIsWeb && await Permission.locationWhenInUse.isGranted) {
      Position pos = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setLatestPosition(pos);
    } else
      setLatestPosition(await _getCoarseLocationViaIP());

    return true;
    //}
    //return false;
  }

  void setLatestPosition(Position pos) {
    saveLatestSavedPosition(
        pos.latitude.toString() + ";" + pos.longitude.toString());

    setState(() {
      userPosition = pos;
    });
  }

  /* Future<void> initOneSignalPushMessages() async {
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
  }*/

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

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      checkInternetConnectivityShowSnackbar(this, (abc) {
        _showInternetErrorSnackbar(this);
      });
    });
    initLastSavedPosThenTriggerLoadAssetsAndUpdatePosition(context);
    //initOneSignalPushMessages();
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
  }

  void loadAssetsUnfiltered(ctx) => loadAssets(ctx, -999, null, null);

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
    checkInternetConnectivityShowSnackbar(this, (abc) {
      _showInternetErrorSnackbar(this);
    });
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

              return NestedScrollView(
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
        updateDistanceToAllMerchantsIfNotDoneYet();
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

  void showSnackBar(ctx, String msgId, {String additionalText = ""}) {
    if (_scaffoldKey.currentState == null) return;

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 3000),
      content: Text(
        Translator.translate(ctx, msgId) + additionalText,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900]),
      ),
      backgroundColor: Colors.yellow[700],
    ));
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

  Future<void> saveLatestSavedPosition(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sharedPrefKeyLastLocation, value);
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
        final String selected = await showSearch<String>(
          context: ctx,
          delegate: searchDelegate,
        );
        if (hasNotHitSearch()) {
          Dialogs.showInfoDialogWithCloseButton(ctx);
          handleSearchButtonAnimationAndPersistHit();
        }
        //TODO ask users to rate the app

        if (selected != null) {
          filterListUpdateTitle(ctx, selected);
        } else {
          updateDistanceToAllMerchantsIfNotDoneYet();
          showUnfilteredLists(ctx);
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
    showMatchingSnackBar(ctx, fileName, capitalize(search), index);

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

  void showMatchingSnackBar(ctx, String fileName, String search, int index) {
    if (fileName != null)
      showSnackBar(ctx, "snackbar_filtered_by_location",
          additionalText: search);
    else if (index != -1 && fileName == null)
      showSnackBar(ctx, "snackbar_filtered_by_tag", additionalText: search);
    else
      showSnackBar(ctx, "snackbar_merchant", additionalText: search);
  }

  void showUnfilteredLists(ctx) {
    zoomMapAfterSelectLocation = false;
    mapPosition = null;
    updateTitleToCurrentlySelectedTab();
    if (isFilteredList()) {
      _searchTerm = '';
      loadAssetsUnfiltered(ctx);
    }
    showSnackBar(ctx, "snackbar_showing_unfiltered_list");
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
                          child: /*IconButton(icon: */ Icon(Icons.arrow_upward),
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
    var response = await new Dio().get('https://geolocation-db.com/json/');
    var responseJSON = json.decode(response.data);
    return new Position(
        longitude: responseJSON['longitude'],
        latitude: responseJSON['latitude']);
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
  //runApp(Phoenix(child: AnimatedListSample()));
  runApp(AnimatedListSample());
}
