import 'package:flutter/material.dart';

class FeedbackApp extends StatefulWidget {
  FeedbackApp({Key key}) : super(key: key);

  @override
  _FeedbackAppState createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
    );
  }
}