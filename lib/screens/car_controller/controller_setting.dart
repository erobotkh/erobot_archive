import 'package:erobot_app/service/save_preference.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:erobot_app/validation/validation.dart';

import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';

class BallShooterSetting extends StatefulWidget {
  final int _cardIndex;
  final String btnTop, btnLeft, btnRight, btnBottom, btnShoot, btnSpeed;

  BallShooterSetting(
    this.btnTop,
    this.btnLeft,
    this.btnRight,
    this.btnBottom,
    this.btnShoot,
    this.btnSpeed,
    this._cardIndex,
  );

  @override
  _BallShooterSettingState createState() => _BallShooterSettingState(
        btnTop,
        btnLeft,
        btnRight,
        btnBottom,
        btnShoot,
        btnSpeed,
        _cardIndex,
      );
}

class _BallShooterSettingState extends State<BallShooterSetting> {
  final int _cardIndex;
  String btnTop, btnLeft, btnRight, btnBottom, btnShoot, btnSpeed;
  _BallShooterSettingState(
    this.btnTop,
    this.btnLeft,
    this.btnRight,
    this.btnBottom,
    this.btnShoot,
    this.btnSpeed,
    this._cardIndex,
  );

  Button tmp; // class to store temporary button value

  @override
  Widget build(BuildContext context) {
    //STORE TEMPORARY DATA
    tmp = Button(
      btnTop,
      btnLeft,
      btnBottom,
      btnRight,
      _cardIndex == 1 ? btnShoot : btnSpeed,
    );
    return WillPopScope(
      onWillPop: () async {
        //STORE DATA IN CLASS TO POP WITH DATA AS A CLASS
        var button = Button(
          btnTop,
          btnLeft,
          btnBottom,
          btnRight,
          _cardIndex == 1 ? btnShoot : btnSpeed,
        );
        Navigator.pop(context, button);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () async {
              //STORE DATA IN CLASS TO POP WITH DATA AS A CLASS
              var button = Button(
                btnTop,
                btnLeft,
                btnBottom,
                btnRight,
                _cardIndex == 1 ? btnShoot : btnSpeed,
              );
              Navigator.pop(context, button);
            },
            icon: Icon(Icons.arrow_back),
          ),
          //RESET TO DEFAUL BUTTON
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: FlatButton(
                color: Color.fromRGBO(255, 255, 255, .1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  'Reset to default',
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
        //SETTINGS CONTAINER
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: <Widget>[
              buildSetting(context, 'Up Button', btnTop, 1),
              buildSetting(context, 'Left Button', btnLeft, 2),
              buildSetting(context, 'Right Button', btnRight, 3),
              buildSetting(context, 'Down Button', btnBottom, 4),
              SizedBox(height: _cardIndex == 1 ? 8 : 0),
              _cardIndex == 1
                  ? buildSetting(context, 'Shoot Button', btnShoot, 5)
                  : buildSetting(context, 'Speed Up', btnSpeed, 6),
            ],
          ),
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
    _cardIndex == 1 ? btnShoot = tmp.power : btnSpeed = tmp.power;
  }

  //RESET TO DEFAULT DATA
  void resetDefault() {
    btnTop = 'T';
    btnLeft = 'L';
    btnRight = 'R';
    btnBottom = 'B';
    _cardIndex == 1 ? btnShoot = 'S' : btnSpeed = 'P';
  }

  //BUILD EACH BUTTON SETTING
  Row buildSetting(
    context,
    final String title,
    final String btnValue,
    final int btnIndex,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              child: btnIndex == 5
                  ? Icon(
                      Icons.gps_fixed,
                      color: Colors.white,
                      size: 25,
                    )
                  : btnIndex == 6
                      ? Center(
                          child: FaIcon(
                            FontAwesomeIcons.angleDoubleUp,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      : ReturnIcon(btnIndex, 55, _cardIndex),
            ),
            SizedBox(width: 10),
            Text(
              ':  $title',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        InkWell(
          splashColor: null,
          onTap: () {
            buildShowModalBottomSheet(context, btnValue).whenComplete(
              () async {
                List<String> _validate = [
                  btnTop,
                  btnLeft,
                  btnRight,
                  btnBottom,
                  _cardIndex == 1 ? btnShoot : btnSpeed
                ];
                //CLARIFY THAT THERE IS NO DULICATE CHAR
                var distinctBtn = _validate.toSet().toList();
                if (distinctBtn.length == 5) {
                  print('btn changed');
                  setState(() {});
                  //SAVE CACHE DATA
                  var button = Button(
                    btnTop,
                    btnLeft,
                    btnBottom,
                    btnRight,
                    _cardIndex == 1 ? btnShoot : btnSpeed,
                  );
                  await savePadData(button, _cardIndex);
                  Toast.show(
                    "Saved change'",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.TOP,
                  );
                } else {
                  reset();
                  Toast.show(
                    "Value can't be saved",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.TOP,
                  );
                }
              },
            );
          },
          child: Row(
            children: [
              Text(
                btnValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              FaIcon(FontAwesomeIcons.angleRight, size: 20, color: Colors.white)
            ],
          ),
        )
      ],
    );
  }

  //OPEN TEXT FIELD TO CHANGE BUTTON DATA
  Future buildShowModalBottomSheet(BuildContext context, String btnValue) {
    List<String> _validate = [
      btnTop,
      btnLeft,
      btnRight,
      btnBottom,
      _cardIndex == 1 ? btnShoot : btnSpeed
    ];
    final String _btnTMP = btnValue;

    void changeValue(value) {
      if (value != '') {
        if (btnTop == btnValue) btnTop = value;
        if (btnLeft == btnValue) btnLeft = value;
        if (btnRight == btnValue) btnRight = value;
        if (btnBottom == btnValue) btnBottom = value;
        if (btnShoot == btnValue && _cardIndex == 1)
          btnShoot = value;
        else if (btnSpeed == btnValue) btnSpeed = value;
        btnValue = value;
      }
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: TextFormField(
                autofocus: true,
                initialValue: btnValue,
                decoration: InputDecoration(
                  counterText: '',
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                maxLines: 1,
                maxLength: 1,
                onChanged: (value) {
                  print("changing to " + value);
                  if (_btnTMP != value && isDublicate(value, _validate)) {
                    Toast.show(
                      "Dublicated value '$value'",
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.TOP,
                    );
                    reset();
                  }
                },
                onFieldSubmitted: (value) {
                  print('changed value to $value');
                  changeValue(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
