import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  Map<String, dynamic> _data;
  String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  Localedrawer _drawer;
  Localedrawer get drawer => _drawer;
  Localeglobal _global;
  Localeglobal get global => _global;
  Localelogin _login;
  Localelogin get login => _login;
  Localenotes _notes;
  Localenotes get notes => _notes;
  Localevalidators _validators;
  Localevalidators get validators => _validators;

  void initAll() {
    _drawer = Localedrawer(Map<String, String>.from(_data['drawer']));
    _global = Localeglobal(Map<String, String>.from(_data['global']));
    _login = Localelogin(Map<String, String>.from(_data['login']));
    _notes = Localenotes(Map<String, String>.from(_data['notes']));
    _validators = Localevalidators(Map<String, String>.from(_data['validators']));
  }
}

class Localedrawer {
  final Map<String, String> _data;
  Localedrawer(this._data);

  
}
class Localeglobal {
  final Map<String, String> _data;
  Localeglobal(this._data);

  String get password => _data["password"];
  String get email => _data["email"];
  String get login => _data["login"];
  String get sign_up => _data["sign_up"];
  String get add => _data["add"];
  String get logout => _data["logout"];
  String get welcome => _data["welcome"];
  String get create => _data["create"];
  String get update => _data["update"];
  String get registered => _data["registered"];
}
class Localelogin {
  final Map<String, String> _data;
  Localelogin(this._data);

  String get login => _data["login"];
  String get password => _data["password"];
  String get invalid => _data["invalid"];
}
class Localenotes {
  final Map<String, String> _data;
  Localenotes(this._data);

  String get title => _data["title"];
  String get tags => _data["tags"];
  String get content => _data["content"];
}
class Localevalidators {
  final Map<String, String> _data;
  Localevalidators(this._data);

  String get required => _data["required"];
  String get invalid_format => _data["invalid_format"];
}
