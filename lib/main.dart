import 'package:endlisch/AssetLoader.dart';
import 'package:endlisch/CardItemBuilder.dart';
import 'package:endlisch/MyColors.dart';
import 'package:endlisch/SnackBarPage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'ListModel.dart';
import 'Merchant.dart';
import 'SearchDemoSearchDelegate.dart';
import 'Tags.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _Page {
  const _Page(
      {this.text, this.icon, this.title, this.tabIndex, this.typeIndex});
  final String text;
  final String title;
  final IconData icon;
  final int tabIndex;
  final int typeIndex;
}

const List<_Page> _pagesTags = <_Page>[
  _Page(
      text: 'EAT',
      icon: Icons.restaurant,
      title: 'RESTAURANT',
      tabIndex: 0,
      typeIndex: 0),
  _Page(
      text: 'TOGO',
      icon: Icons.restaurant_menu,
      title: 'TAKE-AWAY & DELIVERY',
      tabIndex: 1,
      typeIndex: 1),
  _Page(
      text: 'BAR',
      icon: Icons.local_bar,
      title: 'BAR, CLUB & CAFE',
      tabIndex: 2,
      typeIndex: 2),
  _Page(
      text: 'MARKET',
      icon: Icons.shopping_cart,
      title: 'SUPERMARKET',
      tabIndex: 3,
      typeIndex: 3),
  _Page(
      text: 'SHOP',
      icon: Icons.shopping_basket,
      title: 'SOUVENIR & SERVICE',
      tabIndex: 4,
      typeIndex: 4),
  _Page(
      text: 'HOTEL',
      icon: Icons.hotel,
      title: 'HOTEL, B&B, FLAT',
      tabIndex: 5,
      typeIndex: 5),
  _Page(
      text: 'ATM',
      icon: Icons.atm,
      title: 'TELLER & TRADER',
      tabIndex: 6,
      typeIndex: 99),
  _Page(
      text: 'SPA',
      icon: Icons.spa,
      title: 'WELLNESS & BEAUTY',
      tabIndex: 7,
      typeIndex: 999),
];

List<_Page> _filteredPages = _pagesTags;

