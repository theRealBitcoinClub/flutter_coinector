import 'package:flutter/material.dart';

import 'SearchDemoSearchDelegate.dart';
import 'SuggestionList.dart';
import 'Tag.dart';

class AddPlaceTagSearchDelegate extends SearchDelegate<String> {
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

  _getSuggestions(String pattern) {
    List<String> matches = new List();

    addMatches(pattern, matches, Tag.tagText);
    addMatches(pattern, matches, Tag.tagTextES);
    addMatches(pattern, matches, Tag.tagTextDE);
    addMatches(pattern, matches, Tag.tagTextFR);
    addMatches(pattern, matches, Tag.tagTextIT);
    addMatches(pattern, matches, Tag.tagTextINDONESIA);
    addMatches(pattern, matches, Tag.tagTextJP1);
    addMatches(pattern, matches, Tag.tagTextJP2);

    if (matches.length == 0) {
      matches.add(SearchDemoSearchDelegate.TRY_ANOTHER_WORD);
    }

    return matches;
  }

  void addMatches(String pattern, List<String> matches, set) {
    for (int x = 0; x < set.length; x++) {
      addMatch(x, pattern, matches, set.elementAt(x));
    }
  }

  void addMatch(
      int x, String pattern, List<String> matches, String currentItem) {
    if (startsWith(currentItem, pattern)) {
      matches.add(currentItem);
    }
  }

  bool startsWith(String currentItem, String pattern) =>
      currentItem.toLowerCase().startsWith(pattern.toLowerCase());

  static const YOU_CAN_SCROLL = "You can scroll this list!";

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [YOU_CAN_SCROLL];
    if (query.isEmpty) {
      suggestions.addAll(Tag.tagText);
      //TODO show the device language FIRST
      suggestions.addAll(cleanSuggestions(Tag.tagTextES));
      suggestions.addAll(cleanSuggestions(Tag.tagTextDE));
      suggestions.addAll(cleanSuggestions(Tag.tagTextFR));
      suggestions.addAll(cleanSuggestions(Tag.tagTextIT));
      suggestions.addAll(cleanSuggestions(Tag.tagTextINDONESIA));
      suggestions.addAll(cleanSuggestions(Tag.tagTextJP1));
      suggestions.addAll(cleanSuggestions(Tag.tagTextJP2));
    } else {
      suggestions = _getSuggestions(query);
    }

    return SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => i).toList(),
      onSelected: (String match) {
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

  Iterable<String> cleanSuggestions(Iterable<String> suggestions) {
    List<String> cleanSuggestions = [];
    suggestions.forEach((String suggestion) {
      if (!suggestion.contains("🍔🍔🍔")) {
        cleanSuggestions.add(suggestion);
      }
    });
    return cleanSuggestions;
  }
//TODO Whenever a country specific suggestions startsWith "🍔🍔🍔" you should use the english variant instead
}
