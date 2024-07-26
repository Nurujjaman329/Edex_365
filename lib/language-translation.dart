import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LanguageTranslation {
  final Locale locale;
  static Map<dynamic, dynamic> _localizedValues = {};

  LanguageTranslation(this.locale) {
    _localizedValues = {};
  }

  static LanguageTranslation? of(BuildContext context) {
    return Localizations.of<LanguageTranslation>(context, LanguageTranslation);
  }

  String value(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<LanguageTranslation> load(Locale locale) async {
    LanguageTranslation translations = LanguageTranslation(locale);
    String jsonContent =
    await rootBundle.loadString("assets/locale/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}