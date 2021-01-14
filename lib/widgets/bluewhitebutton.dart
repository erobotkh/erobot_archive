import 'package:flutter/material.dart';

class FlatTextButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color splashColor;
  final Function onPressed;
  final bool isblue;

  const FlatTextButton({
    Key key,
    this.color = Colors.white,
    @required this.text,
    this.splashColor = const Color.fromRGBO(0, 0, 0, .1),
    @required this.onPressed,
    this.isblue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: splashColor,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: isblue ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
