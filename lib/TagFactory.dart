import 'package:Coinector/Localizer.dart';

import 'TagCoinector.dart';

class TagFactory {
  static Map<String, Set<TagCoinector>> _tagz = Map();

  static Set<TagCoinector> getTags(ctx, {LangCode? lang}) {
    if (lang == null) lang = Localizer.getLangCode(ctx);
    var langISO = lang.name.toLowerCase();
    var tagz = _tagz[langISO];
    if (tagz == null) tagz = _createTags(lang);
    return tagz;
  }

  /*
  Input an (ISO 639-1) language code and get a set of tags in return
  That list is being parsed from a .json file later on, currently its still inside the Tag.dart file as static array
   */

  static Set<TagCoinector> _createTags(LangCode lang) {
    Set<TagCoinector> tags = _createTagsFromRaw(TagCoinector.getTagsByLangCode(lang)!);
    if (lang != LangCode.EN) //add english tags as default
      tags.addAll(
          _createTagsFromRaw(TagCoinector.getTagsByLangCode(LangCode.EN)!));
    return tags;
  }

  static Set<TagCoinector> _createTagsFromRaw(List<String> rawTags) {
    Set<TagCoinector> tags = {};
    int index = 0;
    for (String rawTag in rawTags) {
      if (rawTag != null && rawTag.isNotEmpty) {
        // if (!kReleaseMode) print("\n" + rawTag);
        List<String> splittedTag = rawTag.split(" ");
        tags.add(TagCoinector(index++, splittedTag[0],
            splittedTag.length > 1 ? splittedTag[1] : ""));
      }
    }
    return tags;
  }
}
