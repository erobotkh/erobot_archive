import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double widthBtn = 55;
const double heightBtn = 55;
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

// ignore: must_be_immutable
class CreatePadBtn extends StatelessWidget {
  //For car controller page
  int btnIndex;
  double widthBtn;
  double heightBtn;
  int screenNum;
  CreatePadBtn(this.btnIndex, this.widthBtn, this.heightBtn, this.screenNum);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Hexcolor('c4c4c4'),
        child: InkWell(
          splashColor: Colors.black12,
          child: SizedBox(
            width: widthBtn,
            height: heightBtn,
            child: ReturnIcon(btnIndex, widthBtn, screenNum),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReturnIcon extends StatelessWidget {
  int index;
  double widthBtn;
  int screenNum;
  var icon;
  ReturnIcon(this.index, this.widthBtn, this.screenNum);

  @override
  Widget build(BuildContext context) {
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
}

Widget randBackground(int index) {
  int cardIndex = index % 5;
  var list = [
    '0_111_60.png',
    '249_167_62.png',
    '182_20_44.png',
    '3_160_176.png',
    '231_126_78.png',
  ];

  String indexColor = list[cardIndex];
  var color1 = [0, 111, 60];
  var color2 = [249, 167, 62];
  var color3 = [182, 20, 44];
  var color4 = [3, 160, 176];
  var color5 = [231, 126, 78];

  var colorRGBO;

  if (cardIndex == 0) colorRGBO = color1;
  if (cardIndex == 1) colorRGBO = color2;
  if (cardIndex == 2) colorRGBO = color3;
  if (cardIndex == 3) colorRGBO = color4;
  if (cardIndex == 4) colorRGBO = color5;

  return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/colors/$indexColor',
        fit: BoxFit.cover,
        color: Color.fromRGBO(colorRGBO[0], colorRGBO[1], colorRGBO[2], 0.8),
        colorBlendMode: BlendMode.modulate,
      ));
}

// ignore: non_constant_identifier_names
Widget ImageBackground(int cardIndex) {
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
