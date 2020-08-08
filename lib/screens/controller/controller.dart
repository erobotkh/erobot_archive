import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';
import 'package:erobot_app/screens/controller/controller_setting.dart';
import 'package:erobot_app/object_class/classes.dart';
import 'package:toast/toast.dart';

class Controller extends StatefulWidget {
  final int _cardIndex;
  Controller(this._cardIndex);
  @override
  _ControllerState createState() => _ControllerState(_cardIndex);
}

class _ControllerState extends State<Controller> {
  final int _cardIndex;
  _ControllerState(this._cardIndex);
  String btnRight, btnLeft, btnBottom, btnTop, btnShoot;
  double speed, speedTMP, servo;

  Button button; //BUTTON CLASS

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

  //WHEN CLICK SPEED UP BUTTON - PROBLEM WHEN SPEED = 0
  //SO SET IT TO VALUE 1 BEFORE ANIMATE TO VALUE 1
  //REMOVE THE CONDITION TO TEST IT
  void updateSpeed() {
    if (speedTMP == 0 || speed == 0) {
      setState(() {
        speedTMP = 1;
        speed = speedTMP;
      });
      speedTMP = speed = 0;
    }
    setState(() {
      speed++;
      speedTMP = speed.roundToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthBtn = 55;
    double heightBtn = 55;
    String tille = _cardIndex == 1 ? 'Ball Shooter' : 'Arduino Card';
    return SafeArea(
      child: Scaffold(
        //APP BAR
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 31, 40, 1),
          title: Text(
            tille,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          flexibleSpace: Image(
            image: _cardIndex == 1
                ? AssetImage('assets/ball_appBar.png')
                : AssetImage('assets/carR_appBar.png'),
            fit: BoxFit.fill,
          ),
          actions: <Widget>[
            IconButton(icon: Icon(isConnect()), onPressed: () {})
          ],
          elevation: 0.0,
        ),
        //FLOATING SETTING BUTTON
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.settings,
              color: _cardIndex == 1 ? Hexcolor('B6142C') : Hexcolor('03A0B0'),
              size: 25),
          onPressed: () async {
            Button button = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BallShooterSetting(btnTop, btnLeft,
                        btnRight, btnBottom, btnShoot, _cardIndex)));
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
        // BUTTON CONTAINER
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //PAD BUTTON
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        CreatePadBtn(1, _cardIndex, btnTop),
                        Row(children: <Widget>[
                          CreatePadBtn(2, _cardIndex, btnLeft),
                          SizedBox(
                            width: widthBtn,
                          ),
                          CreatePadBtn(3, _cardIndex, btnRight),
                        ]),
                        CreatePadBtn(4, _cardIndex, btnBottom),
                      ],
                    ),
                  ),
                ),
                //SPEED AND SHOOT CONTROLLER
                Container(
                  width: 250,
                  height: 180,
                  child: Stack(
                    children: <Widget>[
                      //SPEED TEXT
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        start: 40,
                        child: Text(
                          'Speed: $speed',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Quicksand'),
                        ),
                      ),
                      //SPEED SLIDER
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
                                progressBarColor: _cardIndex == 1
                                    ? Hexcolor('B6142C')
                                    : Hexcolor('03A0B0'),
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
                      //SHOOT BUTTON
                      Center(
                        child: ClipOval(
                          child: Material(
                            color: _cardIndex == 1
                                ? Hexcolor('B6142C')
                                : Hexcolor('03A0B0'),
                            child: InkWell(
                              splashColor: Colors.black12,
                              child: SizedBox(
                                  width: widthBtn * 2.2,
                                  height: heightBtn * 2.2,
                                  child: _cardIndex == 1
                                      ? Icon(
                                          Icons.gps_fixed,
                                          size: widthBtn,
                                          color: Colors.white,
                                        )
                                      : Center(
                                          child: FaIcon(
                                              FontAwesomeIcons.angleDoubleUp,
                                              size: widthBtn - 10,
                                              color: Colors.white))),
                              onTap: () {
                                if (_cardIndex == 1) {
                                } else if (_cardIndex == 2) {
                                  if (speed >= 9) {
                                    Toast.show("Max Speed!", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  } else if (speed < 9 ||
                                      speedTMP < 9 ||
                                      speedTMP >= 0 ||
                                      speed >= 0) {
                                    setState(() {
                                      updateSpeed();
                                      speedTMP = speed.roundToDouble();
                                    });
                                    print(speed);
                                  }
                                }
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
            //SERVO SLIDER ON BOTTOM
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _cardIndex == 1
                    ? Row(
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
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 40.0),
                              ),
                              child: Slider(
                                value: servo,
                                max: 9,
                                min: 0,
                                activeColor: _cardIndex == 1
                                    ? Hexcolor('B6142C')
                                    : Hexcolor('03A0B0'),
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
                      )
                    : Text(''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
