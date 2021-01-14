import 'dart:convert';

import 'package:erobot_app/service/bluetooh_service.dart';
import 'package:erobot_app/service/save_preference.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:toast/toast.dart';
import 'package:erobot_app/import/importall.dart';

class Controller extends StatefulWidget {
  final int _cardIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Controller(this._cardIndex);
  @override
  _ControllerState createState() => _ControllerState(_cardIndex);
}

class _ControllerState extends State<Controller> {
  final int _cardIndex;
  _ControllerState(this._cardIndex);

  String btnRight, btnLeft, btnBottom, btnTop, btnShoot, btnSpeed;
  double speed, speedTMP, servo;
  Button button;

  //BLUETOOTH FUNCTIONALITY
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    servo = 4;
    speedTMP = 5;
    speed = 5;
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
    );
    super.initState();
    _loadSavedData();
    if (selectedDevice != null) _connectBT();
  }

  //LOAD CACHE DATA
  _loadSavedData() async {
    button = await loadPadData(_cardIndex);
    setState(
      () {
        btnRight = button.right;
        btnLeft = button.left;
        btnBottom = button.bottom;
        btnTop = button.top;
        _cardIndex == 1 ? btnShoot = button.power : btnSpeed = button.power;
      },
    );
  }

  _connectBT() {
    BluetoothConnection.toAddress(selectedDevice.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    });
  }

  @override
  dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthBtn = 55;
    double heightBtn = 55;
    String tille = _cardIndex == 1 ? 'Ball Shooter' : 'Arduino Card';

    ClipOval buildPadButton(int btnIndex, int screenNum, String value) =>
        ClipOval(
          child: Material(
            color: Palette.whitesmoke,
            child: InkWell(
              splashColor: Colors.black12,
              child: SizedBox(
                width: 55,
                height: 55,
                child: ReturnIcon(btnIndex, 55, screenNum),
              ),
              onTap: () => sendtoBT(value),
            ),
          ),
        );

    return SafeArea(
      child: Scaffold(
        key: widget._scaffoldKey,
        //APP BAR
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 31, 40, 1),
          title: Text(
            tille,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          flexibleSpace: Image(
            image: _cardIndex == 1
                ? AssetImage('assets/controller/ball_appBar.png')
                : AssetImage('assets/controller/carR_appBar.png'),
            fit: BoxFit.fill,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.bluetooth_disabled),
              onPressed: () => getServer(),
            )
          ],
          elevation: 0.0,
        ),
        //FLOATING SETTING BUTTON
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.settings,
            color: _cardIndex == 1 ? Palette.red_milano : Palette.blue_pacific,
            size: 25,
          ),
          onPressed: () async {
            Button button = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BallShooterSetting(
                  btnTop,
                  btnLeft,
                  btnRight,
                  btnBottom,
                  btnShoot,
                  btnSpeed,
                  _cardIndex,
                ),
              ),
            );
            setState(() {
              if (button != null) {
                btnRight = button.right;
                btnLeft = button.left;
                btnBottom = button.bottom;
                btnTop = button.top;
                _cardIndex == 1
                    ? btnShoot = button.power
                    : btnSpeed = button.power;
              }
            });
          },
        ),
        // BUTTON CONTAINER
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //PAD BUTTON
                Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        buildPadButton(1, _cardIndex, btnTop),
                        Row(
                          children: <Widget>[
                            buildPadButton(2, _cardIndex, btnLeft),
                            SizedBox(width: widthBtn),
                            buildPadButton(3, _cardIndex, btnRight),
                          ],
                        ),
                        buildPadButton(4, _cardIndex, btnBottom),
                      ],
                    ),
                  ),
                ),
                //SPEED AND SHOOT CONTROLLER
                Container(
                  width: 250,
                  height: 180,
                  child: Stack(
                    children: <Widget>[
                      //SPEED TEXT
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        start: 40,
                        child: Text(
                          'Speed: $speed',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ),
                      //SPEED SLIDER
                      Positioned.fill(
                        child: SleekCircularSlider(
                          initialValue: speedTMP,
                          min: 0,
                          max: 9,
                          appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 10,
                              handlerSize: 3,
                            ),
                            customColors: CustomSliderColors(
                              trackColor: Palette.whitesmoke,
                              progressBarColor: _cardIndex == 1
                                  ? Palette.red_milano
                                  : Palette.blue_pacific,
                              hideShadow: true,
                              dotColor: Palette.whitesmoke,
                            ),
                            startAngle: 90,
                            angleRange: 180,
                            counterClockwise: true,
                          ),
                          onChange: (speedTMP) {
                            setState(() => speed = speedTMP.roundToDouble());
                          },
                          onChangeEnd: (speedTMP) => sendtoBT(
                            speed.toString(),
                          ),
                        ),
                      ),
                      //SHOOT BUTTON
                      Center(
                        child: ClipOval(
                          child: Material(
                            color: _cardIndex == 1
                                ? Palette.red_milano
                                : Palette.blue_pacific,
                            child: InkWell(
                              splashColor: Colors.black12,
                              child: SizedBox(
                                width: widthBtn * 2.2,
                                height: heightBtn * 2.2,
                                child: _cardIndex == 1
                                    ? Icon(
                                        Icons.gps_fixed,
                                        size: widthBtn,
                                        color: Colors.white,
                                      )
                                    : Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.angleDoubleUp,
                                          size: widthBtn - 10,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              onTap: () {
                                if (_cardIndex == 1) {
                                  sendtoBT(btnShoot);
                                } else if (_cardIndex == 2) {
                                  if (speed >= 9) {
                                    Toast.show(
                                      "Max Speed!",
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM,
                                    );
                                  } else if (speed < 9 ||
                                      speedTMP < 9 ||
                                      speedTMP >= 0 ||
                                      speed >= 0) {
                                    setState(() {
                                      updateSpeed();
                                      speedTMP = speed.roundToDouble();
                                    });
                                    sendtoBT(speed.toString());
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            //SERVO SLIDER ON BOTTOM
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                _cardIndex == 1
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Servo:',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Quicksand'),
                          ),
                          Container(
                            width: 200,
                            height: 20,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 2,
                                thumbColor: Colors.white,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8.0,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 40.0,
                                ),
                              ),
                              child: Slider(
                                value: servo,
                                max: 9,
                                min: 0,
                                activeColor: _cardIndex == 1
                                    ? Palette.red_milano
                                    : Palette.blue_pacific,
                                inactiveColor: Palette.whitesmoke,
                                onChanged: (servoTMP) {
                                  setState(() {
                                    servo = servoTMP.roundToDouble();
                                  });
                                },
                                onChangeEnd: (servoTMP) {
                                  sendtoBT(servo.toString());
                                },
                              ),
                            ),
                          ),
                          Text(
                            '$servo',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      )
                    : Text(''),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateSpeed() {
    if (isConnected)
      setState(() {
        speed++;
        speedTMP = speed.roundToDouble();
      });
    else
      setState(() {
        speed = speed;
      });
  }

  //BLUETOOTH FUNCTIONALITY
  void sendtoBT(String value) async {
    if (!isConnected) {
      print("value $value can't be sent");
      show('Please connect to a device!');
    } else {
      connection.output.add(utf8.encode(value + "\r\n"));
      await connection.output.allSent;
      print("value $value is sent");
    }
  }

  Future<void> getServer() async {
    selectedDevice = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BluetoothList(),
      ),
    );
    print(
      "Selected Server:" +
          selectedDevice.name.toString() +
          selectedDevice.address.toString(),
    );
  }

  Future show(String message,
      {Duration duration: const Duration(seconds: 3)}) async {
    await Future.delayed(Duration(milliseconds: 100));
    widget._scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor:
            _cardIndex == 1 ? Palette.red_milano : Palette.blue_pacific,
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Raleway'),
        ),
        duration: duration,
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Open Bluetooth Setting",
          onPressed: () => getServer(),
        ),
      ),
    );
  }
}
