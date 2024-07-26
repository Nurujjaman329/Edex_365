import 'package:flutter/widgets.dart';

import 'language-translation.dart';

class TranslationsDelegate extends LocalizationsDelegate<LanguageTranslation> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<LanguageTranslation> load(Locale locale) =>
      LanguageTranslation.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}