import 'Tag.dart';

class TagParser {
  static String parseTagIndexToText(List<String> splittedtags) {
    return parseElementAt(splittedtags, 0) +
        parseElementAt(splittedtags, 1) +
        parseElementAt(splittedtags, 2) +
        parseElementAt(splittedtags, 3);
  }

  static String parseElementAt(splittedTags, int pos) {
    var tagIndex = splittedTags.elementAt(pos);

    String addSeparator = "";
    if (pos != 0) addSeparator = "   ";

    return addSeparator + parseTag(tagIndex);
  }

  static String parseTag(index) {
    int tagIndex = int.parse(index);

    if (tagIndex == 104) return "";

    return Tag.tagText.elementAt(tagIndex);
  }
}
