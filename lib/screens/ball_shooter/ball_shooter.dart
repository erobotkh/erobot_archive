import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
//import 'package:page_transition/page_transition.dart';
//import 'package:sleek_circular_slider/sleek_circular_slider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:page_transition/page_transition.dart';
//import 'package:control_pad/control_pad.dart';

//import 'package:erobot_app/main.dart';
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
  double speed = 5;
  double speedTMP = 5;
  double servo = 5;
  var bltBtn1; //this will send to arduino
  var bltBtn2;
  var bltBtn3;
  var bltBtn4;

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
                    isConnected = false;
                  else
                    isConnected = false;
                  // setState(() {

                  // });
                })
          ],
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        createPadBtn(1),
                        Row(children: <Widget>[
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
                Container(
                  width: 250,
                  height: 180,
                  child: Stack(
                    children: <Widget>[
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        start: 40,
                        child: Text(
                          'Speed: $speed',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Quicksand'),
                        ),
                      ),
                      Positioned.fill(
                        child: SleekCircularSlider(
                          initialValue: speedTMP,
                          min: 0,
                          max: 9,
                          appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 10,
                              handlerSize: 3,
                            ),
                            customColors: CustomSliderColors(
                                trackColor: Hexcolor('c4c4c4'),
                                progressBarColor: Hexcolor('B6142C'),
                                hideShadow: true,
                                dotColor: Hexcolor('c4c4c4')),
                            startAngle: 90,
                            angleRange: 180,
                            counterClockwise: true,
                          ),
                          onChange: (speedTMP) {
                            setState(() {
                              speed = speedTMP.roundToDouble();
                            });
                            print(speed);
                          },
                        ),
                      ),
                      Center(
                        child: ClipOval(
                          child: Material(
                            color: Hexcolor('B6142C'),
                            child: InkWell(
                              splashColor: Colors.black12,
                              child: SizedBox(
                                  width: widthBtn * 2.2,
                                  height: heightBtn * 2.2,
                                  child: Icon(
                                    Icons.gps_fixed,
                                    size: widthBtn,
                                    color: Colors.white,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Servo:',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Quicksand'),
                    ),
                    Container(
                      width: 200,
                      height: 20,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 2,
                          thumbColor: Colors.white,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 8.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 40.0),
                        ),
                        child: Slider(
                          value: servo,
                          max: 9,
                          min: 0,
                          activeColor: Hexcolor('B6142C'),
                          inactiveColor: Hexcolor('c4c4c4'),
                          onChanged: (servoTMP) {
                            setState(() {
                              servo = servoTMP.roundToDouble();
                            });
                            print(servo);
                          },
                        ),
                      ),
                    ),
                    Text(
                      '$servo',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
              ],
            )
          ],
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
    isConnected = false;
    return Icons.bluetooth_disabled;
  }
}
