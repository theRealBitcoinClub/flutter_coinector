import 'package:Coinector/Localizer.dart';
import 'package:Coinector/TagFactory.dart';
import 'package:Coinector/translator.dart';
import 'package:flutter/material.dart';

import 'SuggestionList.dart';
import 'TagCoinector.dart';
import 'Toaster.dart';

class AddPlaceTagSearchDelegate extends SearchDelegate<String> {
  Set<int> alreadySelectedTagIndexes = Set.from([]);

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

  _getSuggestions(String pattern, ctx) {
    Set<String> matches = {};
    addMatches(pattern, matches, TagFactory.getTags(ctx));
    addMatches(
        pattern,
        matches,
        TagFactory.getTags(ctx,
            lang: LangCode.EN)); //Adding english always as default

    if (matches.length == 0) {
      matches.add(Translator.translate(ctx, "try_another_word"));
      //matches.add(SearchDemoSearchDelegate.TRY_ANOTHER_WORD);
    }

    return matches;
  }

  void addMatches(
      String pattern, Set<String> matches, Set<TagCoinector> sourceSet) {
    for (int x = 0; x < sourceSet.length; x++) {
      if (alreadySelectedTagIndexes.contains(x)) continue;
      addMatch(x, pattern, matches, sourceSet.elementAt(x).toUI());
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

  Set<String> unfilteredSuggestions;

  @override
  Widget buildSuggestions(BuildContext ctx) {
    Set<String> suggestions = Set.from([
      //  Localizer.COINECTOR_SUPPORTS_MANY_LANGUAGES,
      Translator.translate(ctx, "you_can_scroll")
    ]);

    if (unfilteredSuggestions != null && query.isEmpty)
      suggestions = unfilteredSuggestions;
    else if (query.isEmpty) {
      suggestions = addAllTagsInAllLanguages(suggestions, ctx);
      unfilteredSuggestions = suggestions;
    } else {
      suggestions = _getSuggestions(query, ctx);
    }

    return SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => i).toList(),
      onSelected: (String match) {
        unfilteredSuggestions = null;
        close(ctx, match);
      },
    );
  }

  Set<String> addAllTagsInAllLanguages(Set<String> suggestions, ctx) {
    suggestions.addAll(parseTagsToSuggestions(TagFactory.getTags(ctx)));
    suggestions.addAll(
        parseTagsToSuggestions(TagFactory.getTags(ctx, lang: LangCode.EN)));
    return suggestions;
  }

  @override
  void showResults(BuildContext context) {
    //DONT SHOW ANY RESULTS HERE, SIMPLY REMOVE THE WIDGET
    //THIS METHOD IS CALLED WHEN USER HITS THE SEARCH ICON OF THE KEYBOARD LAYOUT
    Toaster.showToastSelectSuggestion();
    //close(context, null);
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

  Set<String> parseTagsToSuggestions(Set<TagCoinector> tags) {
    Set<String> parsedSuggestions = Set.from([]);
    tags.forEach((TagCoinector t) {
      if (!t.text.startsWith("🍔🍔🍔")) {
        parsedSuggestions =
            checkIfAlreadySelectedAndAddIfNot(t, parsedSuggestions);
      }
    });
    return parsedSuggestions;
  }

  Set<String> checkIfAlreadySelectedAndAddIfNot(
      TagCoinector t, Set<String> cleanSuggestions) {
    if (alreadySelectedTagIndexes.length == 0 ||
        !alreadySelectedTagIndexes.contains(t.id)) {
      cleanSuggestions.add(t.toUI());
    }
    return cleanSuggestions;
  }
}
