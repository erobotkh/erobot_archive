import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

// RETURN BUTTON PAD FOR CAR CONTROLLER PAGES
class CreatePadBtn extends StatelessWidget {
  final int btnIndex, screenNum;
  final toBluetooth;
  CreatePadBtn(this.btnIndex, this.screenNum, this.toBluetooth);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Hexcolor('c4c4c4'),
        child: InkWell(
          splashColor: Colors.black12,
          child: SizedBox(
            width: 55,
            height: 55,
            child: ReturnIcon(btnIndex, 55, screenNum),
          ),
          onTap: () {
            print(toBluetooth);
          },
        ),
      ),
    );
  }
}

// RETURN PAD BUTTON ICONS
class ReturnIcon extends StatelessWidget {
  final int index;
  final double widthBtn;
  final int screenNum;
  ReturnIcon(this.index, this.widthBtn, this.screenNum);

  @override
  Widget build(BuildContext context) {
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
}

// Discuss about Card on Homepage and Document page:
// Each card has 3 layer with with stack together:
// - 1st layer is image which is image return from imageBackground(); (Homepage only)
// - 2nd layer is background color with return from randBackground();
// - 3nd layer is flat button

// RETURN A BACKGROUND COLOR TO CARD
Widget randBackground(int index) {
  int cardIndex = index % 5;

  //LIST OF COLOR
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

Widget imageBackground(final int cardIndex) {
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
