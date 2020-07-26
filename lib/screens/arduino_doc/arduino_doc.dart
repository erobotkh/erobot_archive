import 'package:erobot_app/screens/supplier/widget_supplier.dart';
import 'package:flutter/material.dart';
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
          appBar: AppBar(
            title: Text(
              'Arduino Documents',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          body: Column(
            children: <Widget>[
            ],
          ),
    );
  }
}