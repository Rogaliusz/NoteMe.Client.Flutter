import 'package:flutter/cupertino.dart';
import 'package:noteme/theme/styles/text_styles.dart';

import '../colors.dart';

class PrimaryText extends StatelessWidget {
  String text;
  double size;
  TextAlign textAlign;

  PrimaryText(String text, double size, {this.textAlign}) {
    this.text = text;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
        textAlign: this.textAlign,
        style: TextStyle(color: primaryNoteMeColor, fontSize: this.size));
  }
}
