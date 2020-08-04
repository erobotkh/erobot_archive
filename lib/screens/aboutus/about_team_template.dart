import 'package:flutter/material.dart';

class AboutTeamTemplate extends StatefulWidget {
  final index;
  AboutTeamTemplate(this.index);  
  @override
  _AboutTeamTemplateState createState() => _AboutTeamTemplateState(index);
}

class _AboutTeamTemplateState extends State<AboutTeamTemplate> {
  int index;
  _AboutTeamTemplateState(this.index);
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'PNC EVENT',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
      ),),
    );
  }
}