class _AnimatedListSampleState extends State<AnimatedListSample>
    with TickerProviderStateMixin {
  final SearchDemoSearchDelegate searchDelegate = SearchDemoSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController tabController;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  final dio = new Dio(); // for http requests
  List<Merchant> names = new List<Merchant>(); // names we get from API
  List<ListModel<Merchant>> tempLists = [];
  List<ListModel<Merchant>> unfilteredLists = [];
  Response response;
  String _title = "Coinector";
  bool isUnfilteredList = false;
  bool hasHitSearch;
  var sharedPrefKeyHasHitSearch = "sharedPrefKeyHasHitSearch";
  String _searchTerm;

  Animation<Color> searchIconBlinkAnimation;
  AnimationController searchIconBlinkAnimationController;

  initBlinkAnimation() {
    searchIconBlinkAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final CurvedAnimation curve = CurvedAnimation(
        parent: searchIconBlinkAnimationController, curve: Curves.decelerate);
    searchIconBlinkAnimation =
        ColorTween(begin: Colors.white, end: Colors.red[800]).animate(curve);
    searchIconBlinkAnimation.addStatusListener((status) {
      /*if (hasHitSearch) {
        searchIconBlinkAnimationController.reset();
        return;
      }*/
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
    if (filterWordIndex == -1) {
      if (isUnfilteredList) return;
      if (unfilteredLists.length != 0) updateListModel(unfilteredLists);
      this.isUnfilteredList = true;
    } else {
      this.isUnfilteredList = false;
    }
/*
    if (response == null)
      response =
          await dio.get('https://realbitcoinclub.firebaseapp.com/places8.json');
  */
    List<dynamic> placesList = [];

    //TODO add addresses to demonstrate payments/donations to coinspice & dashboost

    if (fileName == null) {
      //TODO internationalize the app, translate the strings
      //TODO ask for phone number, map phone numbers to continents
      //TODO ask for location, if given load the continent last
      placesList = await parseAssetUpdateListModel(
          filterWordIndex, locationFilter, 'assets/am.json','am', true);
      placesList = await parseAssetUpdateListModel(
          filterWordIndex, locationFilter, 'assets/e.json','e', false);
      placesList = await parseAssetUpdateListModel(
          filterWordIndex, locationFilter, 'assets/as.json','as', false);
      placesList = await parseAssetUpdateListModel(
          filterWordIndex, locationFilter, 'assets/au.json','au', false);
    } else {
      placesList = await parseAssetUpdateListModel(filterWordIndex,
          locationFilter, 'assets/' + fileName + '.json',fileName, true);
    }

    //_filteredPages = _pagesTags;
//TODO add more title to match title search
    //RESPONSE.DATA.LENGTH
  }

  Future<List<dynamic>> parseAssetUpdateListModel(int filterWordIndex,
      String locationFilter, String assetUri, String serverId, bool clearListContent) async {
    var placesList = await AssetLoader.loadAndEncodeAsset(assetUri);
    initTempListModel();
    for (int i = 0; i < placesList.length; i++) {
      Merchant m2 = Merchant.fromJson(placesList.elementAt(i));
      m2.serverId = serverId;

      _insertIntoTempList(m2, filterWordIndex, locationFilter);
    }

    if (unfilteredLists.length == 0) initUnfilteredLists();

    if (clearListContent)
      updateListModel(tempLists);
    else
      addToListModel(tempLists);

    return placesList;
  }

  void updateList(List destination, List tmpList, bool clearOldContent) {
    if (clearOldContent) destination.clear();
    for (int i = 0; i < tmpList.length; i++) {
      ListModel<Merchant> currentTmpList = tmpList[i];
      if (clearOldContent) {
        destination.add(currentTmpList);
      } else {
        ListModel<Merchant> currentList = destination[i];
        for (int x = 0; x < currentTmpList.length; x++) {
          currentList.insert(0, currentTmpList[x]);
        }
      }
    }
  }

  void addToListModel(List<ListModel<Merchant>> tmpList) {
    setState(() {
      updateList(_lists, tmpList, false);
    });
  }

  void updateListModel(List<ListModel<Merchant>> tmpList) {
    setState(() {
      updateList(_lists, tmpList, true);
    });
  }

  void initUnfilteredLists() {
    updateList(unfilteredLists, tempLists, true);
  }

  bool _containsFilteredTag(Merchant m, int filterWordIndex) {
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
    if (filterWordIndex != null &&
        filterWordIndex != -1 &&
        !_containsFilteredTag(m2, filterWordIndex) &&
        !_containsLocation(m2, location) &&
        !_containsTitle(m2, location)) return;

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
      case 99:
        tempLists[6].insert(0, m2);
        break;
      case 999:
        tempLists[7].insert(0, m2);
        break;
    }
  }

  void initListModelSeveralTimes(List lists) {
    lists.clear();
    _listKeys.clear();
    for (int i = 0; i < _filteredPages.length + 1; i++) {
      _listKeys.add(GlobalKey<AnimatedListState>());
      lists.add(ListModel<Merchant>(
        tabIndex: i,
        listKey: _listKeys[i],
        removedItemBuilder: CardItemBuilder.buildRemovedItem,
      ));
    }
  }

  void initTempListModel() {
    initListModelSeveralTimes(tempLists);
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
    setState(() {
      if (!isFilteredList()) updateTitle();
    });
  }

  @override
  void initState() {
    super.initState();
    searchDelegate.buildHistory();
    tabController = TabController(vsync: this, length: _filteredPages.length);
    //updateTitle();
    tabController.addListener(_handleTabSelection);
    initListModel();
    loadAssets(-1, null, null);
    //initBlinkAnimation();
    if (hasHitSearch == null || !hasHitSearch) {
      initHasHitSearch().then((hasHit) {
        if (!hasHit) initBlinkAnimation();
      });
    }
  }

  void showInfoDialogWithCloseButton(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(
                "- Scroll & Tap a suggestion to filter the list.\n\n- Use the keyboard to search: \ne.g. -> 'Burger,Dessert,Beer'"),
            title: Text("Search"),
            //TODO Add merchant names to searchindex
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("CLOSE"),
              )
            ],
          );
        });
  }

  void updateTitle() {
    setState(() {
      _title = _pagesTags[tabController.index].title;
    });
  }

  void initListModel() {
    initListModelSeveralTimes(_lists);
  }

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
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          body1: TextStyle(
              fontSize: 17.0,
              fontFamily: 'Hind',
              color: Colors.white.withOpacity(0.85)),
          body2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
        ),
      ),
      home: Scaffold(
          /*drawer: Drawer(
            child: Column(
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  accountName: Text('Peter Widget'),
                  accountEmail: Text('peter.widget@example.com'),
                  /*currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                      'people/square/peter.png',
                      package: 'flutter_gallery_assets',
                    ),
                  ),*/
                  margin: EdgeInsets.zero,
                ),
                /*MediaQuery.removePadding(
                  context: context,
                  // DrawerHeader consumes top MediaQuery padding.
                  removeTop: true,
                  child: const ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Placeholder'),
                  ),
                ),*/
              ],
            ),
          ),*/
          key: _scaffoldKey,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    elevation: 1.5,
                    forceElevated: true,
                    leading: buildHomeButton(),
                    bottom: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      indicator: getIndicator(),
                      tabs: _filteredPages.map<Tab>((_Page page) {
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
                      buildIconButtonSearch(context),
                      //TODO build profile and settings page
                      /*IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: _remove,
                      tooltip: 'settings',
                    ),*/
                    ],
                    title: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: AnimatedSwitcher(
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
            body: TabBarView(
                controller: tabController, children: buildAllTabContainer()),
          )),
    );
  }

  List<Widget> buildAllTabContainer() {
    var builder = CardItemBuilder(_lists);
    return [
      buildTabContainer(_listKeys[0], _lists[0], builder.buildItemRestaurant,
          _pagesTags[0].title),
      buildTabContainer(
          _listKeys[1], _lists[1], builder.buildItemTogo, _pagesTags[1].title),
      buildTabContainer(
          _listKeys[2], _lists[2], builder.buildItemBar, _pagesTags[2].title),
      buildTabContainer(_listKeys[3], _lists[3], builder.buildItemMarket,
          _pagesTags[3].title),
      buildTabContainer(
          _listKeys[4], _lists[4], builder.buildItemShop, _pagesTags[4].title),
      buildTabContainer(
          _listKeys[5], _lists[5], builder.buildItemHotel, _pagesTags[5].title),
      buildTabContainer(
          _listKeys[6], _lists[6], builder.buildItemATM, _pagesTags[6].title),
      buildTabContainer(_listKeys[7], _lists[7], builder.buildItemWellness,
          _pagesTags[7].title)
    ];
  }

  bool isFilterEmpty() => _searchTerm == null || _searchTerm.isEmpty;

  Future<bool> initHasHitSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      var tmp = prefs.getBool(sharedPrefKeyHasHitSearch);
      hasHitSearch = tmp != null ? tmp : false;
    });

    return hasHitSearch;
  }

  Future<bool> persistHasHitSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(sharedPrefKeyHasHitSearch, true);
  }

  Widget buildIconButtonSearch(BuildContext context) {
    return searchIconBlinkAnimation != null
        ? AnimatedBuilder(
            animation: searchIconBlinkAnimation,
            builder: (BuildContext context, Widget child) {
              return buildIconButtonSearchContainer(context);
            })
        : buildIconButtonSearchContainer(context);
  }

  IconButton buildIconButtonSearchContainer(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          color: hasHitSearch != null && !hasHitSearch
              ? searchIconBlinkAnimation.value
              : Colors.white,
          progress: searchDelegate.transitionAnimation,
          icon: AnimatedIcons.search_ellipsis),
      onPressed: () async {
        final String selected = await showSearch<String>(
          context: context,
          delegate: searchDelegate,
        );
        if (!hasHitSearch) showInfoDialogWithCloseButton(context);
        handleSearchButtonAnimationAndPersistHit();

        if (selected != null /*&& selected != _lastIntegerSelected*/) {
          filterListUpdateTitle(selected);
        } else {
          showUnfilteredLists();
          updateTitle();
        }
      },
      tooltip: 'Search',
    );
  }

  Widget buildIconButtonSearchInfo(
      BuildContext context, bool showSearchAnimation) {
    return Transform.rotate(
        angle: 44.6,
        child: IconButton(
          color: Colors.white70,
          //iconSize: 40.0,
          icon: Icon(
              //color: Colors.white,
              //progress: searchDelegate.transitionAnimation,
              Icons.arrow_upward),
          onPressed: () {
            //showInfoDialogWithCloseButton(context);
            //initBlinkAnimation();
          },
          tooltip: 'Touch the search button on the top right.',
        ));
  }

  void handleSearchButtonAnimationAndPersistHit() async {
    if (hasHitSearch == null || !hasHitSearch) {
      if (searchIconBlinkAnimationController != null) {
        setState(() {
          searchIconBlinkAnimationController.reset();
          //searchIconBlinkAnimationController.value = 0.0;
        });
      }

      setState(() {
        hasHitSearch = true;
      });

      persistHasHitSearch();
      //initHasHitSearch();
    }
  }

  void filterListUpdateTitle(String selected) {
    var selectedArray = selected.split(",");
    final String title = selectedArray[0];
    final String search = title.split(" - ")[0];
    final String fileName = selectedArray.length > 1 ? selectedArray[1] : null;

    var index = _getTagIndex(selected);
    loadAssets(index, search, fileName);

    setState(() {
      _searchTerm = search;
      _title = search;
    });
  }

  void showUnfilteredLists() {
    if (isFilteredList()) {
      _searchTerm = '';
      loadAssets(-1, null, null);
    }
  }

  bool isFilteredList() => _searchTerm != null && _searchTerm.isNotEmpty;

  /* Widget buildLa() {
    showInfoDialogWithCloseButton(context);
    return buildSearchHintRow('Touch the search icon');
  }*/

  Widget buildTabContainer(var listKey, var list, var builderMethod, var cat) {
    return (list != null && list.length > 0)
        ? Padding(
            child: AnimatedList(
              //padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
              key: listKey,
              initialItemCount: list.length,
              itemBuilder: builderMethod,
            ),
            padding: EdgeInsets.all(0.0),
          )
        : Padding(
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
            child: isFilterEmpty()
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: buildSearchHintRow('Touch the search button'),
                        )
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Text(
                        cat.toString().toUpperCase(),
                        textScaleFactor: 1.5,
                      ),*/
                      buildSeparator(),
                      Text(
                        'There are no matches in this category.',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      buildSeparator(),
                      Row(
                        children: <Widget>[
                          /*IconButton(icon: */Icon(Icons.arrow_upward),
                          const Text(
                            'Hit a colored icon to see matches.',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      buildSeparator(),
                      Row(children: <Widget>[
                        buildHomeButton(),
                        const Text(
                          'Show all merchants of all categories.',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ]),
                      buildSeparator(),
                      buildSearchHintRow('Filter for locations or tags.'),
                    ],
                  ));
  }

  Row buildSearchHintRow(final String text) {
    return Row(children: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
      ),
      Text(
        text,
        overflow: TextOverflow.fade,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      buildIconButtonSearchInfo(context, false),
    ]);
  }

  IconButton buildHomeButton() {
    return IconButton(
      tooltip: isFilterEmpty() ? 'Home' : 'Clear Filter',
      icon: AnimatedIcon(
        icon: isFilterEmpty()
            ? AnimatedIcons.home_menu
            : AnimatedIcons.close_menu,
        color: Colors.white,
        progress: searchDelegate.transitionAnimation,
      ),
      onPressed: () {
        if (isFilterEmpty()) {
          tabController.animateTo(0);
          return;
        }

        updateTitle();

        setState(() {
          showUnfilteredLists();
        });
      },
    );
  }

  SizedBox buildSeparator() {
    return const SizedBox(
      height: 10,
    );
  }
}

int _getTagIndex(String searchTerm) {
  Tags.tagText.contains(searchTerm);
  int i = 0;
  for (; i < Tags.tagText.length; i++) {
    if (Tags.tagText.elementAt(i) == searchTerm) {
      break;
    }
  }

  return i;
}

void main() {
  runApp(AnimatedListSample());
}
