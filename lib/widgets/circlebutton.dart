import 'package:erobot_app/data/ir_model.dart';
import 'package:flutter/material.dart';

class CircleButtonText extends StatelessWidget {
  const CircleButtonText({
    Key key,
    @required this.isShow,
    @required this.display,
    @required this.value,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final bool isShow;
  final String display;
  final String value;
  final String color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    String colorOx = "FF" + color;
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(int.parse(colorOx, radix: 16)),
      ),
      child: IconButton(
        icon: Text(
          !isShow ? display : value,
          style: TextStyle(
            color: color != 'ffffff'
                ? Colors.white
                : Color(0xFF161f28),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CircleButtonIcon extends StatelessWidget {
  const CircleButtonIcon({
    Key key,
    @required this.isShow,
    @required this.value,
    @required this.path,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final bool isShow;
  final String value;
  final String path;
  final String color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    String colorOx = "FF" + color;
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(int.parse(colorOx, radix: 16)),
      ),
      child: IconButton(
        icon: !isShow
            ? Padding(
                padding: EdgeInsets.all(path == 'playpause.png' ? 11.0 : 8.0),
                child: Image.asset('assets/sender/$path'),
              )
            : Text(
                value,
                style: TextStyle(
                  color: color != 'ffffff'
                      ? Colors.white
                      : Color(0xFF161f28),
                ),
              ),
        onPressed: onPressed,
      ),
    );
  }
}

class ThreeCircleButtons extends StatelessWidget {
  const ThreeCircleButtons({
    Key key,
    @required this.isShow,
    @required this.value,
    @required this.index,
    this.onPressed,
    this.onPressed1,
    this.onPressed2,
  }) : super(key: key);

  final Function onPressed1;
  final Function onPressed2;
  final Function onPressed;
  final int index;
  final bool isShow;
  final List<String> value;

  @override
  Widget build(BuildContext context) {
    List<Function> onPresses = [onPressed1, onPressed2, onPressed];
    List<String> colors = [
      btnColors[index],
      btnColors[index + 1],
      btnColors[index + 2],
    ];

    List<String> title = [
      titles[index],
      titles[index + 1],
      titles[index + 2],
    ];
    List<String> path = [
      paths[index],
      paths[index + 1],
      paths[index + 2],
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 3; i++)
          path[i] == null
              ? CircleButtonText(
                  onPressed: onPresses[i],
                  isShow: isShow,
                  display: title[i],
                  value: value[i],
                  color: '${colors[i]}',
                )
              : CircleButtonIcon(
                  onPressed: onPresses[i],
                  isShow: isShow,
                  value: value[i],
                  path: path[i],
                  color: '${colors[i]}',
                ),
      ],
    );
  }
}
