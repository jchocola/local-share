import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:local_share/core/extension/wiredash_ru.dart';
import 'package:local_share/core/extension/wiredash_vi.dart';
import 'package:wiredash/assets/l10n/wiredash_localizations.g.dart';
import 'package:wiredash/assets/l10n/wiredash_localizations_en.g.dart';

class CustomWiredashTranslationsDelegate
    extends LocalizationsDelegate<WiredashLocalizations> {
  const CustomWiredashTranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    /// You have to define all languages you want your delegate to support
    /// Klingon == tlh
    return ['vi', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<WiredashLocalizations> load(Locale locale) {
    switch (locale.languageCode) {
      case 'vi':
        // Replace some text to better address your users
        return SynchronousFuture(WiredashLocalizationsVietnamese());
      case 'ru':
        // Replace some text to better address your users
        return SynchronousFuture(WiredashLocalizationsRussian());
      default:
        throw "Unsupported locale $locale";
    }
  }

  @override
  bool shouldReload(CustomWiredashTranslationsDelegate old) => false;
}



