import 'package:injectable/injectable.dart';
import 'injection.iconfig.dart';

@injectableInit
void configureInjection(String envoiremnt) => 
    $initGetIt(environment: envoiremnt);

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}