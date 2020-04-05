import 'package:flutter/material.dart';
import 'package:noteme/generated/locale_base.dart';

class LocDelegate extends LocalizationsDelegate<LocaleBase> {
  const LocDelegate();

  final maps = const  {
    'en': 'locales/EN-us.json',
    'pl': 'locales/PL-pl.json',
  };

  @override
  bool isSupported(Locale locale) => 
    ['pl', 'en'].contains(locale.languageCode);

  @override
  Future<LocaleBase> load(Locale locale) async {
    var lang = 'en';

    if (isSupported(locale)) {
      lang = locale.languageCode;
    }

    final loc = new LocaleBase();
    await loc.load(maps[lang]);

    return loc;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocaleBase> old) 
    => false;
}