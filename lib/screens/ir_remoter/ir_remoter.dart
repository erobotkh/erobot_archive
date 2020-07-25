import 'package:flutter/material.dart';

class IrRemoter extends StatefulWidget {
  IrRemoter({Key key}) : super(key: key);

  @override
  _IrRemoterState createState() => _IrRemoterState();
}

class _IrRemoterState extends State<IrRemoter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IR Remoter')
      ),
    );
  }
}