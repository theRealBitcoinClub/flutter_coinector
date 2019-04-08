import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'ListModel.dart';
import 'CardItem.dart';
import 'Merchant.dart';
import 'dart:convert';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _Page {
  const _Page({this.text, this.icon, this.title});
  final String text;
  final String title;
  final IconData icon;
}

//TODO add takeaway
const List<_Page> _pagesTags = <_Page>[
  _Page(text: 'EAT', icon: Icons.restaurant, title: 'RESTAURANT & TAKE-AWAY'),
  _Page(text: 'BAR', icon: Icons.local_bar, title: 'BAR, CLUB & CAFE'),
  _Page(text: 'MARKET', icon: Icons.shopping_cart, title: 'SUPERMARKET'),
  _Page(text: 'SHOP', icon: Icons.shopping_basket, title: 'SOUVENIR & SERVICE'),
  _Page(text: 'HOTEL', icon: Icons.hotel, title: 'HOTEL, B&B, FLAT'),
  _Page(text: 'ATM', icon: Icons.atm, title: 'TELLER & TRADER'),
  _Page(text: 'SPA', icon: Icons.spa, title: 'WELLNESS & BEAUTY'),
  /*
  _Page(text: 'JUICE'),
  _Page(text: 'SALAD'),
  _Page(text: 'MARKET'),
  _Page(text: 'SWEET'),
  _Page(text: 'SPICEY'),
  _Page(text: 'SALTY'),
  _Page(text: 'COCKTAILS'),
  _Page(text: 'BEER'),
  _Page(text: 'MUSIC'),*/
];

