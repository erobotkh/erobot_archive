import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double widthBtn = 55;
double heightBtn = 55;
double speed = 5;
double speedTMP = 5;
double servo = 5;
var bltBtn1; //this will send to arduino
var bltBtn2;
var bltBtn3;
var bltBtn4;

bool isConnected = false;

IconData isConnect() {
  if (isConnected) {
    isConnected = false;
    return Icons.bluetooth_connected;
  } else {
    isConnected = false;
    return Icons.bluetooth_disabled;
  }
}

ClipOval createPadBtn(
    int btnIndex, double widthBtn, double heightBtn, int screenNum) {
  return ClipOval(
    child: Material(
      color: Hexcolor('c4c4c4'),
      child: InkWell(
        splashColor: Colors.black12,
        child: SizedBox(
          width: widthBtn,
          height: heightBtn,
          child: returnIcon(btnIndex, widthBtn, screenNum),
        ),
        onTap: () {},
      ),
    ),
  );
}

Center returnIcon(int index, double widthBtn, int screenNum) {
  var icon;
  if (index == 1) icon = FontAwesomeIcons.angleUp;
  if (index == 2) icon = FontAwesomeIcons.angleLeft;
  if (index == 3) icon = FontAwesomeIcons.angleRight;
  if (index == 4) icon = FontAwesomeIcons.angleDown;
  return Center(
      child: FaIcon(
    icon,
    size: widthBtn - 20,
    color: screenNum == 1 ? Hexcolor('B6142C') : Hexcolor('03A0B0'),
  ));
}
