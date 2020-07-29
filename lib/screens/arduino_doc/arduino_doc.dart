import 'package:erobot_app/screens/supplier/widget_supplier.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArduinoDoc extends StatefulWidget {
  ArduinoDoc({Key key}) : super(key: key);

  @override
  _ArduinoDocState createState() => _ArduinoDocState();
}

class _ArduinoDocState extends State<ArduinoDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          buildCard('Arduino Documents', 'Learn how to build a robot', 0, context, 'arduino_doc.png'),
          buildCard('Arduino Documents', 'Learn how to build a robot', 1, context, 'car_runner.png'),
          buildCard('Arduino Documents', 'Learn how to build a robot', 2, context, 'arduino_doc.png'),
          buildCard('Arduino Documents', 'Learn how to build a robot', 3, context, 'arduino_doc.png'),
          buildCard('Arduino Documents', 'Learn how to build a robot', 4, context, 'arduino_doc.png'),

        ],
      ),
    );
  }
}

Widget buildCard(String title, String desription, int cardIndex,
    BuildContext context, String path) {
  String pathlogo = 'arduino_logo.png';
  double boxSizz = 0;
  double widtht = 30;
  double heightt = 35;

  return Container(
    height: 145,
    child: Padding(
        padding: cardIndex == 0 ? EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 7.0) : cardIndex == 4 ? EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 10.0) : EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
        child: Stack(children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset('assets/home/arduino_doc.png', fit: BoxFit.cover,)),
          ),
          Positioned.fill(
            child: RandBackground(),
          ),
          Positioned.fill(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              onPressed: () {
                String routeP;
                if (cardIndex == 0){
                                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: ArduinoDoc(),
                          duration: Duration(milliseconds: 1000),
                          type: PageTransitionType.fade));
                }
                if (cardIndex == 1) routeP = '/sender';
                if (cardIndex == 2) routeP = '/shooter';
                if (cardIndex == 3) routeP = '/ard_car';
                if (cardIndex == 4) routeP = '/ir_remote';
                Navigator.pushNamed(context, routeP);
              },
              splashColor: Color.fromRGBO(255, 255, 255, .2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .7),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        desription,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            letterSpacing: .5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/$pathlogo',
                      width: widtht, height: heightt),
                  SizedBox(
                    height: boxSizz,
                  )
                ],
              ),
            ),
          )
        ])),
  );
}
