//import 'package:erobot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 31, 40, 1),
        title: Text(
          'Ball Shooter',
          style: TextStyle(
              fontFamily: 'Raleway', fontWeight: FontWeight.w500, fontSize: 18),
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/ball_appBar.png'),
          fit: BoxFit.fitWidth,
        ),
        elevation: 0.0,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
          ClipOval(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                child: Icon(Icons.wallpaper),
                onLongPress: () {},
              ),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.ac_unit),
            ),
          ),
        ],
      ),
    ));
  }
}

var orientation;
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
