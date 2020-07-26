//import 'package:erobot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:page_transition/page_transition.dart';
//import 'package:control_pad/control_pad.dart';
class BallShooter extends StatefulWidget {
  BallShooter({Key key}) : super(key: key);

  @override
  _BallShooterState createState() => _BallShooterState();
}

class _BallShooterState extends State<BallShooter> {
  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  double widthBtn = 55;
  double heightBtn = 55;

  var bltBtn1; //this will send to arduino
  var bltBtn2;
  var bltBtn3;
  var bltBtn4;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 31, 40, 1),
          title: Text(
            'Ball Shooter',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          flexibleSpace: Image(
            image: AssetImage('assets/ball_appBar.png'),
            fit: BoxFit.fill,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(isConnect()),
                onPressed: () {
                  if (!isConnected)
                    isConnected = true;
                  else
                    isConnected = false;
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: BallShooter(),
                          duration: Duration(milliseconds: 1000),
                          type: PageTransitionType.fade));
                })
          ],
          elevation: 0.0,
        ),
        body: Container(
          width: 250,
          color: Colors.red,
          height: 240,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createPadBtn(1),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      createPadBtn(2),
                      SizedBox(
                        width: widthBtn,
                      ),
                      createPadBtn(3),
                    ]),
                createPadBtn(4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ClipOval createPadBtn(int btnIndex) {
    return ClipOval(
      child: Material(
        color: Hexcolor('c4c4c4'),
        child: InkWell(
          splashColor: Colors.black12,
          child: SizedBox(
            width: widthBtn,
            height: heightBtn,
            child: returnIcon(btnIndex),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Center returnIcon(int index) {
    var icon;
    if (index == 1) icon = FontAwesomeIcons.angleUp;
    if (index == 2) icon = FontAwesomeIcons.angleLeft;
    if (index == 3) icon = FontAwesomeIcons.angleRight;
    if (index == 4) icon = FontAwesomeIcons.angleDown;
    return Center(
        child: FaIcon(
      icon,
      size: widthBtn - 20,
      color: Hexcolor('B6142C'),
    ));
  }
}

bool isConnected = false;

IconData isConnect() {
  if (isConnected) {
    isConnected = false;
    return Icons.bluetooth_connected;
  } else {
    isConnected = true;
    return Icons.bluetooth_disabled;
  }
}
