import 'package:flutter/cupertino.dart';

enum LangCode { RU, AR, PT, CH, SL, HI, EN, DE, ES, FR, ID, IT, JA }

//static const COINECTOR_SUPPORTS_MANY_LANGUAGES =
// "🇪🇸 🇩🇪 🇫🇷 🇮🇹 🇬🇧 🇯🇵 🇮🇩";

class Localizer {
  static LangCode getLangCode(ctx) {
    Locale myLocale = Localizations.localeOf(ctx);
    final String countryCode = myLocale.toString();
    LangCode langCode = LangCode.values.firstWhere(
        (e) => e.toString() == 'LangCode.' + countryCode.toUpperCase());
    return langCode;
  }
}
