import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArduinoCar extends StatefulWidget {
  ArduinoCar({Key key}) : super(key: key);

  @override
  _ArduinoCarState createState() => _ArduinoCarState();
}

class _ArduinoCarState extends State<ArduinoCar> {
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      appBar: AppBar(title: Text('Arduino Car')),
    );
  }
}
