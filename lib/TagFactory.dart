import 'package:Coinector/Localizer.dart';
import 'package:flutter/foundation.dart';

import 'TagCoinector.dart';

class TagFactory {
  static Set<TagCoinector> _tagz;
  static LangCode _lastLangCode;

  static Set<TagCoinector> getTags(ctx, {LangCode lang}) {
    LangCode currentLangCode = Localizer.getLangCode(ctx);
    if (_tagz == null || currentLangCode != _lastLangCode)
      _tagz = _createTags(lang != null ? lang : currentLangCode);

    _lastLangCode = currentLangCode;
    return _tagz;
  }

  /*
  Input an (ISO 639-1) language code and get a set of tags in return
  That list is being parsed from a .json file later on, currently its still inside the Tag.dart file as static array
   */

  static Set<TagCoinector> _createTags(LangCode lang) {
    Set tags = _createTagsFromRaw(TagCoinector.getTagsByLangCode(lang));
    if (lang != LangCode.EN) //add english tags as default
      tags.addAll(
          _createTagsFromRaw(TagCoinector.getTagsByLangCode(LangCode.EN)));
    return tags;
  }

  static Set<TagCoinector> _createTagsFromRaw(List<String> rawTags) {
    Set<TagCoinector> tags = {};
    int index = 0;
    for (String rawTag in rawTags) {
      if (rawTag != null && rawTag.isNotEmpty) {
        if (!kReleaseMode) print("\n" + rawTag);
        List<String> splittedTag = rawTag.split(" ");
        tags.add(TagCoinector(index++, splittedTag[0],
            splittedTag.length > 1 ? splittedTag[1] : ""));
      }
    }
    return tags;
  }
}
