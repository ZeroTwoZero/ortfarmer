import 'package:flutter/material.dart';

const grayColor = Color(0xFF527780);
const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF000000);
const redColor = Color(0xFFFF0000);
const greenColor = Color(0xFF1DCD9F);
const blueColor = Color(0xFF1B60E2);
const yellowColor = Color(0xFFF3B718);
const transparentColor = Colors.transparent;
const pinkColor = Color(0xFFF0014F);
const darkBlueColor = Color(0xFF201355);
const brickColor = Color(0xFFFD6470);
const violetColor = Color(0xFFC47CFC);

//base material color
const Map<int, Color> materialBaseColor = {
  50: Color.fromRGBO(251, 72, 72, .1),
  100: Color.fromRGBO(251, 72, 72, .2),
  200: Color.fromRGBO(251, 72, 72, .3),
  300: Color.fromRGBO(251, 72, 72, .4),
  400: Color.fromRGBO(251, 72, 72, .5),
  500: Color.fromRGBO(251, 72, 72, .6),
  600: Color.fromRGBO(251, 72, 72, .7),
  700: Color.fromRGBO(251, 72, 72, .8),
  800: Color.fromRGBO(251, 72, 72, .9),
  900: Color.fromRGBO(251, 72, 72, 1),
};
MaterialColor baseMaterialColor =
    const MaterialColor(0xFFFB4848, materialBaseColor);

// material white color
const Map<int, Color> materialWhiteColor = {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
};
const MaterialColor whiteMaterialColor =
    MaterialColor(0xFFFFFFFF, materialWhiteColor);

// material white color
const Map<int, Color> materialGreenColor = {
  50: Color.fromRGBO(29, 205, 159, .1),
  100: Color.fromRGBO(29, 205, 159, .2),
  200: Color.fromRGBO(29, 205, 159, .3),
  300: Color.fromRGBO(29, 205, 159, .4),
  400: Color.fromRGBO(29, 205, 159, .5),
  500: Color.fromRGBO(29, 205, 159, .6),
  600: Color.fromRGBO(29, 205, 159, .7),
  700: Color.fromRGBO(29, 205, 159, .8),
  800: Color.fromRGBO(29, 205, 159, .9),
  900: Color.fromRGBO(29, 205, 159, 1),
};
const MaterialColor greenMaterialColor =
    MaterialColor(0xFF1DCD9F, materialGreenColor);
