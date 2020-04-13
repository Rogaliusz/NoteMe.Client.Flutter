import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
