import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/models/jwt_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@lazySingleton
class ApiSettings {
  SharedPreferences _sharedPreferences;
  String _jwtKey = 'jwt';

  Jwt _loggedUser;
  Jwt get loggedUser {
    if (_loggedUser != null) {
      return _loggedUser;
    }

    var jsonSerialized = _sharedPreferences.get(_jwtKey) as String;
    if (jsonSerialized != null && jsonSerialized.isNotEmpty) {
      _loggedUser = Jwt.fromJson(json.decode(jsonSerialized));
    }

    return _loggedUser;
  }

  set loggedUser(Jwt value) {
    _loggedUser = value;

    var jsonSerialized = json.encode(value.toJson());
    _sharedPreferences.setString(_jwtKey, jsonSerialized);
  }

  String address = 'http://51.38.131.197:70/api/';

  ApiSettings() {
    loadPreferences();
  }

  void loadPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
