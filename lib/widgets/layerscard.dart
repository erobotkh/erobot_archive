import 'package:erobot_app/config/offset_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
// import 'dart:math' as math;

class ThreeLayerCard extends StatefulWidget {
  final String title;
  final String desription;
  final int cardIndex;
  final Function onPressed;
  final String path;
  final bool isCenter;

  const ThreeLayerCard({
    Key key,
    @required this.title,
    @required this.desription,
    @required this.cardIndex,
    @required this.onPressed,
    @required this.path,
    this.isCenter = false,
  }) : super(key: key);

  @override
  _ThreeLayerCardState createState() => _ThreeLayerCardState();
}

class _ThreeLayerCardState extends State<ThreeLayerCard> {
  final double borderRadius = 15;
  double _animate = 0;
  @override
  Widget build(BuildContext context) {
    //BLUETOOTH OR ARDUINO LOGO HEIGHT
    double width = 15, height = 20;
    String pathlogo = 'mdi_bluetooth.png';

    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    if (widget.cardIndex == 0) {
      width = 30;
      height = 35;
      pathlogo = 'arduino_logo.png';
    }

    double left, top, right, bottom;
    top = bottom = 0;
    left = right = mediaWidth * .05;
    if (widget.isCenter) {
      bottom = 7;
      widget.cardIndex == 0 ? top = mediaHeight * .015 : top = 7;
    } else if (!widget.isCenter) {
      top = 14;
      widget.cardIndex == 0
          ? top = mediaHeight * .015
          : widget.cardIndex.isEven
              ? left = 7
              : right = 7;
    }

    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(opacity: 1 - notifier.page % 1, child: child);
      },
      child: Container(
        height:
            !widget.isCenter && (widget.cardIndex == 2 || widget.cardIndex == 3)
                ? mediaHeight * .25
                : mediaHeight * .20,
        constraints: BoxConstraints(minHeight: 150, maxHeight: 180),
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.asset(widget.path, fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
              child: randBackground(widget.cardIndex, borderRadius),
            ),
            buildPositioned(
                size: widget.cardIndex == 0 ? 300 - _animate : 0, index: 0),
            buildPositioned(
                size: widget.cardIndex == 0 ? 280 - _animate : 0, index: 1),
            buildPositioned(
                size: widget.cardIndex == 0 ? 260 - _animate : 0, index: 2),
            Positioned.fill(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius))),
                onPressed: widget.onPressed,
                splashColor: const Color.fromRGBO(255, 255, 255, .2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: widget.isCenter ? 18 : 20,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .7,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          widget.desription,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            letterSpacing: .5,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: widget.cardIndex != 0 ? 10.0 : 5),
                      child: Image.asset(
                        'assets/arduinologo/$pathlogo',
                        width: width,
                        height: height,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildPositioned({double size, int index}) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Consumer<PageOffsetNotifier>(
              builder: (context, notifier, child) {
                return Positioned(
                  top: 0,
                  right: -notifier.offset * index - 120,
                  child: child,
                );
              },
              child: ClipOval(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: size,
                  height: size,
                  color: Color.fromRGBO(255, 255, 255, .08),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoLayerCard extends StatelessWidget {
  const TwoLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ),
              ),
            ),
            Positioned.fill(child: randBackground(3, 14)),
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
    );
  }
}

Color returnColor(int cardIndex) {
  //DO THIS TO BE BETTER WHEN DECREASE COLOR PICTURE OPERCITY
  var color1 = [0, 111, 60];
  var color2 = [249, 167, 62];
  var color3 = [182, 20, 44];
  var color4 = [3, 160, 176];
  var color5 = [231, 126, 78];

  var colorRGBO;
  if (cardIndex == 0) colorRGBO = color1;
  if (cardIndex == 1) colorRGBO = color2;
  if (cardIndex == 2) colorRGBO = color3;
  if (cardIndex == 3) colorRGBO = color4;
  if (cardIndex == 4) colorRGBO = color5;
  return Color.fromRGBO(
    colorRGBO[0],
    colorRGBO[1],
    colorRGBO[2],
    .8,
  );
}

Widget randBackground(int index, double borderRadius) {
  int cardIndex = index % 5;

  return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(color: returnColor(cardIndex)));
}
