import 'package:flutter/material.dart';
import 'package:noteme/theme/styles/text_styles.dart';
import 'package:noteme/theme/widgets/title_text.dart';

class TextNoteMeButton extends StatelessWidget {
  String _text;
  @required
  VoidCallback _onPressed;

  TextNoteMeButton({
    String text,
    @required VoidCallback onPressed,
  }) {
    this._text = text;
    this._onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: this._onPressed,
        child: Text(this._text, style: TitleNoteMeTextStyle));
  }
}
