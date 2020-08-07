import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:erobot_app/screens/aboutus/about_team_template.dart';

class TeamReputation extends StatefulWidget {
  TeamReputation({Key key}) : super(key: key);

  @override
  _TeamReputationState createState() => _TeamReputationState();
}

class _TeamReputationState extends State<TeamReputation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        buildProfileCard('PNC Event', '19th Jul, 2019', 'pnc.png', 1, context),
        buildProfileCard(
            'Smart Event', '19th Jul, 2019', 'smart.png', 2, context),
        buildProfileCard(
            'Stem Event', '19th Jul, 2019', 'stem.png', 3, context),
        SizedBox(height: 10),
      ],
    ));
  }

  //CREATE EVENT CARDS
  Padding buildProfileCard(String name, String role, String pathIMG, int index,
      BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0.0),
      child: Container(
          //CARD CONTAINER
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          height: 85,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //EVENT LOGO
                Image.asset('assets/events/$pathIMG'),
                SizedBox(
                  width: 10,
                ),
                //EVENT INFO
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //EVENT NAME
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          //EVENT ROLE
                          Text(
                            role,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ]),

                    //READ MORE BUTTON
                    Container(
                      width: MediaQuery.of(context).size.width * 0.625,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 28,
                            child: FlatButton(
                                splashColor: index == 1
                                    ? Colors.lightBlue
                                    : index == 2
                                        ? Colors.green
                                        : Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                color: Hexcolor('161F28'),
                                onPressed: () {
                                  print('see more clicked $index');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AboutTeamTemplate(index)));
                                },
                                child: Text(
                                  'Read More',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          ),
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
