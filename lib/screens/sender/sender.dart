import 'dart:convert';

import 'package:erobot_app/service/bluetooh_service.dart';
import 'package:erobot_app/service/save_preference.dart';

import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/models.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Sender extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  TextEditingController _textController;
  String _valueTMP;
  bool _loaded = false;

  //RECENT TEXT VALUE LIST - THIS WILL BE USED FOR SHARE PREFERENCE
  List<String> _values = [''];

  //RECENT TEXT VALUE + COLOR LIST
  final List<RecentSender> listRecent = <RecentSender>[
    RecentSender('', Colors.transparent)
  ];

  //COLORS FOR RECENT TEXT BUTTON
  var color;
  List<Color> colorsList = [
    Palette.orange_burning,
    Palette.red_milano,
    Palette.yellow,
    Palette.blue_pacific,
    Palette.green_fun,
  ];

  //BLUETOOTH FUNCTIONALITY
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    //LOAD CACHE DATA
    if (!_loaded) _loadData();
    _textController = TextEditingController();
    super.initState();
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
    //SAVE CACHE DATA WHEN POP
    _saveData();
    _textController?.dispose();
    super.dispose();
  }

  //ONLY LOAD ONCE AT FIRST
  _loadData() async {
    _loaded = true;
    _values = await loadRecentSenderData() ?? '';
    for (int i = 1; i < _values.length; i++) {
      color = colorsList[i % 5]; //ONLY 5 COLOR IS USED
      setState(() {
        if (_values[i] != '')
          listRecent.insert(1, RecentSender(_values[i], color));
      });
    }
  }

  //ONLY SAVE ONCE AT CLOSE
  _saveData() async {
    print("saving data");
    saveRecentSenderData(_values) ?? print('data is empty');
  }

  //ON RECENT TEXT BUTTON CLICK
  void onRecentClick(RecentSender recentVal) {
    if (recentVal.recent != '') {
      print("removing " + recentVal.recent);
      setState(() {
        //SET TEXT DATA TO TEXT FIELD
        _textController.text = recentVal.recent;

        //REMOVE TEXT DATA FROM LIST
        _values.remove(recentVal.recent);
        listRecent.remove(recentVal);
      });
    } else {
      //IF CLICK ON '' EMPTY => NOT REMOVE IT (IT'S USED TO MAKE SPACE)
      print('empty value cant be removed');
    }
  }

  //ADD TEXT DATA TO LIST
  void addtoRecent() {
    print("adding data to recently");
    color = colorsList[listRecent.length % 5];

    //TRIM TO REMOVE SPACE AT BEGIN AND END
    _valueTMP = _valueTMP.trim();
    print(_valueTMP);

    if (_values.length > 10) {
      //ONLY STORE 10 VALUE IN LIST
      //IF VALUE > 10 REMOVE THE FIRST ADDED VALUE

      _values.removeAt(1);
      //REMOVE AT INDEX[1] CAUSE IT IS FIRST ADDED VALUE IN _values

      listRecent.removeAt(10);
      //REMOVE AT INDEX[10] CAUSE IS IS FIRST ADDED VALUE IN listRecent
    }
    if (_valueTMP != '') {
      for (int i = 0; i < listRecent.length; i++) {
        if (_valueTMP == listRecent[i].recent) {
          //IF listRecent HAVE DUBLICATE VALUE => REMOVE OLD VALUE
          listRecent.removeAt(i);
          _values.remove(_valueTMP);
        }
      }

      if (_values.contains(_valueTMP)) {
        //(DUBLICATE VALUE) AFTER REMOVE AT OLD VALUE, ADD TO FRONT
        setState(() {
          _values.insert(_values.length, _valueTMP);
          listRecent.insert(1, RecentSender(_valueTMP, color));
        });
        print('remove and add in if contain');
      } else if (!_values.contains(_valueTMP)) {
        //ELSE INSERT VALUE TO LIST
        setState(() {
          listRecent.insert(1, RecentSender(_valueTMP, color));
          _values.insert(_values.length, _valueTMP);
        });
        print('remove and add in if not contain');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text('Sender', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: Colors.white),
              onPressed: () => getServer()),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.only(bottom: 0),
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        //BUTTON TO CLEAR TEXT FIELD VALUE
                        icon: Icon(Icons.clear, size: 20),
                        onPressed: () {
                          setState(() => _textController.clear());
                        },
                      ),
                      border: InputBorder.none,
                      labelText: "Type anything here...",
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (_value) => _valueTMP = _value,
                  ),
                ),
                SizedBox(height: 5),

                //SEND TO BLUETOOTH BUTTON & SAVE DATA TO LIST
                FlatButton(
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: Palette.blue_pacific,
                  onPressed: () {
                    if (_valueTMP != null) {
                      addtoRecent();
                      sendtoBT(_valueTMP);
                    }
                  },
                ),
                Divider(color: Palette.whitesmoke),
                Text(
                  listRecent.length > 1 ? 'Recently' : 'No recent data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 37,
            //BUILDER LIST OF RECENT TEXT VALUE
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listRecent.length,
              itemBuilder: (context, index) {
                RecentSender recentVal = listRecent[index];
                return recentVal.recent != null
                    ? Row(
                        children: [
                          //RECENT TEXT THAT CLICKABLE
                          GestureDetector(
                            onTap: () => onRecentClick(recentVal),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: recentVal.color,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 17,
                                    right: 17,
                                  ),
                                  child: Text(
                                    recentVal.recent,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      )
                    : Text('');
              },
            ),
          )
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
