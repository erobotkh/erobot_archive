import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart';
import 'main_drawer.dart';
import 'package:erobot_app/screens/supplier/widget_supplier.dart';

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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Builder(
                  builder: (context) => IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.alignLeft,
                        size: 20,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer())),
            ),
            title: Text(
              'E-Robot',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  heartIcon(),
                  color: Colors.white,
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  randomNum = listNum[Random().nextInt(listNum.length)];
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomeScreen(),
                          duration: Duration(milliseconds: 1000),
                          type: PageTransitionType.fade));
                },
              )
            ],
          ),
          drawer: MainDrawer(),
          body: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: <Widget>[
              buildBtn('Arduino Documents', 'Learn how to build a robot', 0,
                  context),
              buildBtn('Sender', 'to Send text to arduino via Bluetooth', 1,
                  context),
              buildBtn(
                  'Ball Shooter',
                  'to Control ball shooter arduino car, servo, and speed',
                  2,
                  context),
              buildBtn('Arduino Car',
                  'Remoter to Control Arduino Car with speed', 3, context),
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
          )),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Color(0xFF161F28),
            title: Text(
              'Are you sure?',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: _dialogBtn('No'),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: _dialogBtn('Yes'),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ) ??
        false;
  }
}

Widget _dialogBtn(String yRN) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Text(
      yRN,
      style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16),
    ),
  );
}
