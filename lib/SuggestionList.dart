import 'package:Coinector/translator.dart';
import 'package:flutter/material.dart';

import 'SuggestionMatch.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({required this.suggestions, required this.query, required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  String addSeparator(String input) {
    return input.isNotEmpty ? " - " + input : "";
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext ctx) {
    final ThemeData theme = Theme.of(ctx);
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
                  ? !isRealSuggestion(searchMatch, ctx)
                      ? null
                      : const Icon(Icons.history)
                  : const Icon(Icons.location_searching)
              : null,
          title: RichText(
            text: TextSpan(
              text: (isRealSuggestion(searchMatch, ctx))
                  ? searchMatch.isNotEmpty
                      ? searchMatch.substring(0, query.trim().length)
                      : searchMatch
                  : searchMatch,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: (isRealSuggestion(searchMatch, ctx))
                      ? searchMatch.isNotEmpty
                          ? searchMatch.substring(query.trim().length)
                          : ''
                      : '',
                  style: theme.textTheme.titleMedium,
                ),
                TextSpan(
                  text: state,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.white.withAlpha(127)),
                ),
                TextSpan(
                  text: continent,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.white.withAlpha(127)),
                ),
              ],
            ),
          ),
          onTap: () {
            if (isRealSuggestion(searchMatch, context)) {
              onSelected(match.input);
            }
          },
        );
      },
    );
  }

  bool isRealSuggestion(String suggestion, ctx) {
    return Translator.translate(ctx, "try_another_word") != suggestion &&
        Translator.translate(ctx, "you_can_scroll") != suggestion;
    /*&&
        AddPlaceTagSearchDelegate.COINECTOR_SUPPORTS_MANY_LANGUAGES !=
            suggestion*/
  }
}
