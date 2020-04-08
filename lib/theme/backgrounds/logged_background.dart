import 'package:flutter/material.dart';

class LoggedBackgroundBox extends StatelessWidget {
  final Widget child;

  LoggedBackgroundBox({this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        child: this.child,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logged_background.png'),
                fit: BoxFit.fill)));
  }
}
