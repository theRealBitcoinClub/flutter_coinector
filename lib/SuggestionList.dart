import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final SuggestionMatch match =
            SuggestionMatch.parseString(suggestions[i], i);
        final String searchMatch = match.searchMatch;
        final String state = addSeparator(match.state);
        final String continent = addSeparator(match.continent);
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
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
    return SearchDemoSearchDelegate.TRY_ANOTHER_WORD != suggestion;
    //SearchDemoSearchDelegate.ENTER_ATLEAST_THREE != suggestion;
  }
}
