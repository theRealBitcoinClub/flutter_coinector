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
    emojis = await _loadEmojisFromFile();

    LangCode.values.forEach((LangCode lang) async {
      tagsCached[lang.name.toLowerCase()] = await _loadTagsFromFile(lang);
    });
  }

  static List<String> emojis = [];

  static Future<List<String>> _loadEmojisFromFile() async {
    if (emojis.isNotEmpty) return emojis;

    try {
      String input = await AssetLoader.loadString('assets/tags/emoji.csv');
      List<List<dynamic>> rowsAsListOfValues = getValuesList(input);

      List<String> allItems = [];
      rowsAsListOfValues[0].forEach((item) {
        allItems.add(item.toString());
      });
      //ImportData(githubCoinector).printSuggestions(allSuggestions, continent);
      return allItems;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static List<List<dynamic>> getValuesList(String input) {
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(input, fieldDelimiter: "\n");
    return rowsAsListOfValues;
  }

  static Future<List<String>> _loadTagsFromFile(LangCode lang) async {
    try {
      String input = await AssetLoader.loadString(
          'assets/tags/tags_' + lang.name.toLowerCase() + '.csv');
      List<List<dynamic>> rowsAsListOfValues = getValuesList(input);

      int index = 0;
      List<String> allItems = [];
      rowsAsListOfValues[0].forEach((item) {
        String emoji = emojis.elementAt(index++);
        allItems.add(item.toString() + " " + emoji);
      });
      //ImportData(githubCoinector).printSuggestions(allSuggestions, continent);
      return allItems;
    } catch (e) {
      print(e.toString());
      throw e;
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
      var key = Localizer.getLangCode(ctx).name.toLowerCase();
      return tagsCached[key]!.elementAt(i);
    } catch (e) {
      debugPrint(e.toString());
      print("INVALID TAG INDEX:" + index);
      return "";
    }
  }

  static List<String>? getTagsByLangCode(LangCode lang) {
    return tagsCached[lang.name.toLowerCase()];
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

  static TagCoinector? findTag(String searchTerm) {
    TagCoinector? result=null;
    LangCode.values.forEach((LangCode lang) {
      result = _findTagIndex(searchTerm, tagsCached[lang.name.toLowerCase()]!);
    });

    return result;
  }

  static TagCoinector? _findTagIndex(String searchTerm, List<String> tags) {
    print("START: _findTagIndex:");
    var search = searchTerm.trim().split(" ")[0].toLowerCase();
    print(
        "_findTagIndex 2"); //TODO freesearch on bmap doesnt match the tag but on coinector it does
    for (int i = 0; i < tags.length; i++) {
      String tagItem = tags.elementAt(i);
      List<String> splittedTag = tagItem.split(" ");
      String itemText = splittedTag[0].toLowerCase();
      if (itemText == search) {
        // if (!kReleaseMode)
        print("TAG FOUND: " + tagItem + " index:" + i.toString());
        return TagCoinector(
            i, splittedTag[0], splittedTag.length > 1 ? splittedTag[1] : "🔎");
      }
    }
    return null;
  }

  static String fallbackToEN(String t, int i) {
    if (t.startsWith("🍔🍔🍔"))
      return tagsCached[LangCode.EN.name.toLowerCase()]!.elementAt(i);
    return t;
  }
}
