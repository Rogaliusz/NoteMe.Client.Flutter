import 'package:flutter/material.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';

class NoteMeNavigator {
  static push<T extends Widget>(BuildContext context,
      {RouteSettings settings}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => getIt<T>(), settings: settings));
  }

  static pop<TResult>(BuildContext context, {TResult result}) {
    return Navigator.pop<TResult>(context, result);
  }

  static popUntil(BuildContext context, RoutePredicate predicate) {
    return Navigator.popUntil(context, predicate);
  }
}
