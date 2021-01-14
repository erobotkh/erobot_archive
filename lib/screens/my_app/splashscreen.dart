import 'dart:async';
import 'package:erobot_app/screens/my_app/root.dart';
import 'package:erobot_app/widgets/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//SPLASH SCREEN PAGE
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var _duration = Duration(seconds: 5);
    Timer(_duration, navigationPage);
    super.initState();
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        PageRouteTransition(
            child: Root(), duration: Duration(milliseconds: 1000),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .1),
                    Image.asset(
                      'assets/erobot-logo/app_splash.png',
                      width: 150,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .04),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Color.fromRGBO(22, 31, 40, 1),
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Raleway',
                          fontSize: 15,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'EDUCATION IS '),
                          TextSpan(
                            text: 'POWER',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(text: '.')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Last published 30th Jul, 2020.',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromRGBO(22, 31, 40, .6),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
