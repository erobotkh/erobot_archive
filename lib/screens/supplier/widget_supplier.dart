import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
//import 'package:page_transition/page_transition.dart';
//import 'package:erobot_app/screens/arduino_doc/arduino_doc.dart';
//import 'package:erobot_app/main.dart';
//import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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

var listNum = [0, 1, 2, 3, 4];
int randomNum = listNum[Random().nextInt(listNum.length)];
bool favoriteC = true;

IconData heartIcon() {
  if (favoriteC) {
    favoriteC = false;
    return Icons.favorite;
  } else {
    favoriteC = true;
    return Icons.favorite_border;
  }
}

// ignore: non_constant_identifier_names
Widget RandBackground() {
  randomNum++;
  if (randomNum > 4) randomNum = 0;
  var list = [
    '231_126_78.png',
    '249_167_62.png',
    '0_111_60.png',
    '3_160_176.png',
    '182_20_44.png',
  ];
  String randomColor = list[randomNum];
  var color1 = [231, 126, 78];
  var color2 = [249, 167, 62];
  var color3 = [0, 111, 60];
  var color4 = [3, 160, 176];
  var color5 = [182, 20, 44];
  var colorRGBO;

  if (randomNum == 0) colorRGBO = color1;
  if (randomNum == 1) colorRGBO = color2;
  if (randomNum == 2) colorRGBO = color3;
  if (randomNum == 3) colorRGBO = color4;
  if (randomNum == 4) colorRGBO = color5;

  return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/colors/$randomColor',
        fit: BoxFit.cover,
        color: Color.fromRGBO(colorRGBO[0], colorRGBO[1], colorRGBO[2], 0.8),
        colorBlendMode: BlendMode.modulate,
      ));
}

// ignore: non_constant_identifier_names
Widget _ImageBackground(int cardIndex) {
  if (cardIndex == 0)
    return Image.asset('assets/home/arduino_doc.png', fit: BoxFit.cover);
  if (cardIndex == 1)
    return Image.asset('assets/home/our_team.png', fit: BoxFit.cover);
  if (cardIndex == 2)
    return Image.asset('assets/home/ball_shooter.png', fit: BoxFit.cover);
  if (cardIndex == 3)
    return Image.asset('assets/home/car_runner.png', fit: BoxFit.cover);
  else
    return Image.asset(
      'assets/home/ir_controller.png',
      fit: BoxFit.cover,
    );
}

Widget buildBtn(
    String title, String desription, int cardIndex, BuildContext context) {
  String pathlogo = 'mdi_bluetooth.png';
  double widtht = 15;
  double heightt = 20;
  double boxSizz = 10;
  if (cardIndex == 0) {
    boxSizz = 0;
    widtht = 30;
    heightt = 35;
    pathlogo = 'arduino_logo.png';
  }
  return Container(
    child: Padding(
        padding: cardIndex == 0
            ? EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0)
            : cardIndex.isEven
                ? EdgeInsets.fromLTRB(5.0, 0.0, 18.0, 10.0)
                : EdgeInsets.fromLTRB(18.0, 0.0, 5.0, 10.0),
        child: Stack(children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _ImageBackground(cardIndex),
            ),
          ),
          Positioned.fill(
            child: RandBackground(),
          ),
          Positioned.fill(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              onPressed: () {
                String routeP;
                if (cardIndex == 0) routeP = '/farm_assistant';
                if (cardIndex == 1) routeP = '/sender';
                if (cardIndex == 2) routeP = '/shooter';
                if (cardIndex == 3) routeP = '/ard_car';
                if (cardIndex == 4) routeP = '/ir_remote';
                Navigator.pushNamed(context, routeP);
              },
              splashColor: Color.fromRGBO(255, 255, 255, .2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .7),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        desription,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            letterSpacing: .5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/$pathlogo',
                      width: widtht, height: heightt),
                  SizedBox(
                    height: boxSizz,
                  )
                ],
              ),
            ),
          )
        ])),
  );
}
