import 'package:flutter/material.dart';
import 'SuggestionList.dart';
import 'Tags.dart';
import 'SuggestionMatch.dart';

class SearchDemoSearchDelegate extends SearchDelegate<SuggestionMatch> {
  //final List<int> _data = List<int>.generate(100001, (int i) => i).reversed.toList();
  //final List<int> _history = <int>[42607, 85604, 66374, 44, 174];
  final List<SuggestionMatch> _history = <SuggestionMatch>[
    SuggestionMatch(text: 'bla', index: 0),
    SuggestionMatch(text: 'bla1', index: 1)
  ];

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
    List<SuggestionMatch> matches = new List();

    if (pattern.length <= 2) return matches;

    for (int x = 0; x < Tags.tagText.length; x++) {
      String currentItem = Tags.tagText.elementAt(x);
      if (currentItem.toLowerCase().contains(pattern.toLowerCase())) {
        matches.add(new SuggestionMatch(text: currentItem, index: x));
      }
    }

    return matches;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<SuggestionMatch> suggestions =
        query.isEmpty ? _history : _getSuggestions(query);
    //: _data.where((int i) => '$i'.startsWith(query));

    return SuggestionList(
      query: query,
      suggestions:
          suggestions.map<String>((SuggestionMatch i) => i.text).toList(),
      //suggestions: suggestions.map<String>((int i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        //showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //close(context, null);
    Navigator.pop(context);
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
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
    ];
  }
}
