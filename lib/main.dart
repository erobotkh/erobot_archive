import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/arduino_doc/arduino_doc.dart';
import 'screens/sender/sender.dart';
import 'screens/ball_shooter/ball_shooter.dart';
import 'screens/arduino_car/arduino_car.dart';
import 'screens/ir_remoter/ir_remoter.dart';
import 'screens/home_page/home.dart';
import 'screens/drawer_bar/aboutus.dart';
import 'screens/drawer_bar/feedback.dart';
//import 'package:page_transition/page_transition.dart';

void main() => runApp(MaterialApp(
      // onGenerateRoute: (settings){
      //   if(settings.name == '/homescreen'){
      //       return PageTransition(
      //         child: HomeScreen(),
      //         type: PageTransitionType.scale,
      //         settings: settings,
      //       );
      //     }
      //     else return null;
      // },
      //debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
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
  final delay = 5;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget(){
    var _duration = Duration(seconds: delay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.pushReplacementNamed(context, '/homescreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/app_splash.png', width: 150,),
      ),
    );
  }
}

