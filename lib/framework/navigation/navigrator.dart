import 'package:flutter/material.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';

class NoteMeNavigator {
  static push<T extends Widget>(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => getIt<T>()));
  }
}
