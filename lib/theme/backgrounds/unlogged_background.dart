import 'package:flutter/material.dart';

class UnloggedBackgroundBox extends StatelessWidget {
  final Widget child;

  UnloggedBackgroundBox({this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        child: this.child,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/unlogged_background.png'),
                fit: BoxFit.fill)));
  }
}
