import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/arduino_doc/arduino_doc.dart';
import 'screens/sender/sender.dart';
import 'screens/ball_shooter/ball_shooter.dart';
import 'screens/arduino_car/arduino_car.dart';
import 'screens/ir_remoter/ir_remoter.dart';
import 'screens/home_page/home.dart';

void main() => runApp(MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //initialRoute: '/',
      routes: {
        '/homescreen': (context) => HomeScreen(),
        '/ard_doc': (context) => ArduinoDoc(),
        '/sender': (context) => Sender(),
        '/shooter': (context) => BallShooter(),
        '/ard_car': (context) => ArduinoCar(),
        '/ir_remote': (context) => IrRemoter(),
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
