import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';
import 'package:erobot_app/screens/controller/ball_shooter_setting.dart';
import 'package:erobot_app/object_class/classes.dart';

class BallShooter extends StatefulWidget {
  BallShooter({Key key}) : super(key: key);
  @override
  _BallShooterState createState() => _BallShooterState();
}

class _BallShooterState extends State<BallShooter> {
  String btnRight, btnLeft, btnBottom, btnTop, btnShoot;
  double speed, speedTMP, servo;

  Button button;

  @override
  void initState() {
    btnRight = 'R';
    btnLeft = 'L';
    btnBottom = 'B';
    btnTop = 'T';
    btnShoot = 'S';
    servo = 4;
    speedTMP = 5;
    speed = 5;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthBtn = 55;
    double heightBtn = 55;
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
            IconButton(icon: Icon(isConnect()), onPressed: () {})
          ],
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.settings, color: Hexcolor('B6142C'), size: 25),
          onPressed: () async {
            Button button = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BallShooterSetting(
                        btnTop, btnLeft, btnRight, btnBottom, btnShoot)));
            setState(() {
              if (button != null) {
                btnRight = button.right;
                btnLeft = button.left;
                btnBottom = button.bottom;
                btnTop = button.top;
                btnShoot = button.shoot;
              }
            });
          },
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
                        CreatePadBtn(1, widthBtn, heightBtn, 1, btnTop),
                        Row(children: <Widget>[
                          CreatePadBtn(2, widthBtn, heightBtn, 1, btnLeft),
                          SizedBox(
                            width: widthBtn,
                          ),
                          CreatePadBtn(3, widthBtn, heightBtn, 1, btnRight),
                        ]),
                        CreatePadBtn(4, widthBtn, heightBtn, 1, btnBottom),
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
                          },
                          onChangeEnd: (speedTMP) {
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
                              onTap: () {
                                print(btnShoot);
                              },
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
                          },
                          onChangeEnd: (servoTMP) {
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
}
