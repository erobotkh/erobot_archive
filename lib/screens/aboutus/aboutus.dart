import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'team_reputation.dart';
import 'about_member.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor:  Hexcolor('172634'),
          appBar: AppBar(
            elevation: 5,
            title: TabBar(
            dragStartBehavior: DragStartBehavior.down,
            labelStyle: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 15),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'About Member',
              ),
              Tab(
                text: 'Team Reputation',
              )
            ],
          ),
          ),
          body: TabBarView(children: [
            AboutMember(),
            TeamReputation(),
          ]),
        ));
  }
}
