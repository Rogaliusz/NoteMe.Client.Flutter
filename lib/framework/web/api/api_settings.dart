import 'package:injectable/injectable.dart';

@injectable
class ApiSettings {
  String address = 'http://51.38.131.197:70/api/';
  String token;
}
