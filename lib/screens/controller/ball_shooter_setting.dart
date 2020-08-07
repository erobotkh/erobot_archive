import 'package:flutter/material.dart';
import 'package:erobot_app/supplier/widget_supplier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:erobot_app/object_class/classes.dart';

class BallShooterSetting extends StatefulWidget {
  final String btnTop, btnLeft, btnRight, btnBottom, btnShoot;
  BallShooterSetting(
      this.btnTop, this.btnLeft, this.btnRight, this.btnBottom, this.btnShoot);

  @override
  _BallShooterSettingState createState() =>
      _BallShooterSettingState(btnTop, btnLeft, btnRight, btnBottom, btnShoot);
}

class _BallShooterSettingState extends State<BallShooterSetting> {
  String btnTop, btnLeft, btnRight, btnBottom, btnShoot;
  _BallShooterSettingState(
      this.btnTop, this.btnLeft, this.btnRight, this.btnBottom, this.btnShoot);

  var tmp = ButtonTMP();

  @override
  Widget build(BuildContext context) {
    //STORE TEMPORARY DATA
    tmp.top = btnTop;
    tmp.left = btnLeft;
    tmp.right = btnRight;
    tmp.bottom = btnBottom;
    tmp.shoot = btnShoot;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Setting'),
        leading: IconButton(
          onPressed: () {
            //Store data in class before pop back with data
            var button = Button(btnTop, btnLeft, btnBottom, btnRight, btnShoot);
            print('LAST VALUE: ');
            print(button.top +
                button.left +
                button.bottom +
                button.right +
                button.shoot);
            Navigator.pop(context, button);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: FlatButton(
              color: Color.fromRGBO(255, 255, 255, .1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                'Reset to defalut',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                setState(() {
                  resetDefault();
                });
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            buildSetting(context, 'Up Button', btnTop, 1),
            buildSetting(context, 'Left Button', btnLeft, 2),
            buildSetting(context, 'Right Button', btnRight, 3),
            buildSetting(context, 'Down Button', btnBottom, 4),
            SizedBox(height: 8),
            buildSetting(context, 'Shoot Button', btnShoot, 5),
          ],
        ),
      ),
    );
  }

  //RESET TO INITIAL DATA
  void reset() {
    btnTop = tmp.top;
    btnLeft = tmp.left;
    btnRight = tmp.right;
    btnBottom = tmp.bottom;
    btnShoot = tmp.shoot;
  }

  //RESET TO DEFAULT DATA
  void resetDefault() {
    btnTop = 'T';
    btnLeft = 'L';
    btnRight = 'R';
    btnBottom = 'B';
    btnShoot = 'S';
  }

  //BUILD EACH BUTTON SETTING
  Row buildSetting(context, String title, String btnValue, int btnIndex) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Container(
            width: 40,
            child: btnIndex != 5
                ? ReturnIcon(btnIndex, 55, 1)
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
            List<String> _validate = [
              btnTop,
              btnLeft,
              btnRight,
              btnBottom,
              btnShoot
            ];
            //CHECK VALIDE OF BUTTON DATA
            for (String i in _validate) if (i == '' || i.length > 1) reset();

            //CHECK IF THERE IS DULICATE NUMBER
            var distinctBtn = _validate.toSet().toList();
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

  //OPEN TEXT FIELD TO CHANGE BUTTON DATA
  Future buildShowModalBottomSheet(BuildContext context, String btnValue) {
    changeValue(value) {
      if (btnTop == btnValue) btnTop = value;
      if (btnLeft == btnValue) btnLeft = value;
      if (btnRight == btnValue) btnRight = value;
      if (btnBottom == btnValue) btnBottom = value;
      if (btnShoot == btnValue) btnShoot = value;
      btnValue = value;
      if (value != '') print("Change to " + btnValue);
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
