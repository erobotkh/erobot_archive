import 'package:flutter/material.dart';

class LogInChoice extends StatefulWidget {
  LogInChoice({Key key}) : super(key: key);

  @override
  _LogInChoiceState createState() => _LogInChoiceState();
}

class _LogInChoiceState extends State<LogInChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        child: Icon(Icons.person),
        onPressed:(){ Navigator.pushNamed(context, '/loginP');}
      ),
    );
  }
}