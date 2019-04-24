import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'ListModel.dart';
import 'CardItem.dart';
import 'Merchant.dart';
import 'SearchDemoSearchDelegate.dart';
import 'Tags.dart';
import 'dart:convert';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _Page {
  const _Page({this.text, this.icon, this.title, this.index});
  final String text;
  final String title;
  final IconData icon;
  final int index;
}

//TODO add takeaway
const List<_Page> _pagesTags = <_Page>[
  _Page(text: 'EAT', icon: Icons.restaurant, title: 'RESTAURANT', index: 0),
  _Page(
      text: 'TOGO',
      icon: Icons.restaurant_menu,
      title: 'TAKE-AWAY & DELIVERY',
      index: 1),
  _Page(
      text: 'BAR', icon: Icons.local_bar, title: 'BAR, CLUB & CAFE', index: 2),
  _Page(
      text: 'MARKET',
      icon: Icons.shopping_cart,
      title: 'SUPERMARKET',
      index: 3),
  _Page(
      text: 'SHOP',
      icon: Icons.shopping_basket,
      title: 'SOUVENIR & SERVICE',
      index: 4),
  _Page(text: 'HOTEL', icon: Icons.hotel, title: 'HOTEL, B&B, FLAT', index: 5),
  _Page(text: 'ATM', icon: Icons.atm, title: 'TELLER & TRADER', index: 6),
  _Page(text: 'SPA', icon: Icons.spa, title: 'WELLNESS & BEAUTY', index: 7),
];

List<_Page> _filteredPages = _pagesTags;

