// RETURN PAD BUTTON ICONS
import 'package:erobot_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReturnIcon extends StatelessWidget {
  final int index;
  final double widthBtn;
  final int screenNum;
  ReturnIcon(
    this.index,
    this.widthBtn,
    this.screenNum,
  );

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
        color: screenNum == 1 ? Palette.red_milano : Palette.blue_pacific,
      ),
    );
  }
}
