import 'package:flutter/material.dart';
import 'package:noteme/generated/locale_base.dart';

class NoteMeLocaleFactory {
  static LocaleBase of(BuildContext context) =>
      Localizations.of<LocaleBase>(context, LocaleBase);
}
