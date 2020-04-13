import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
