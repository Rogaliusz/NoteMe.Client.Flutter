import 'package:noteme/generated/locale_base.dart';

String requiredNoteMeValidator(LocaleBase localeBase, String value) {
  if (value.isEmpty) {
    return localeBase.validators.required;
  }
}
