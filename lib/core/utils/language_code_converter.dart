import 'dart:ui';

String LanguageCodeConverter({required String langCode}) {
  switch (langCode) {
    case 'en':
      return 'English';
    case 'ru':
      return 'Russian - Русский';
    case 'vi':
      return 'Vietnamese - Tiếng Việt';
    default:
      return 'Unknown';
  }
}
