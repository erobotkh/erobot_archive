import 'package:flutter/material.dart';

class FarmAssistant extends StatefulWidget {
  FarmAssistant({Key key}) : super(key: key);

  @override
  _FarmAssistantState createState() => _FarmAssistantState();
}

class _FarmAssistantState extends State<FarmAssistant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm Assistant', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
