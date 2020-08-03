import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: <Widget>[
          buildBtn('Farm Assistant', 'Make your farming smarter', 0, context),
          buildBtn(
              'Sender', 'to Send text to arduino via Bluetooth', 1, context),
          buildBtn(
              'Ball Shooter',
              'to Control ball shooter arduino car, servo, and speed',
              2,
              context),
          buildBtn('Arduino Car', 'Remoter to Control Arduino Car with speed',
              3, context),
          buildBtn(
              'IR Remoter', 'to Control Light and Buzzer Arduino', 4, context),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
        ],
      ),
    );
  }

  Widget buildBtn(
      String title, String desription, int cardIndex, BuildContext context) {
    String pathlogo = 'mdi_bluetooth.png';
    double widtht = 15;
    double heightt = 20;
    double boxSizz = 10;
    if (cardIndex == 0) {
      boxSizz = 0;
      widtht = 30;
      heightt = 35;
      pathlogo = 'arduino_logo.png';
    }
    return Container(
      child: Padding(
          padding: cardIndex == 0
              ? EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0)
              : cardIndex.isEven
                  ? EdgeInsets.fromLTRB(5.0, 0.0, 18.0, 10.0)
                  : EdgeInsets.fromLTRB(18.0, 0.0, 5.0, 10.0),
          child: Stack(children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ImageBackground(cardIndex),
              ),
            ),
            Positioned.fill(
              child: randBackground(cardIndex),
            ),
            Positioned.fill(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                onPressed: () {
                  String routeP;
                  if (cardIndex == 0) routeP = '/farm_assistant';
                  if (cardIndex == 1) routeP = '/sender';
                  if (cardIndex == 2) routeP = '/shooter';
                  if (cardIndex == 3) routeP = '/ard_car';
                  if (cardIndex == 4) routeP = '/ir_remote';
                  Navigator.pushNamed(context, routeP);
                },
                splashColor: Color.fromRGBO(255, 255, 255, .2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .7),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          desription,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              letterSpacing: .5),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/$pathlogo',
                        width: widtht, height: heightt),
                    SizedBox(
                      height: boxSizz,
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
