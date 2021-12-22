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
    if (index == "104") return "";

    try {
      return Tag.tagText.elementAt(int.parse(index));
    } catch (e) {
      print("INVALID TAG INDEX:" + index);
      return "";
    }
  }
}
