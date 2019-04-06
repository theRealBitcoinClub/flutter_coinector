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
  const _Page({this.text});
  final String text;
}
const List<_Page> _pagesTags = <_Page>[
  _Page(text: 'ORGANIC'),
  _Page(text: 'BURGER'),
  _Page(text: 'VEGAN'),
  _Page(text: 'PIZZA'),
  _Page(text: 'JUICE'),
  _Page(text: 'SALAD'),
  _Page(text: 'MARKET'),
 /* _Page(text: 'SWEET'),
  _Page(text: 'SPICEY'),
  _Page(text: 'SALTY'),
  _Page(text: 'COCKTAILS'),
  _Page(text: 'BEER'),
  _Page(text: 'MUSIC'),*/
];

class _AnimatedListSampleState extends State<AnimatedListSample> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TabController _controller;
  bool _customIndicator = false;
  ListModel<Merchant> _list;
  int _selectedItem;
  int _nextItem; // The next item inserted when the user presses the '+' button.
  final dio = new Dio(); // for http requests
  List<Merchant> names = new List<Merchant>(); // names we get from API
  ListModel<Merchant> tempList;
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
    tempList = ListModel<Merchant>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );

    //RESPONSE.DATA.LENGTH
    for (int i = 0; i < 5; i++) {
      Merchant m2 = Merchant.fromJson(response.data[i]);
      //tempList.add(m2);
      tempList.insert(_list.length, m2);
      //print(response.data[i].toString());
    }
    //tempList.sublist(0, 10);

    setState(() {
      _list = tempList;
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
    _list = ListModel<Merchant>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
    _getNames();
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          //_selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
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
            body1: TextStyle(fontSize: 18.0, fontFamily: 'Hind', color: Colors.white),
            body2: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
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
                  return Tab(text: page.text);
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
        body: TabBarView(
        controller: _controller,
        children: _pagesTags.map<Widget>((_Page page) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildItem,
            ),
          );
        }).toList(),
      ),

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
