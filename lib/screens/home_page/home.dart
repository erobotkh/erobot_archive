//import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:hexcolor/hexcolor.dart';
//import 'package:page_transition/page_transition.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart';
//import 'main_drawer.dart';
import 'package:erobot_app/screens/supplier/widget_supplier.dart';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';

// import '../arduino_doc/arduino_doc.dart';
// import '../drawer_bar/aboutus.dart';
// import '../login_page/log_choice.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          children: <Widget>[
            buildBtn(
                'Farm Assistant', 'Make your farming smarter', 0, context),
            buildBtn(
                'Sender', 'to Send text to arduino via Bluetooth', 1, context),
            buildBtn(
                'Ball Shooter',
                'to Control ball shooter arduino car, servo, and speed',
                2,
                context),
            buildBtn('Arduino Car', 'Remoter to Control Arduino Car with speed',
                3, context),
            buildBtn('IR Remoter', 'to Control Light and Buzzer Arduino', 4,
                context),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
          ],
        ),
    );
  }
}
