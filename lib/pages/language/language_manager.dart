import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class LanguageManager with ChangeNotifier {
  String getCurrentLocale(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    debugPrint('Locale: ${myLocale.languageCode}');
    return myLocale.languageCode;
  }

  LocaleType getLocaleType(String languageCode) {
    switch (languageCode) {
      case "en":
        return LocaleType.en;
      case "es":
        return LocaleType.es;
      case "ca":
        return LocaleType.cat;
      default:
        return LocaleType.en;
    }
  }
}
