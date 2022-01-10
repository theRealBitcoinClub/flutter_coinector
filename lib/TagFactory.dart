import 'package:Coinector/Localizer.dart';
import 'package:flutter/foundation.dart';

import 'TagCoinector.dart';

class TagFactory {
  static Set<TagCoinector> _tagz;
  static LangCode _lastLangCode;

  static Set<TagCoinector> getTags(ctx, {LangCode lang}) {
    LangCode currentLangCode = Localizer.getLocale(ctx);
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
    Set<TagCoinector> tags = {};
    Set<String> rawTags = _getRawTags(lang);
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

  static Set<String> _getRawTags(LangCode lang) {
    Set<String> rawTags = {};

    switch (lang) {
      case LangCode.EN:
        rawTags = TagCoinector.tagTextEN;
        break;
      case LangCode.DE:
        rawTags = TagCoinector.tagTextDE;
        break;
      case LangCode.IT:
        rawTags = TagCoinector.tagTextIT;
        break;
      case LangCode.FR:
        rawTags = TagCoinector.tagTextFR;
        break;
      case LangCode.ES:
        rawTags = TagCoinector.tagTextES;
        break;
      case LangCode.ID:
        rawTags = TagCoinector.tagTextINDONESIA;
        break;
      case LangCode.JA:
        rawTags = TagCoinector.tagTextJP1;
        rawTags.addAll(TagCoinector.tagTextJP1);
        break;
      default:
        rawTags = TagCoinector.tagTextEN;
        print("ERROR LANGUAGE CODE NOT FOUND");
        break;
    }
    return rawTags;
  }
}
