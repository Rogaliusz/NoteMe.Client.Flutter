import 'package:flutter/material.dart';

class TextNoteMeInput extends StatelessWidget {
  String _placeholder;
  Key _key;
  String _initialValue;
  FormFieldValidator<String> _validator;

  TextNoteMeInput({
    String placeholder,
    Key key,
    String initialValue,
    FormFieldValidator<String> validator,
  }) {
    this._placeholder = placeholder;
    this._key = key;
    this._initialValue = initialValue;
    this._validator = validator;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(validator: this._validator);
  }
}