class _AnimatedListSampleState extends State<AnimatedListSample>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKeyRestaurant =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyBar =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyHotel =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyATM =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyShop =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyMarket =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKeyWellness =
      GlobalKey<AnimatedListState>();
  TabController _controller;
  bool _customIndicator = false;
  ListModel<Merchant> _listRestaurant;
  ListModel<Merchant> _listBar;
  ListModel<Merchant> _listMarket;
  ListModel<Merchant> _listShop;
  ListModel<Merchant> _listHotel;
  ListModel<Merchant> _listATM;
  ListModel<Merchant> _listWellness;
  int _selectedItem;
  int _nextItem; // The next item inserted when the user presses the '+' button.
  final dio = new Dio(); // for http requests
  List<Merchant> names = new List<Merchant>(); // names we get from API
  ListModel<Merchant> tempListRestaurant;
  ListModel<Merchant> tempListBar;
  ListModel<Merchant> tempListMarket;
  ListModel<Merchant> tempListShop;
  ListModel<Merchant> tempListHotel;
  ListModel<Merchant> tempListATM;
  ListModel<Merchant> tempListWellness;
  Response response;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getNames() async {
    if (response == null)
      response =
          await dio.get('https://realbitcoinclub.firebaseapp.com/places8.json');

    //List<Merchant> tempList = new List<Merchant>();
    tempListRestaurant = ListModel<Merchant>(
      listKey: _listKeyRestaurant,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListBar = ListModel<Merchant>(
      listKey: _listKeyBar,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListHotel = ListModel<Merchant>(
      listKey: _listKeyHotel,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListATM = ListModel<Merchant>(
      listKey: _listKeyATM,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListMarket = ListModel<Merchant>(
      listKey: _listKeyMarket,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListShop = ListModel<Merchant>(
      listKey: _listKeyShop,
      removedItemBuilder: _buildRemovedItem,
    );
    tempListWellness = ListModel<Merchant>(
      listKey: _listKeyWellness,
      removedItemBuilder: _buildRemovedItem,
    );

    //RESPONSE.DATA.LENGTH
    for (int i = 0; i < 100; i++) {
      Merchant m2 = Merchant.fromJson(response.data[i]);
      //Merchant m3 = Merchant.fromJson(response.data[i]);
      //tempList.add(m2);
      if (m2.type == 0 || m2.type == 1)
        tempListRestaurant.insert(_listRestaurant.length, m2);
      else if (m2.type == 2)
        tempListBar.insert(_listBar.length, m2);
      else if (m2.type == 3)
        tempListMarket.insert(_listMarket.length, m2);
      else if (m2.type == 4)
        tempListShop.insert(_listShop.length, m2);
      else if (m2.type == 5)
        tempListHotel.insert(_listHotel.length, m2);
      else if (m2.type == 999)
        tempListWellness.insert(_listWellness.length, m2);
      else if (m2.type == 99) tempListATM.insert(_listATM.length, m2);
      /*switch (m2.type) {
        case 0: tempListRestaurant.insert(_listRestaurant.length, m2); return;
        case 1: tempListRestaurant.insert(_listRestaurant.length, m2); return;
        case 2: tempListBar.insert(_listBar.length, m2); return;
        case 5: tempListHotel.insert(_listHotel.length, m2); return;
        case 99: tempListATM.insert(_listATM.length, m2); return;
      }*/

      var x = "";
      //tempList.insert(_list.length, m2);
      //print(response.data[i].toString());
    }
    //tempList.sublist(0, 10);

    setState(() {
      _listRestaurant = tempListRestaurant;
      _listBar = tempListBar;
      _listHotel = tempListHotel;
      _listATM = tempListATM;
      _listMarket = tempListMarket;
      _listShop = tempListShop;
      _listWellness = tempListWellness;
    });
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

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _pagesTags.length);
    _listRestaurant = ListModel<Merchant>(
      listKey: _listKeyRestaurant,
      removedItemBuilder: _buildRemovedItem,
    );
    _listBar = ListModel<Merchant>(
      listKey: _listKeyBar,
      removedItemBuilder: _buildRemovedItem,
    );
    _listHotel = ListModel<Merchant>(
      listKey: _listKeyHotel,
      removedItemBuilder: _buildRemovedItem,
    );
    _listATM = ListModel<Merchant>(
      listKey: _listKeyATM,
      removedItemBuilder: _buildRemovedItem,
    );
    _listMarket = ListModel<Merchant>(
      listKey: _listKeyMarket,
      removedItemBuilder: _buildRemovedItem,
    );
    _listShop = ListModel<Merchant>(
      listKey: _listKeyShop,
      removedItemBuilder: _buildRemovedItem,
    );
    _listWellness = ListModel<Merchant>(
      listKey: _listKeyWellness,
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
    _getNames();
  }

  // Used to build list items that haven't been removed.
  Widget _buildItemRestaurant(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listRestaurant[index],
    );
  }

  Widget _buildItemBar(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listBar[index],
    );
  }

  Widget _buildItemHotel(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listHotel[index],
    );
  }

  Widget _buildItemATM(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listATM[index],
    );
  }

  Widget _buildItemWellness(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listWellness[index],
    );
  }

  Widget _buildItemMarket(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listMarket[index],
    );
  }

  Widget _buildItemShop(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listShop[index],
    );
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

  // Insert the "next item" into the list model.
  void _insert() {
    //final int index =
    //_selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    //_list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      //_list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
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
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(
              fontSize: 18.0, fontFamily: 'Hind', color: Colors.white),
          body2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Coinector'),
            bottom: TabBar(
              controller: _controller,
              isScrollable: true,
              indicator: getIndicator(),
              tabs: _pagesTags.map<Tab>((_Page page) {
                return Tab(icon: Icon(page.icon), text: page.text);
              }).toList(),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _insert,
                tooltip: 'search',
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: _remove,
                tooltip: 'settings',
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 30.0,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("KATEGORIE"/* TODO titlerein _pagesTags[_controller.index].title*/,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                    /*background: Image.network(
                        "https://realbitcoinclub.firebaseapp.com/img/app/trbc.gif",
                        fit: BoxFit.cover,
                      ) TODO restaurants image w/ text*/
                  ),
                ),
              ];
            },
            body: TabBarView(controller: _controller, children: [
              //_pagesTags.map<Widget>((_Page page) {
              // if (page.text == "RESTAURANT") {
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyRestaurant,
                  initialItemCount: _listRestaurant.length,
                  itemBuilder: _buildItemRestaurant,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyBar,
                  initialItemCount: _listBar.length,
                  itemBuilder: _buildItemBar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyMarket,
                  initialItemCount: _listMarket.length,
                  itemBuilder: _buildItemMarket,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyShop,
                  initialItemCount: _listShop.length,
                  itemBuilder: _buildItemShop,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyHotel,
                  initialItemCount: _listHotel.length,
                  itemBuilder: _buildItemHotel,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyATM,
                  initialItemCount: _listATM.length,
                  itemBuilder: _buildItemATM,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AnimatedList(
                  key: _listKeyWellness,
                  initialItemCount: _listWellness.length,
                  itemBuilder: _buildItemWellness,
                ),
              )
            ]
                /* } else if (page.text == "BAR") {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedList(
                key: _listKeyBar,
                initialItemCount: _listBar.length,
                itemBuilder: _buildItemBar,
              ),
            );
          } else if (page.text == "HOTEL") {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedList(
                key: _listKeyHotel,
                initialItemCount: _listHotel.length,
                itemBuilder: _buildItemHotel,
              ),
            );
          } else if (page.text == "ATM") {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedList(
                key: _listKeyATM,
                initialItemCount: _listATM.length,
                itemBuilder: _buildItemATM,
              ),
            );
          }*/

                //}).toList(),
                ),
          )

          /*   Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),*/
          ),
    );
  }
}

void main() {
  runApp(AnimatedListSample());
}