class _AnimatedListSampleState extends State<AnimatedListSample>
    with SingleTickerProviderStateMixin {
  final SearchDemoSearchDelegate _delegate = SearchDemoSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<GlobalKey<AnimatedListState>> _listKeys = [];
  TabController _controller;
  bool _customIndicator = false;
  List<ListModel<Merchant>> _lists = [];
  final dio = new Dio(); // for http requests
  List<Merchant> names = new List<Merchant>(); // names we get from API
  List<ListModel<Merchant>> tempLists = [];
  List<ListModel<Merchant>> unfilteredLists = [];
  Response response;
  String _title = "Coinector";
  bool isUnfilteredList = false;

  String _searchTerm;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getNames(
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
    List<dynamic> placesList;

    if (fileName == null) {
      placesList = await loadAndEncodeAsset('assets/places.json');
    } else {
      placesList = await loadAndEncodeAsset('assets/' + fileName + '.json');
    }

    initTempListModel();
    _filteredPages = _pagesTags;

    //RESPONSE.DATA.LENGTH
    for (int i = 0; i < placesList.length; i++) {
      //Merchant m2 = Merchant.fromJson(response.data[i]);
      Merchant m2 = Merchant.fromJson(placesList.elementAt(i));

      _insertIntoTempList(m2, filterWordIndex, locationFilter);
    }

    if (unfilteredLists.length == 0) initUnfilteredLists();

    updateListModel(tempLists);
  }

  void updateList(List destination, List tmpList) {
    destination.clear();
    for (int i = 0; i < tmpList.length; i++) {
      destination.add(tmpList[i]);
    }
  }

  void updateListModel(List<ListModel<Merchant>> tmpList) {
    setState(() {
      updateList(_lists, tmpList);
    });
  }

  void initUnfilteredLists() {
    updateList(unfilteredLists, tempLists);
  }

  Future<List<dynamic>> loadAndEncodeAsset(final String fileName) async {
    String asset = await rootBundle.loadString(fileName);
    return json.decode(asset);
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
    for (int i = 0; i < 8; i++) {
      _listKeys.add(GlobalKey<AnimatedListState>());
      lists.add(ListModel<Merchant>(
        listKey: _listKeys[i],
        removedItemBuilder: _buildRemovedItem,
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
    _delegate.buildHistory();
    _controller = TabController(vsync: this, length: _filteredPages.length);
    updateTitle();
    _controller.addListener(_handleTabSelection);
    initListModel();
    _getNames(-1, null, null);
  }

  void updateTitle() {
    setState(() {
      _title = _pagesTags[_controller.index].title;
    });
  }

  void initListModel() {
    initListModelSeveralTimes(_lists);
  }

  CardItem _buildItem(
      int index, Animation<double> animation, ListModel<Merchant> listModel) {
    try {
      if (listModel != null &&
          listModel[index] != null &&
          listModel.length > 0) {
        return CardItem(
          animation: animation,
          item: listModel[index],
        );
      }
    } catch (e) {
      //not catching RangeErrors caused issues with filterbar
      return null;
    }
    return null;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItemRestaurant(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[0]);
  }

  // Used to build list items that haven't been removed.
  Widget _buildItemTogo(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[1]);
  }

  Widget _buildItemBar(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[2]);
  }

  Widget _buildItemMarket(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[3]);
  }

  Widget _buildItemShop(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[4]);
  }

  Widget _buildItemHotel(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[5]);
  }

  Widget _buildItemATM(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[6]);
  }

  Widget _buildItemWellness(
      BuildContext context, int index, Animation<double> animation) {
    return _buildItem(index, animation, _lists[7]);
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      Merchant item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        accentColor: Colors.white,

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.normal,
              color: Colors.grey[900]),
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
                  leading: IconButton(
                    tooltip: isFilterEmpty() ? 'Home' : 'Clear Filter',
                    icon: AnimatedIcon(
                      icon: isFilterEmpty()
                          ? AnimatedIcons.home_menu
                          : AnimatedIcons.close_menu,
                      color: Colors.white,
                      progress: _delegate.transitionAnimation,
                    ),
                    onPressed: () {
                      if (isFilterEmpty()) {
                        _controller.animateTo(0);
                        return;
                      }

                      updateTitle();

                      setState(() {
                        showUnfilteredLists();
                      });
                    },
                  ),
                  //title: Text(_title),
                  bottom: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    indicator: getIndicator(),
                    tabs: _filteredPages.map<Tab>((_Page page) {
                      return Tab(icon: Icon(page.icon), text: page.text);
                    }).toList(),
                  ),
                  actions: <Widget>[
                    buildIconButtonSearch(context),
                    /*IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: _remove,
                      tooltip: 'settings',
                    ),*/
                  ],
                  title: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Text(_title)),
                  //expandedHeight: 300.0, GOOD SPACE FOR ADS LATER
                  floating: true,
                  snap: true,
                  pinned: false,
                  /*flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("KATEGORIE"/* TODO titlerein _pagesTags[_controller.index].title*/,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                    background: Image.network(
                        "https://realbitcoinclub.firebaseapp.com/img/app/trbc.gif",
                        fit: BoxFit.cover,
                      ) //TODO restaurants image w/ text
                  ),*/
                ),
              ];
            },
            body: TabBarView(controller: _controller, children: [
              buildTabContainer(_listKeys[0], _lists[0], _buildItemRestaurant,
                  _pagesTags[0].title),
              buildTabContainer(
                  _listKeys[1], _lists[1], _buildItemTogo, _pagesTags[1].title),
              buildTabContainer(
                  _listKeys[2], _lists[2], _buildItemBar, _pagesTags[2].title),
              buildTabContainer(_listKeys[3], _lists[3], _buildItemMarket,
                  _pagesTags[3].title),
              buildTabContainer(
                  _listKeys[4], _lists[4], _buildItemShop, _pagesTags[4].title),
              buildTabContainer(_listKeys[5], _lists[5], _buildItemHotel,
                  _pagesTags[5].title),
              buildTabContainer(
                  _listKeys[6], _lists[6], _buildItemATM, _pagesTags[6].title),
              buildTabContainer(_listKeys[7], _lists[7], _buildItemWellness,
                  _pagesTags[7].title)
            ]),
          )),
    );
  }

  bool isFilterEmpty() => _searchTerm == null || _searchTerm.isEmpty;

  IconButton buildIconButtonSearch(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          progress: _delegate.transitionAnimation,
          icon: AnimatedIcons.search_ellipsis),
      onPressed: () async {
        final String selected = await showSearch<String>(
          context: context,
          delegate: _delegate,
        );

        if (selected != null /*&& selected != _lastIntegerSelected*/) {
          var selectedArray = selected.split(",");
          final String title = selectedArray[0];
          final String search = title.split(" - ")[0];
          final String fileName =
              selectedArray.length > 1 ? selectedArray[1] : null;

          var index = _getTagIndex(selected);
          _getNames(index, search, fileName);

          setState(() {
            _searchTerm = search;
            _title = title;
          });
        } else {
          showUnfilteredLists();
          updateTitle();
        }
      },
      tooltip: 'Search',
    );
  }

  void showUnfilteredLists() {
    if (isFilteredList()) {
      _searchTerm = '';
      _getNames(-1, null, null);
    }
  }

  bool isFilteredList() => _searchTerm != null && _searchTerm.isNotEmpty;

  Padding buildTabContainer(var listKey, var list, var builderMethod, var cat) {
    return (list != null && list.length > 0)
        ? Padding(
            child: AnimatedList(
              /*padding: const EdgeInsets.only(
              top: 0.0,
            ),*/
              key: listKey,
              initialItemCount: list.length,
              itemBuilder: builderMethod,
            ),
            padding: EdgeInsets.all(0.0),
          )
        : Padding(
            padding: EdgeInsets.all(15.0),
            child: isFilterEmpty()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Text(cat.toString().toUpperCase()),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You filtered for $_searchTerm, but there are no matching results in this category!',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Tap the X on the top left to retrieve unfiltered results or filter for a different word by tapping the search icon on the top right.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ));
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
