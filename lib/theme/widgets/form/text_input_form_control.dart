import 'package:flutter/material.dart';
import 'package:noteme/theme/colors.dart';

class TextNoteMeInputFormControl extends StatelessWidget {
  String placeholder;
  Key key;
  String initialValue;
  FormFieldValidator<String> validator;
  FormFieldSetter<String> onSaved;
  TextInputType keyboardType;
  bool obscureText;

  TextNoteMeInputFormControl(
      {this.placeholder,
      this.keyboardType,
      this.key,
      this.initialValue,
      this.validator,
      this.onSaved,
      this.obscureText}) {}

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: this.key,
        decoration: InputDecoration(labelText: this.placeholder),
        initialValue: this.initialValue,
        onSaved: this.onSaved,
        keyboardType: this.keyboardType,
        obscureText: this.obscureText ?? false,
        validator: this.validator);
  }
}
