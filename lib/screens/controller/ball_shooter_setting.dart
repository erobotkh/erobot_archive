import 'package:flutter/material.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class BallShooterSetting extends StatefulWidget {
  final String btnTop, btnLeft, btnRight, btnBottom, btnShoot;
  BallShooterSetting(
      this.btnTop, this.btnLeft, this.btnRight, this.btnBottom, this.btnShoot);

  @override
  _BallShooterSettingState createState() =>
      _BallShooterSettingState(btnTop, btnLeft, btnRight, btnBottom, btnShoot);
}

class Button {
  String top, left, right, bottom, shoot;
}

class _BallShooterSettingState extends State<BallShooterSetting> {
  String btnTop, btnLeft, btnRight, btnBottom, btnShoot;
  _BallShooterSettingState(
      this.btnTop, this.btnLeft, this.btnRight, this.btnBottom, this.btnShoot);

  @override
  void initState() {
    super.initState();
  }

  var tmp = Button();

  @override
  Widget build(BuildContext context) {
    tmp.top = btnTop;
    tmp.left = btnLeft;
    tmp.right = btnRight;
    tmp.bottom = btnBottom;
    tmp.shoot = btnShoot;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            buildSetting(context, 'Up Button', btnTop, 1, 55),
            buildSetting(context, 'Left Button', btnLeft, 2, 55),
            buildSetting(context, 'Right Button', btnRight, 3, 55),
            buildSetting(context, 'Down Button', btnBottom, 4, 55),
            SizedBox(height: 8),
            buildSetting(context, 'Shoot Button', btnShoot, 5, 55),
          ],
        ),
      ),
    );
  }

  void reset() {
    btnTop = tmp.top;
    btnLeft = tmp.left;
    btnRight = tmp.right;
    btnBottom = tmp.bottom;
    btnShoot = tmp.shoot;
  }

  Row buildSetting(BuildContext context, String title, String btnValue,
      int btnIndex, double btnWidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Container(
            width: 40,
            child: btnIndex != 5
                ? ReturnIcon(btnIndex, btnWidth, 1)
                : Icon(
                    Icons.gps_fixed,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
          SizedBox(width: 10),
          Text(
            ':  $title',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      InkWell(
        splashColor: null,
        onTap: () {
          buildShowModalBottomSheet(context, btnValue).whenComplete(() {
            List<String> validate = [
              btnTop,
              btnLeft,
              btnRight,
              btnBottom,
              btnShoot
            ];
            var distinctBtn = validate.toSet().toList();
            if (distinctBtn.length == 5)
              setState(() {});
            else
              reset();
          });
        },
        child: Row(
          children: [
            Text(btnValue, style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(
              width: 10,
            ),
            FaIcon(FontAwesomeIcons.angleRight, size: 20, color: Colors.white)
          ],
        ),
      )
    ]);
  }

  Future buildShowModalBottomSheet(BuildContext context, String btnValue) {
    changeValue(value) {
      print("Button " + btnValue);
      if (btnTop == btnValue) btnTop = value;
      if (btnLeft == btnValue) btnLeft = value;
      if (btnRight == btnValue) btnRight = value;
      if (btnBottom == btnValue) btnBottom = value;
      if (btnShoot == btnValue) btnShoot = value;
      btnValue = value;
      print(" change to " + btnValue);
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  autofocus: true,
                  initialValue: btnValue,
                  decoration: InputDecoration(
                    counterText: '',
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  maxLines: 1,
                  onChanged: (value) {
                    changeValue(value);
                  },
                ),
              ),
            ),
          );
        });
  }
}
