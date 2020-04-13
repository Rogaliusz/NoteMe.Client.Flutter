import 'dart:ui';

import 'package:flutter/material.dart';

const Color primaryNoteMeColor = Color.fromRGBO(234, 241, 204, 1);
const Color accentNoteMeColor = Color.fromRGBO(78, 141, 149, 1);
const Color errorNoteMeColor = Color.fromARGB(234, 242, 204, 1);
const Color backgroundNoteMeColor = Color.fromRGBO(87, 78, 78, 1);

Map<int, Color> accentCodes = {
  50: Color.fromRGBO(78, 141, 149, .1),
  100: Color.fromRGBO(78, 141, 149, .2),
  200: Color.fromRGBO(78, 141, 149, .3),
  300: Color.fromRGBO(78, 141, 149, .4),
  400: Color.fromRGBO(78, 141, 149, .5),
  500: Color.fromRGBO(78, 141, 149, .6),
  600: Color.fromRGBO(78, 141, 149, .7),
  700: Color.fromRGBO(78, 141, 149, .8),
  800: Color.fromRGBO(78, 141, 149, .9),
  900: Color.fromRGBO(78, 141, 149, 1),
};

MaterialColor accentMaterialColor = MaterialColor(0xEAF1CC, accentCodes);
