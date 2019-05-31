import 'package:flutter/material.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'SearchDemoSearchDelegate.dart';
import 'SuggestionMatch.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  String addSeparator(String input) {
    return input != null && input.isNotEmpty ? " - " + input : "";
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final SuggestionMatch match =
            SuggestionMatch.parseString(suggestions[i], i);
        final String searchMatch = capitalize(match.searchMatch);
        final String state = addSeparator(match.state);
        final String continent = addSeparator(match.continent);
        return ListTile(
          leading: query.isEmpty
              ? match.fileName.isEmpty
                  ? !isRealSuggestion(searchMatch)
                      ? const Icon(Icons.warning)
                      : const Icon(Icons.history)
                  : const Icon(Icons.location_searching)
              : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: (isRealSuggestion(searchMatch))
                  ? searchMatch.isNotEmpty
                      ? searchMatch.substring(0, query.length)
                      : searchMatch
                  : searchMatch,
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: (isRealSuggestion(searchMatch))
                      ? searchMatch.isNotEmpty
                          ? searchMatch.substring(query.length)
                          : ''
                      : '',
                  style: theme.textTheme.subhead,
                ),
                TextSpan(
                  text: state,
                  style: theme.textTheme.subhead
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
                TextSpan(
                  text: continent,
                  style: theme.textTheme.subhead
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          onTap: () {
            if (isRealSuggestion(searchMatch)) {
              onSelected(match.input);
            }
          },
        );
      },
    );
  }

  bool isRealSuggestion(String suggestion) {
    return SearchDemoSearchDelegate.TRY_ANOTHER_WORD != suggestion &&
        AddPlaceTagSearchDelegate.YOU_CAN_SCROLL != suggestion;
  }
}
