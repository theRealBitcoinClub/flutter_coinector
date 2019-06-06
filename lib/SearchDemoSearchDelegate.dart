import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'SuggestionList.dart';
import 'Suggestions.dart';
import 'Tag.dart';

class SearchDemoSearchDelegate extends SearchDelegate<String> {
  final Set<String> _historyBackup = Set.from(Suggestions.locations);
  final Set<String> _history = Set.from(Suggestions.locations);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  //TODO make all button press async by default: onPressed: () async {

  buildHistory() async {
    List<String> historyItems = await getHistory();
    if (historyItems == null || historyItems.isEmpty) return;

    historyItems = _reverseList(historyItems);
    _history.clear();
    historyItems.forEach((item) => _history.add(item));
    _history.addAll(_historyBackup);
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

  _getSuggestions(String pattern, ctx) {
    Set<String> matches = Set.from([]);

    addMatches(pattern, matches, Tag.tagText);
    addMatches(pattern, matches, Tag.tagTextDE);
    addMatches(pattern, matches, Tag.tagTextES);
    addMatches(pattern, matches, Tag.tagTextFR);
    addMatches(pattern, matches, Tag.tagTextIT);
    addMatches(pattern, matches, Tag.tagTextJP1);
    addMatches(pattern, matches, Tag.tagTextJP2);
    addMatches(pattern, matches, Tag.tagTextINDONESIA);
    addMatches(pattern, matches, Suggestions.locations);
    addMatches(pattern, matches, Tag.titleTags);

    if (matches.length == 0) {
      matches.add(TRY_ANOTHER_WORD);
    } else {
      Set<String> moreMatches = Set.from([]);
      moreMatches
          .add(AddPlaceTagSearchDelegate.COINECTOR_SUPPORTS_MANY_LANGUAGES);
      moreMatches.add(FlutterI18n.translate(ctx, "you_can_scroll"));
      moreMatches.addAll(matches);
      return moreMatches;
    }

    return matches;
  }

  void addMatches(String pattern, Set<String> matches, set) {
    for (int x = 0; x < set.length; x++) {
      addMatch(x, pattern, matches, set.elementAt(x));
    }
  }

  void addMatch(
      int x, String pattern, Set<String> matches, String currentItem) {
    if (startsWith(currentItem, pattern)) {
      matches.add(currentItem);
    }
  }

  bool startsWith(String currentItem, String pattern) =>
      currentItem.toLowerCase().startsWith(pattern.toLowerCase());

  static const TRY_ANOTHER_WORD = 'Not found! Try another word!';

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
    Set<String> suggestions =
        query.isEmpty ? _history : _getSuggestions(query, context);

    if (query.isEmpty) {
      suggestions = Set.from([
        AddPlaceTagSearchDelegate.COINECTOR_SUPPORTS_MANY_LANGUAGES,
        FlutterI18n.translate(context, "you_can_scroll")
      ]);
      suggestions.addAll(_history);
    }

    return SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => i).toList(),
      onSelected: (String match) {
        String title = match.split(Suggestions.separator)[0];
        query = title.split(" - ")[0];
        _addHistoryItem(match);
        close(context, match);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    //DONT SHOW ANY RESULTS HERE, SIMPLY REMOVE THE WIDGET
    //THIS METHOD IS CALLED WHEN USER HITS THE SEARCH ICON OF THE KEYBOARD LAYOUT
    close(context, null);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //FocusScope.of(context).requestFocus(new FocusNode());
    return <Widget>[
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
