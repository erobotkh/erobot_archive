import 'package:flutter/material.dart';

class BallShooter extends StatefulWidget {
  BallShooter({Key key}) : super(key: key);

  @override
  _BallShooterState createState() => _BallShooterState();
}

class _BallShooterState extends State<BallShooter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ball Shooter')
      ),
    );
  }
}