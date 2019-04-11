import 'package:flutter/material.dart';
import 'SearchDemoSearchDelegate.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: (isRealSuggestion(suggestion))
                  ? suggestion.substring(0, query.length)
                  : suggestion,
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: (isRealSuggestion(suggestion))
                      ? suggestion.substring(query.length)
                      : '',
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            if (isRealSuggestion(suggestion)) {
              onSelected(suggestion);
            }
          },
        );
      },
    );
  }

  bool isRealSuggestion(String suggestion) {
    return SearchDemoSearchDelegate.TRY_ANOTHER_WORD != suggestion &&
        SearchDemoSearchDelegate.ENTER_ATLEAST_THREE != suggestion;
  }
}
