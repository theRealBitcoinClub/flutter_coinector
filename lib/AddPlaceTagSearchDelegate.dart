import 'package:flutter/material.dart';

import 'SuggestionList.dart';
import 'Tags.dart';

class AddPlaceTagSearchDelegate extends SearchDelegate<String> {
  final Set<String> suggestionsFromTags = Set.from(Tag.tagText);

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

    if (matches.length == 0) {
      matches.add(TRY_ANOTHER_WORD);
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

  static const TRY_ANOTHER_WORD = 'Not found! Try another word!';

  @override
  Widget buildSuggestions(BuildContext context) {
    Iterable<String> suggestions =
        query.isEmpty ? cleanSuggestions(suggestionsFromTags) : _getSuggestions(query);

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
      if (!suggestion.contains("🎸🎧🎁")) {
        cleanSuggestions.add(suggestion);
      }
    });
    return cleanSuggestions;
  }
}
