import 'package:Coinector/Localizer.dart';

import 'Tag.dart';

class TagFactory {
  static Set<Tag> _tagz;
  static LangCode _lastLangCode;

  static Set<Tag> getTags(ctx, {LangCode lang}) {
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

  static Set<Tag> _createTags(LangCode lang) {
    Set<Tag> tags = {};
    Set<String> rawTags = _getRawTags(lang);
    int index = 0;
    for (String rawTag in rawTags) {
      List<String> splittedTag = rawTag.split(" ");
      tags.add(Tag(index++, splittedTag[0],
          splittedTag.length > 0 ? splittedTag[1] : ""));
    }
    return tags;
  }

  static Set<String> _getRawTags(LangCode lang) {
    Set<String> rawTags = {};

    switch (lang) {
      case LangCode.EN:
        rawTags = Tag.tagTextEN;
        break;
      case LangCode.DE:
        rawTags = Tag.tagTextDE;
        break;
      case LangCode.IT:
        rawTags = Tag.tagTextIT;
        break;
      case LangCode.FR:
        rawTags = Tag.tagTextFR;
        break;
      case LangCode.ES:
        rawTags = Tag.tagTextES;
        break;
      case LangCode.ID:
        rawTags = Tag.tagTextINDONESIA;
        break;
      case LangCode.JA:
        rawTags = Tag.tagTextJP1;
        rawTags.addAll(Tag.tagTextJP1);
        break;
      default:
        rawTags = Tag.tagTextEN;
        print("ERROR LANGUAGE CODE NOT FOUND");
        break;
    }
    return rawTags;
  }
}
