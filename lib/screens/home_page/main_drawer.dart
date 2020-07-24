import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Hexcolor('161f28'),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/erobotlogo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "E-Robot",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "erobotappdev@gmail.com",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Hexcolor('161f28'),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Hexcolor('161f28'),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Hexcolor('161f28'),
              ),
              title: Text(
                'About us',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Hexcolor('161f28'),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: Hexcolor('161f28'),
              ),
              title: Text(
                'Feedback',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Hexcolor('161f28'),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Hexcolor('161f28'),
              ),
              title: Text(
                'Exit',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Hexcolor('161f28'),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
