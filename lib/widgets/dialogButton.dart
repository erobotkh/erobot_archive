import 'package:flutter/material.dart';

//YES or NO BUTTON ON DIALOG
class DialogBtn extends StatelessWidget {
  final String yRN;
  DialogBtn(this.yRN);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Text(
        yRN,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
