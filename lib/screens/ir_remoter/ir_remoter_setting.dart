import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';

class IRremoterSetting extends StatefulWidget {
  final List<IRremoteSetting> _setting;
  IRremoterSetting(this._setting);

  @override
  _IRremoterSettingState createState() => _IRremoterSettingState(_setting);
}

class _IRremoterSettingState extends State<IRremoterSetting> {
  List<IRremoteSetting> setting, settingTMP;
  _IRremoterSettingState(this.setting);

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    //double mediaHeight = MediaQuery.of(context).size.height;
    settingTMP = setting;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, setting);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context, setting),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'Setting',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          //RESET TO DEFAUL BUTTON
          actions: [],
        ),
        body: ScrollConfiguration(
          //ScrollConfiguration IS USED TO HIDE SCROLL EFFECT (WHITE EFFECT)
          behavior: ScrollBehavior()
            ..buildViewportChrome(context, null, AxisDirection.down),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(255, 255, 255, .1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Reset to', style: TextStyle(color: Colors.white)),
                      Container(
                        height: 30,
                        width: mediaWidth * .3,
                        child: FlatButton(
                          color: Color.fromRGBO(255, 255, 255, .2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          splashColor: Colors.white,
                          child: Text(
                            'Hex',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            resetDefaultHex();
                          },
                        ),
                      ),
                      Container(
                        height: 30,
                        width: mediaWidth * .38,
                        child: FlatButton(
                          color: Color.fromRGBO(255, 255, 255, .2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          splashColor: Colors.white,
                          child: Text(
                            'Character',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            resetDefaultChar();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: setting.length,
                itemBuilder: (context, index) {
                  IRremoteSetting settings = setting[index];
                  return buildSetting(
                    context,
                    settings.name,
                    settings.describe,
                    settings.value,
                    index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isContainPNG(String value) {
    int k = 0, t = 0;
    String path = 'png';
    if (value.length > 4)
      for (int i = value.length - 3; i < value.length; i++) {
        if (path[k] == value[i]) t++;
        k++;
      }
    if (t == 3) return true ?? false;
    return false;
  }

  //RESET TO INITIAL SETTING
  void reset() {
    for (int i = 0; i < setting.length; i++) {
      setting[i].value = settingTMP[i].value;
    }
  }

  //RESET TO DEFAULT CHARACTER SETTING
  void resetDefaultChar() {
    print("${defaultChar.length} vs ${setting.length}");
    for (int i = 0; i < setting.length; i++) setting[i].value = defaultChar[i];
    setState(() {});
  }

  //RESET TO DEFAULT HEX SETTING
  void resetDefaultHex() {
    for (int i = 0; i < setting.length; i++) setting[i].value = defaultHex[i];
    setState(() {});
  }

  Padding buildSetting(
    context,
    final String title,
    final String describe,
    final String _value,
    final int index,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: index == 0 ? 10 : 10,
        bottom: index == setting.length - 1 ? 20 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                child: !isContainPNG(title)
                    ? Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 15, top: 5, bottom: 5),
                        child: Image.asset('assets/sender/$title'),
                      ),
              ),
              SizedBox(width: 10),
              Text(
                ':  $describe',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          InkWell(
            splashColor: null,
            onTap: () => buildShowModalBottomSheet(context, _value),
            child: Row(
              children: [
                Text(
                  _value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FaIcon(
                  FontAwesomeIcons.angleRight,
                  size: 20,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isDubicateValue(String value) {
    for (int i = 0; i < setting.length; i++)
      if (value == setting[i].value) return true;

    return false;
  }

  Future buildShowModalBottomSheet(BuildContext context, String btnValue) {
    String _btnTMP = btnValue;

    void changeValue(value) {
      print('cam!');
      if (value != '' && _btnTMP != value) {
        for (int i = 0; i < setting.length; i++) {
          if (setting[i].value == _btnTMP) {
            if (!isDubicateValue(value)) {
              setState(() {
                setting[i].value = value;
                print('changed value to ${setting[i].value}');
              });
            } else if (isDubicateValue(value)) {
              Toast.show(
                "Cannot save, dublicated value '$value'",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.CENTER,
              );
            }
          }
        }
      } else {
        Toast.show(
          "Cannot save!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
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
                style: TextStyle(fontSize: 18, color: Colors.white),
                maxLines: 1,
                onChanged: (value) {
                  print("changing to " + value);
                  if (_btnTMP != value && isDubicateValue(value)) {
                    Toast.show(
                      "Dublicated value '$value'",
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.TOP,
                    );
                  }
                },
                onFieldSubmitted: (value) {
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
