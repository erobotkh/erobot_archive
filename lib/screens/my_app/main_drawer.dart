import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/service/auth_service.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Palette.bigstone,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        user != null ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Palette.blue_pacific, width: 5.0),
                            borderRadius: BorderRadius.circular(60 + 5.0),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/profiles/bot2.png'),
                          ),
                        ) : Container(),
                        SizedBox(height: user != null ? 10 : 0),
                        Text(
                          user != null ? "User" : "User mode",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          user != null ? "${_auth.getEmail()}" : "Please log in with your Erobot account",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      ],
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.bluetooth,
                  //     color: Colors.white,
                  //   ),
                  //   title: Text(
                  //     "Bluetooth",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (c) => BluetoothList(),
                  //     ),
                  //   ),
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.feedback,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/feedback'),
                  ),
                  user != null
                      ? ListTile(
                          leading: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Sign out',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            _auth.signOut();
                            Scaffold.of(context).openEndDrawer();
                            //exit(0);
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
