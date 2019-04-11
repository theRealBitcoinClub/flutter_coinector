import 'package:flutter/material.dart';
import 'SuggestionList.dart';
import 'Tags.dart';
import 'SuggestionMatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDemoSearchDelegate extends SearchDelegate<String> {
  //final List<int> _data = List<int>.generate(100001, (int i) => i).reversed.toList();
  //final List<int> _history = <int>[42607, 85604, 66374, 44, 174];
  final Set<String> _history = Set.from(<String>[]);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  buildHistory() async {
    List<String> historyItems = await getHistory();
    if (historyItems == null || historyItems.isEmpty) return;

    historyItems = _reverseList(historyItems);
    _history.clear();
    historyItems.forEach((item) => _history.add(item));
  }

  _reverseList(List<String> list) {
    List<String> reversedList = [];
    list.forEach((item) => reversedList.insert(0, item));
    return reversedList;
  }

  var _kNotificationsPrefs = "historyItems";

  Future<List<String>> getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_kNotificationsPrefs);
  }

  Future<bool> setHistory(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kNotificationsPrefs, value);
  }

  _getSuggestions(String pattern) {
    List<String> matches = new List();

    if (pattern.length < 3) {
      matches.add(ENTER_ATLEAST_THREE);
      return matches;
    }

    for (int x = 0; x < Tags.tagText.length; x++) {
      String currentItem = Tags.tagText.elementAt(x);
      if (currentItem.toLowerCase().contains(pattern.toLowerCase())) {
        matches.add(currentItem);
      }
    }

    if (matches.length == 0) {
      matches.add(TRY_ANOTHER_WORD);
    }

    return matches;
  }

  static final TRY_ANOTHER_WORD = 'Try another word!';
  static final ENTER_ATLEAST_THREE = 'Enter atleast 3 characters!';

  _addHistoryItem(String item) async {
    List<String> historyItems = await getHistory();

    if (historyItems == null) historyItems = [];

    historyItems.add(item);
    _history.add(item);
    setHistory(historyItems);
    buildHistory();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions =
        query.isEmpty ? _history : _getSuggestions(query);
    //: _data.where((int i) => '$i'.startsWith(query));

    return SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => i).toList(),
      //suggestions: suggestions.map<String>((int i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        _addHistoryItem(suggestion);
        close(context, suggestion);
        //showResults(context);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    //DONT SHOW ANY RESULTS HERE, SIMPLY REMOVE THE WIDGET
    close(context, null);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(padding: EdgeInsets.all(0.0),);
    //Navigator.pop(context);
    /*final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not in our tag base.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        Text( 'This integer'),
        Text( 'Next integer'),
      ],
    );*/
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      /*
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : */
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.delete_forever),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }
}
