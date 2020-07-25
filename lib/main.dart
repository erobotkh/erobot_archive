import 'dart:async';

//Packages
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:hexcolor/hexcolor.dart';

//Screens
import 'screens/arduino_doc/arduino_doc.dart';
import 'screens/sender/sender.dart';
import 'screens/ball_shooter/ball_shooter.dart';
import 'screens/arduino_car/arduino_car.dart';
import 'screens/ir_remoter/ir_remoter.dart';
import 'screens/home_page/home.dart';
import 'screens/drawer_bar/aboutus.dart';
import 'screens/drawer_bar/feedback.dart';
import 'screens/login_page/log_choice.dart';
import 'screens/login_page/login.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

//0xAARRGGBB
MaterialColor colorCustom = MaterialColor(0xFF172634, color);
MaterialColor colorCustom2 = MaterialColor(0xFF161F28, color);

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
        canvasColor: colorCustom2,
      ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/loginC': (context) => LogInChoice(),
        '/loginP': (context) => LoginPage(),
        '/homescreen': (context) => HomeScreen(),
        '/ard_doc': (context) => ArduinoDoc(),
        '/sender': (context) => Sender(),
        '/shooter': (context) => BallShooter(),
        '/ard_car': (context) => ArduinoCar(),
        '/ir_remote': (context) => IrRemoter(),
        '/feedback': (context) => FeedbackApp(),
        '/aboutus': (context) => AboutUs(),
      },
    ));

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final delay = 3;
  @override
  void initState() {
    super.initState();
    var _duration = Duration(seconds: delay);
    Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context,
        PageTransition(
            child: HomeScreen(),
            duration: Duration(milliseconds: 450),
            type: PageTransitionType.fade));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(
                      height: 250,
                    ),
                    Image.asset(
                      'assets/app_splash.png',
                      width: 150,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Color.fromRGBO(22, 31, 40, 1),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color.fromRGBO(22, 31, 40, 1),
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'EDUCATION IS '),
                              TextSpan(
                                  text: 'POWER',
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                              TextSpan(text: '.')
                            ]),
                      ),
                    )
                  ])),
              Container(
                child: Column(children: <Widget>[
                  Text(
                    'Last published 30th Jul, 2020.',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromRGBO(22, 31, 40, .6),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
