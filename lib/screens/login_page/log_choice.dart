import 'package:flutter/material.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';
import 'package:hexcolor/hexcolor.dart';

class LogInChoice extends StatefulWidget {
  LogInChoice({Key key}) : super(key: key);

  @override
  _LogInChoiceState createState() => _LogInChoiceState();
}

class _LogInChoiceState extends State<LogInChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 10, bottom: 3),
              child: Text(
                'WELCOME OUR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 175,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 7.0),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/home/our_team.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned.fill(
                      child: randBackground(3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Erobot member!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            'Join us now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Member will have access all privilege to see post, oportunity, and team reputation',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              splashColor: Hexcolor('04bacd'),
              color: Hexcolor('03a0b0'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                Navigator.pushNamed(context, '/loginP');
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                      child: Text(
                    'Login as member',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              splashColor: Color.fromRGBO(0, 0, 0, .1),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                Navigator.pushNamed(context, '/joinus');
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                      child: Text(
                    'Join Us',
                    style: TextStyle(fontSize: 18),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
