import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      //Store all cards
      children: <Widget>[
        buildProfileCard(
            'Suy Kosal', 'Leader of Team', 'kosal.png', 'kosal', 'kosal', context),
        buildProfileCard('Han Leangsiv', 'Organizer of team since 2019',
            'leangsiv.png', 'kosal', 'kosal', context),
        buildProfileCard('Run Seyha', 'Organizer of team since 2019',
            'seyha.png', 'kosal', 'kosal', context),
        buildProfileCard(
            'Bots', 'Robot of team', 'bot1.png', 'kosal', 'kosal', context),
        buildProfileCard(
            'Bots', 'Robot of team', 'bot2.png', 'kosal', 'kosal', context),
        buildProfileCard(
            'Bots', 'Robot of team', 'bot1.png', 'kosal', 'kosal', context),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Padding buildProfileCard(String name, String role, String pathIMG,
      String fbUsername, String telegramUsername, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0.0),
      child: Container(
          //Store a card
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          height: 85,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              //Store left is image and right is info
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/profiles/$pathIMG'),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        //Store name and role
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Text(
                            role,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ]),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.625,
                      child: Row(
                        //Store social media information
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: Hexcolor('161F28'),
                              child: InkWell(
                                splashColor: Colors.blue,
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.telegramPlane,
                                    size: 18,
                                    color: Colors.white,
                                  )),
                                ),
                                onTap: () {
                                  print('telegram clicked');
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 28,
                            child: FlatButton.icon(
                                splashColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                color: Hexcolor('161F28'),
                                onPressed: () {
                                  print('facebook clicked');
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Facebook',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
