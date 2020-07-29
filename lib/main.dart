import 'dart:async';
//import 'dart:math';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';

//Screens
import 'screens/arduino_doc/arduino_doc.dart';
import 'screens/sender/sender.dart';
import 'screens/controller/ball_shooter.dart';
import 'screens/controller/arduino_car.dart';
import 'screens/ir_remoter/ir_remoter.dart';
import 'screens/home_page/home.dart';
import 'screens/drawer_bar/aboutus.dart';
import 'screens/drawer_bar/feedback.dart';
import 'screens/login_page/log_choice.dart';
import 'screens/login_page/login.dart';
import 'package:erobot_app/screens/home_page/main_drawer.dart';
//import 'package:erobot_app/screens/supplier/widget_supplier.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

//0xAARRGGBB
MaterialColor colorCustom = MaterialColor(0xFF172634, color);
MaterialColor colorCustom2 = MaterialColor(0xFF161F28, color);

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
        canvasColor: colorCustom2,
      ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/loginC': (context) => LogInChoice(),
        '/loginP': (context) => LoginPage(),
        '/homescreen': (context) => HomeScreen(),
        '/ard_doc': (context) => ArduinoDoc(),
        '/sender': (context) => Sender(),
        '/shooter': (context) => BallShooter(),
        '/ard_car': (context) => ArduinoCar(),
        '/ir_remote': (context) => IrRemoter(),
        '/feedback': (context) => FeedbackApp(),
        '/aboutus': (context) => AboutUs(),
      },
    ));

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final delay = 3;
  @override
  void initState() {
    super.initState();
    var _duration = Duration(seconds: delay);
    Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: Root(),
            duration: Duration(milliseconds: 550),
            type: PageTransitionType.fade));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(
                      height: 250,
                    ),
                    Image.asset(
                      'assets/app_splash.png',
                      width: 150,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Color.fromRGBO(22, 31, 40, 1),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color.fromRGBO(22, 31, 40, 1),
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'EDUCATION IS '),
                              TextSpan(
                                  text: 'POWER',
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                              TextSpan(text: '.')
                            ]),
                      ),
                    )
                  ])),
              Container(
                child: Column(children: <Widget>[
                  Text(
                    'Last published 30th Jul, 2020.',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromRGBO(22, 31, 40, .6),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedItem = 0;
  var _pages = [HomeScreen(), ArduinoDoc(), AboutUs(), LogInChoice()];
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);
    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Builder(
                builder: (context) => IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.alignLeft,
                      size: 20,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer())),
          ),
          title: Text(
            'E-Robot',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       heartIcon(),
          //       color: Colors.white,
          //     ),
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     onPressed: () {
          //       randomNum = listNum[Random().nextInt(listNum.length)];
          //       Navigator.pushReplacement(
          //           context,
          //           PageTransition(
          //               child: Root(),
          //               duration: Duration(milliseconds: 1000),
          //               type: PageTransitionType.fade));
          //     },
          //   )
          // ],
        ),
        drawer: MainDrawer(),
        body: PageView(
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              selectedItem = index;
              
            });
          },
          controller: _pageController,
        ),
        bottomNavigationBar: BubbledNavigationBar(
          defaultBubbleColor: Colors.white,
          backgroundColor: Hexcolor('172634'),
          initialIndex: selectedItem,
          controller: _menuPositionController,
          itemMargin: EdgeInsets.symmetric(horizontal: 0),
          iconRightMargin: 10,
          onTap: (index) {
            var duration = 600;
            var curveStyle = Curves.easeInOutQuad;
            if ((index == 0 && selectedItem == 3) ||
                (index == 3 && selectedItem == 0)) {
              duration = 1000;
            }
            if ((index - selectedItem) == 2 || (selectedItem - index) == 2) {
              duration = 800;
            }
            _pageController.animateToPage(
              index,
              curve: curveStyle,
              duration: Duration(milliseconds: duration),
            );
          },
          items: <BubbledNavigationBarItem>[
            BubbledNavigationBarItem(
              icon: Icon(Icons.home, size: 30, color: Colors.white),
              activeIcon: Icon(
                Icons.home,
                size: 30,
                color: Hexcolor('172634'),
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Hexcolor('172634'), fontSize: 12),
              ),
            ),
            BubbledNavigationBarItem(
              icon: Icon(Icons.school, size: 30, color: Colors.white),
              activeIcon: Icon(
                Icons.school,
                size: 30,
                color: Hexcolor('172634'),
              ),
              title: Text(
                'Education',
                style: TextStyle(
                    color: Hexcolor('172634'),
                    fontFamily: 'Raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    letterSpacing: .5),
              ),
            ),
            BubbledNavigationBarItem(
              icon: Icon(Icons.people, size: 30, color: Colors.white),
              activeIcon: Icon(
                Icons.people,
                size: 30,
                color: Hexcolor('172634'),
              ),
              title: Text(
                'About us',
                style: TextStyle(
                    color: Hexcolor('172634'),
                    fontFamily: 'Raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    letterSpacing: .5),
              ),
            ),
            BubbledNavigationBarItem(
              icon: Icon(Icons.person, size: 30, color: Colors.white),
              activeIcon: Icon(
                Icons.person,
                size: 30,
                color: Hexcolor('172634'),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Hexcolor('172634'),
                    fontFamily: 'Raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    letterSpacing: .5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Color(0xFF161F28),
            title: Text(
              'Are you sure?',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: _dialogBtn('No'),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: _dialogBtn('Yes'),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ) ??
        false;
  }
}

Widget _dialogBtn(String yRN) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Text(
      yRN,
      style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16),
    ),
  );
}
