import 'dart:ui';
export 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Palette {
  static Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  //0xAARRGGBB
  static MaterialColor appbar = MaterialColor(0xFF172634, color);
  static MaterialColor background = MaterialColor(0xFF161F28, color);

  static const Color shark = Color(0xFF161F28);
  static const Color bigstone = Color(0xFF172634);
  static const Color orange_burning = Color(0xFFe77e4e);
  static const Color red_milano = Color(0xFFb6142c);
  static const Color blue_pacific = Color(0xFF03a0b0);
  static const Color green_fun = Color(0xFF006f3c);
  static const Color yellow = Color(0xFFf9a73e);
  static const Color whitesmoke = Color(0xFFc4c4c4);
  static const Color blueSplash = Color(0xFF04bacd);
  static const Color blueFacebook = Color(0xFF386fde);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}
