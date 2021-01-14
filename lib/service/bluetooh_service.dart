import 'package:erobot_app/import/importall.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothList extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  bool isDisconnecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _selectedDevice;
  bool _connected = false;

  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    // Get current state
    FlutterBluetoothSerial.instance.state.then(
      (state) => setState(() => _bluetoothState = state),
    );

    enableBluetooth();
    FlutterBluetoothSerial.instance.onStateChanged().listen(
          (BluetoothState state) => setState(() {
            _bluetoothState = state;
            getPairedDevices();
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, _selectedDevice);
            }),
        title: Text(
          'Bluetooth List',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => FlutterBluetoothSerial.instance.openSettings(),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Visibility(
            visible:
                _isConnecting && _bluetoothState == BluetoothState.STATE_ON,
            child: LinearProgressIndicator(
              backgroundColor: Palette.background,
              valueColor: AlwaysStoppedAnimation<Color>(Palette.blue_pacific),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Palette.blue_pacific,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bluetooth',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  activeColor: Colors.white,
                  value: _bluetoothState.isEnabled,
                  onChanged: (_isConnected) {
                    future() async {
                      if (_isConnected)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();

                      // In order to update the devices list
                      await getPairedDevices();

                      // Disconnect from any device before turning off Bluetooth
                      if (_connected) _disconnect();
                    }

                    future().then((_) => setState(() {}));
                  },
                )
              ],
            ),
          ),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    !_bluetoothState.isEnabled
                        ? 'Please turn on Bluetooth'
                        : _devicesList.isNotEmpty
                            ? 'Devices found'
                            : 'Device not found!',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                _bluetoothState.isEnabled
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FlatButton(
                          color: Palette.blue_pacific,
                          textColor: Colors.white,
                          onPressed: () async {
                            await getPairedDevices().then((_) {
                              show('Device list refreshed', true);
                            });
                          },
                          child: Text('Refresh'),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              for (BluetoothDevice _devices in _devicesList)
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_devices.name),
                      FlatButton(
                        color: _connected
                            ? Palette.red_milano
                            : Palette.blueSplash,
                        child: Text(
                          _connected ? 'Disconnect' : 'Connect',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print("Device: " + _devices.address);
                          print("Device: " + _devices.name);
                          _connected
                              ? _disconnect()
                              : _selectedDevice = await _connect(_devices);
                        },
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> _devices = [];
    // To get the list of paired devices
    try {
      _devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }
    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) return;

    setState(() => _devicesList = _devices);
  }

  Future<BluetoothDevice> _connect(BluetoothDevice _devices) async {
    setState(() => _isConnecting = true);
    if (_devices == null) {
      show('No device selected', false);
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_devices.address).then(
          (_connection) {
            print('Connected to the device');
            connection = _connection;
            setState(() => _connected = true);
            show('Device connected', true);

            connection.input.listen(null).onDone(() {
              if (isDisconnecting)
                print('Disconnecting locally!');
              else
                print('Disconnected remotely!');
              if (this.mounted) setState(() {});
            });
            return _devices;
          },
        ).catchError(
          (error) {
            print('Cannot connect, exception occurred');
            show('Cannot connect to device', false);
            print(error);
          },
        );
      }
    }
    setState(() => _isConnecting = false);
    return null;
  }

  void _disconnect() async {
    await connection.close();
    show('Device disconnected', true);
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
      });
    }
  }

  Future show(String message, bool isSuccess,
      {Duration duration: const Duration(seconds: 3)}) async {
    await Future.delayed(Duration(milliseconds: 100));
    widget._scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Palette.blue_pacific : Palette.red_milano,
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Raleway'),
        ),
        duration: duration,
        action: SnackBarAction(
          textColor: Colors.white,
          label: "OK",
          onPressed: () =>
              widget._scaffoldKey.currentState.hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
