import 'package:flutter/material.dart';
import 'package:noteme/theme/colors.dart';

class PrimaryIcon extends StatelessWidget {
  final IconData icon;

  PrimaryIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(this.icon, color: primaryNoteMeColor);
  }
}
