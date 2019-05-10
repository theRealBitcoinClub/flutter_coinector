import 'Tags.dart';

class TagParser {
  static String parseTagIndexToText(List<String> splittedtags) {
    return parseElementAt(splittedtags, 0) +
        parseElementAt(splittedtags, 1) +
        parseElementAt(splittedtags, 2) +
        parseElementAt(splittedtags, 3);
  }

  static String parseElementAt(splittedTags, int pos) {
    int tagIndex = int.parse(splittedTags.elementAt(pos));

    if (tagIndex == 104) return "";

    String addSeparator = "";
    if (pos != 0) addSeparator = "   ";

    return addSeparator + Tags.tagText.elementAt(tagIndex);
  }
}