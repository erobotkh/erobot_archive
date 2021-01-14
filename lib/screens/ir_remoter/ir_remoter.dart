import 'dart:convert';

import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/data/ir_model.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/service/bluetooh_service.dart';
import 'package:erobot_app/service/save_preference.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class IrRemoter extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _IrRemoterState createState() => _IrRemoterState();
}

class _IrRemoterState extends State<IrRemoter> {
  bool isShow = false;
  bool isPlay = false;
  List<String> defaultVal = [''];
  List<IRremoteSetting> setting = [];

  //BLUETOOTH FUNCTIONALITY
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    _loadCacheData();
    if (selectedDevice != null) _connectBT();
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
  void dispose() {
    super.dispose();
    _saveCacheData();
  }

  void _saveCacheData() async {
    List<String> values = [];
    for (int i = 0; i < setting.length; i++) values.insert(i, setting[i].value);
    await savetoCacheIRremoterData(values);
  }

  void _loadCacheData() async {
    defaultVal = await loadCacheIRremoterData();
    setState(
      () {
        for (int i = 0; i < defaultVal.length; i++) {
          setting.insert(
            i,
            IRremoteSetting(
              btnTitle[i],
              btnDescribe[i],
              defaultVal[i],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text('IR Remoter', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(
              isShow ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () => setState(() => isShow = !isShow),
          ),
          IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: Colors.white),
              onPressed: () => getServer()),
          SizedBox(width: 10),
        ],
      ),

      //FLOAT SETTING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.settings,
          color: Palette.blue_pacific,
          size: 25,
        ),
        onPressed: () async {
          List<IRremoteSetting> setting1 = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IRremoterSetting(setting),
            ),
          );
          if (setting1 != null) {
            setState(() {
              isShow = false;
              setting.replaceRange(0, 21, setting1);
            });
          }
        },
      ),

      //BODY
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .65,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 25),
              //CHANNEL
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Image.asset('assets/sender/channel.png'),
              ),
              ThreeCircleButtons(
                    index: 0,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[0].value),
                    onPressed2: () => sendtoBT(setting[1].value),
                    onPressed: () => sendtoBT(setting[2].value),
                    value: <String>[
                      setting[0].value, // CHANNEL -
                      setting[1].value, // CHANNEL
                      setting[2].value, // CHANNEL +
                    ],
                  ) ??
                  SizedBox(height: 0),

              //PREVIEW + NEXT + PLAY OR PAUSE
              buildTextLine("Prev", "Next", !isPlay ? "Play" : "Pause"),
              ThreeCircleButtons(
                    index: 3,
                    onPressed1: () => sendtoBT(setting[3].value),
                    onPressed2: () => sendtoBT(setting[4].value),
                    onPressed: () {
                      setState(() => isPlay = !isPlay);
                      sendtoBT(setting[5].value);
                    },
                    isShow: isShow,
                    value: <String>[
                      setting[3].value, // VOL -
                      setting[4].value, // VOL +
                      setting[5].value, // PLAY/PAUSE
                    ],
                  ) ??
                  SizedBox(height: 0),

              //VOLUMN VOLUMN + EQ
              buildTextLine("Vol-", "Vol+", ''),
              ThreeCircleButtons(
                    index: 6,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[6].value),
                    onPressed2: () => sendtoBT(setting[7].value),
                    onPressed: () => sendtoBT(setting[8].value),
                    value: <String>[
                      setting[6].value, //
                      setting[7].value, //
                      setting[8].value, //
                    ],
                  ) ??
                  SizedBox(height: 0),
              SizedBox(height: 10),

              // 0 + 100 + 200
              ThreeCircleButtons(
                    index: 9,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[9].value),
                    onPressed2: () => sendtoBT(setting[10].value),
                    onPressed: () => sendtoBT(setting[11].value),
                    value: <String>[
                      setting[9].value, //
                      setting[10].value, //
                      setting[11].value, //
                    ],
                  ) ??
                  SizedBox(height: 0),
              SizedBox(height: 10),

              // ONE + TWO + THREE
              ThreeCircleButtons(
                    index: 12,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[12].value),
                    onPressed2: () => sendtoBT(setting[13].value),
                    onPressed: () => sendtoBT(setting[14].value),
                    value: <String>[
                      setting[12].value, //
                      setting[13].value, //
                      setting[14].value, //
                    ],
                  ) ??
                  SizedBox(height: 0),
              SizedBox(height: 10),

              // FOUR + FIVE + SIX
              ThreeCircleButtons(
                    index: 15,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[15].value),
                    onPressed2: () => sendtoBT(setting[16].value),
                    onPressed: () => sendtoBT(setting[17].value),
                    value: <String>[
                      setting[15].value, //
                      setting[16].value, //
                      setting[17].value, //
                    ],
                  ) ??
                  SizedBox(height: 0),
              SizedBox(height: 10),

              // SEVEN + EIGHT + NINE
              ThreeCircleButtons(
                    index: 18,
                    isShow: isShow,
                    onPressed1: () => sendtoBT(setting[18].value),
                    onPressed2: () => sendtoBT(setting[19].value),
                    onPressed: () => sendtoBT(setting[20].value),
                    value: <String>[
                      setting[18].value, //
                      setting[19].value, //
                      setting[20].value, //
                    ],
                  ) ??
                  SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  Material buildTextLine(String val1, String val2, String val3) {
    return Material(
      color: Colors.transparent,
      textStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Quicksand',
        fontSize: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 55, child: Center(child: Text(val1))),
          Container(width: 55, child: Center(child: Text(val2))),
          Container(width: 55, child: Center(child: Text(val3))),
        ],
      ),
    );
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
        backgroundColor: Palette.red_milano,
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Raleway'),
        ),
        duration: duration,
        action: SnackBarAction(
            textColor: Colors.white,
            label: "OK",
            onPressed: () =>
                widget._scaffoldKey.currentState.hideCurrentSnackBar()),
      ),
    );
  }
}
