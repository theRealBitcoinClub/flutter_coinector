// Identifier a

import 'package:Coinector/AssetLoader.dart';
import 'package:Coinector/Localizer.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TagCoinector {
  //TODO TRANSLATE ENG TAGS IN ALL LANGUAGES AND ADD EMOTICON TO SPANISH
  static const String PLACEHOLDER_TAG = "104";
  static const int MAX_INPUT_TAGS = 4;
  final String text;
  final String emoji;
  final int id;

  TagCoinector(this.id, this.text, this.emoji);

  static Map<String, List<String>> tagsCached = Map();

  static initFromFiles() async {
    LangCode.values.forEach((LangCode lang) async {
      tagsCached[lang.name.toLowerCase()]= await _loadTagsFromFile(lang);
    });
  }

  static Future<List<String>> _loadTagsFromFile(
      LangCode lang) async {
    try {
      String input =
      await AssetLoader.loadString('assets/tags/tags_' + lang.name.toLowerCase() + '.csv');
      List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(input);

      List<String> allItems = [];
      rowsAsListOfValues[0].forEach((item) {
          allItems.add(item.toString());
      });
      //ImportData(githubCoinector).printSuggestions(allSuggestions, continent);
      return allItems;
    } catch (e) {
      print(e.toString());
    }
  }

  String toUI() {
    return text.toUpperCase() + " " + emoji;
  }

  String toString() {
    return id.toString() + text + emoji;
  }

  static String parseTagIndexToText(ctx, List<String> splittedtags) {
    return parseElementAt(ctx, splittedtags, 0) +
        parseElementAt(ctx, splittedtags, 1) +
        parseElementAt(ctx, splittedtags, 2) +
        parseElementAt(ctx, splittedtags, 3);
  }

  static String parseElementAt(ctx, splittedTags, int pos) {
    var tagIndex = splittedTags.elementAt(pos);

    String addSeparator = "";
    if (pos != 0) addSeparator = "   ";

    return addSeparator + parseTag(ctx, tagIndex);
  }

  static String parseTag(BuildContext ctx, String index) {
    if (index == PLACEHOLDER_TAG) return "";

    try {
      var i = int.parse(index);
      switch (Localizer.getLangCode(ctx)) {
        case LangCode.DE:
          return fallbackToEN(TagCoinector.tagTextDE.elementAt(i), i);
        case LangCode.ES:
          return fallbackToEN(TagCoinector.tagTextES.elementAt(i), i);
        case LangCode.FR:
          return fallbackToEN(TagCoinector.tagTextFR.elementAt(i), i);
        case LangCode.ID:
          return fallbackToEN(TagCoinector.tagTextINDONESIA.elementAt(i), i);
        case LangCode.JA:
          return fallbackToEN(TagCoinector.tagTextJP1.elementAt(i), i);
        case LangCode.IT:
          return fallbackToEN(TagCoinector.tagTextIT.elementAt(i), i);
        default:
          return TagCoinector.tagTextEN.elementAt(i);
      }
    } catch (e) {
      debugPrint(e.toString());
      print("INVALID TAG INDEX:" + index);
      return "";
    }
  }

  static String parseTagsToDatabaseFormat(Set<TagCoinector> inputTags) {
    String r = inputTags.toString();
    String results = inputTags == null || inputTags.isNotEmpty
        ? r.substring(1, r.length - 1)
        : PLACEHOLDER_TAG +
            "," +
            PLACEHOLDER_TAG +
            "," +
            PLACEHOLDER_TAG +
            "," +
            PLACEHOLDER_TAG;
    /*if (inputTags.length < TagCoinector.MAX_INPUT_TAGS)
      results = TagCoinector.appendPlaceholderTags(results);*/
    return results;
  }

  static String buildJsonTag(TagCoinector tag) {
    return '{"tag":"' + tag.text + '", "id":"' + tag.id.toString() + '"}';
  }

  static String appendPlaceholderTags(String results) {
    for (var i = results.split(",").length; i < MAX_INPUT_TAGS; i++) {
      results += ",104";
    }
    return results;
  }

  static TagCoinector findTag(String searchTerm) {
    TagCoinector result;
    if ((result = _findTagIndex(searchTerm, TagCoinector.tagTextEN)) ==
        null) if ((result = _findTagIndex(searchTerm, TagCoinector.tagTextES)) == null) if ((result =
            _findTagIndex(searchTerm, TagCoinector.tagTextDE)) ==
        null) if ((result = _findTagIndex(searchTerm, TagCoinector.tagTextFR)) == null) if ((result =
            _findTagIndex(searchTerm, TagCoinector.tagTextES)) ==
        null) if ((result = _findTagIndex(searchTerm, TagCoinector.tagTextDE)) == null) if ((result =
            _findTagIndex(searchTerm, TagCoinector.tagTextFR)) ==
        null) if ((result =
            _findTagIndex(searchTerm, TagCoinector.tagTextIT)) ==
        null) if ((result =
            _findTagIndex(searchTerm, TagCoinector.tagTextINDONESIA)) ==
        null) result = _findTagIndex(searchTerm, TagCoinector.tagTextJP1);

    return result;
  }

  static TagCoinector _findTagIndex(String searchTerm, List<String> tags) {
    for (int i = 0; i < tags.length; i++) {
      String item = tags.elementAt(i);
      if (item.toLowerCase().startsWith(searchTerm.toLowerCase())) {
        if (!kReleaseMode)
          print("TAG FOUND:" + item + " index:" + i.toString());
        List<String> splittedTag = item.split(" ");
        return TagCoinector(
            i, splittedTag[0], splittedTag.length > 1 ? splittedTag[1] : "");
      }
    }
    return null;
  }

  //Only if the tag is totally unused, that means there are zero results when searching inside the app, then it can be replaced by another tag

  static List<String> tagTextEN = [];
  static List<String> tagTextJP1 = [];
  static List<String> tagTextINDONESIA = [];
  static List<String> tagTextIT = [];
  static List<String> tagTextFR = [];
  static List<String> tagTextES = [];
  static List<String> tagTextDE = [];

  static String fallbackToEN(String t, int i) {
    if (t.startsWith("🍔🍔🍔")) return TagCoinector.tagTextEN.elementAt(i);
    return t;
  }
}
