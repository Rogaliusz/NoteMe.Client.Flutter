import 'package:flutter/material.dart';
import 'package:noteme/theme/styles/text_styles.dart';

import '../colors.dart';

class TitleNoteMeText extends StatelessWidget {
  String _text;

  TitleNoteMeText({String text}) {
    this._text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(this._text, style: TitleNoteMeTextStyle);
  }
}
