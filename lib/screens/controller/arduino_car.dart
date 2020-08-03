import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../supplier/widget_supplier.dart';

class ArduinoCar extends StatefulWidget {
  ArduinoCar({Key key}) : super(key: key);

  @override
  _ArduinoCarState createState() => _ArduinoCarState();
}

class _ArduinoCarState extends State<ArduinoCar> {
  @override
  dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 31, 40, 1),
          title: Text(
            'Arduino Car',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          flexibleSpace: Image(
            image: AssetImage('assets/carR_appBar.png'),
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
                        CreatePadBtn(1, widthBtn, heightBtn, 2),
                        Row(children: <Widget>[
                          CreatePadBtn(2, widthBtn, heightBtn, 2),
                          SizedBox(
                            width: widthBtn,
                          ),
                          CreatePadBtn(3, widthBtn, heightBtn, 2),
                        ]),
                        CreatePadBtn(4, widthBtn, heightBtn, 2),
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
                                progressBarColor: Hexcolor('03A0B0'),
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
                            color: Hexcolor('03A0B0'),
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
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
