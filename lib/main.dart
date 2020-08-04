import 'dart:async';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:flutter/gestures.dart';

//Screens
import 'package:erobot_app/screens/arduino_doc/arduino_doc.dart';
import 'package:erobot_app/screens/sender/sender.dart';
import 'package:erobot_app/screens/controller/ball_shooter.dart';
import 'package:erobot_app/screens/controller/arduino_car.dart';
import 'package:erobot_app/screens/ir_remoter/ir_remoter.dart';
import 'package:erobot_app/screens/home_page/home.dart';
import 'package:erobot_app/screens/drawer_bar/feedback.dart';
import 'package:erobot_app/screens/login_page/log_choice.dart';
import 'package:erobot_app/screens/login_page/login.dart';
import 'package:erobot_app/screens/drawer_bar/main_drawer.dart';
import 'package:erobot_app/screens/farm_assistant/farm_assistant.dart';
import 'package:erobot_app/screens/aboutus/about_member.dart';
import 'package:erobot_app/screens/aboutus/team_reputation.dart';

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
      builder: (context, navigator) {
        var lang = Localizations.localeOf(context).languageCode;
        return Theme(
          data: ThemeData(
            fontFamily: lang == 'kh' ? 'Hanuman' : 'Raleway',
            primarySwatch: colorCustom,
            canvasColor: colorCustom2,
          ),
          child: navigator,
        );
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/loginC': (context) => LogInChoice(),
        '/loginP': (context) => LoginPage(),
        '/farm_assistant': (context) => FarmAssistant(),
        '/sender': (context) => Sender(),
        '/shooter': (context) => BallShooter(),
        '/ard_car': (context) => ArduinoCar(),
        '/ir_remote': (context) => IrRemoter(),
        '/feedback': (context) => FeedbackApp(),
      },
    ));

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final delay = 5;

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
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
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

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  int tabIndex = 0;
  bool userPageDragging = false;

  //Controller
  PreloadPageController _pageController;
  MenuPositionController _menuPositionController;
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController = PreloadPageController(
        initialPage: pageIndex, keepPage: true, viewportFraction: 1);
    _pageController.addListener(handlePageChange);

    _tabController =
        TabController(length: 2, vsync: this, initialIndex: tabIndex);
    _tabController.addListener(handleTabChange);

    _scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    _menuPositionController.dispose();
    super.dispose();
  }

  List<String> titleName = ['E-Robot', 'Education', 'About Us', 'Profile'];

  void handleTabChange() {
    setState(() {
      tabIndex == 0 ? tabIndex = 1 : tabIndex = 0;
    });
    print('Tab Change $tabIndex');
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    DefaultTabController aboutUs = DefaultTabController(
        //ABOUT US
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Hexcolor('172634'),
          //Centering the tab bar
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                kToolbarHeight), //kToolbarHeight has same constant that AppBar uses.
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Hexcolor('172634'),
                    blurRadius: 30.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(0.0, 0.0),
                    // Move to (right horizontally, bottom vertically)
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      dragStartBehavior: DragStartBehavior.start,
                      labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      indicatorColor: Colors.white,
                      tabs: <Widget>[
                        Tab(text: 'About Member'),
                        Tab(text: 'Team Reputation')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: NotificationListener(
            onNotification: (overscroll) {
              if (overscroll is UserScrollNotification &&
                  (overscroll.direction == ScrollDirection.forward ||
                      overscroll.direction == ScrollDirection.reverse)) {
                print('scrolling');
              } else if (overscroll is OverscrollNotification &&
                  overscroll.overscroll != 0 &&
                  overscroll.dragDetails != null) {
                print(overscroll.overscroll);
                if (overscroll.overscroll > 25 && tabIndex == 0) {
                  print('Scrolling on tab[0]');
                } else if (overscroll.overscroll > 25 && tabIndex == 1) {
                  print('Swaping on tab[1]');
                  _pageController.animateToPage(3,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 250));
                } else if (overscroll.overscroll < -25 && tabIndex == 0) {
                  print('Swapping on tab[0]');
                  _pageController.animateToPage(1,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 250));
                }
              }
              return true;
            },
            child: TabBarView(controller: _tabController, children: [
              AboutMember(),
              TeamReputation(),
            ]),
          ),
        ));

    //ROOT PAGE
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: pageIndex == 2 ? 0 : 5,
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
            titleName[pageIndex],
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
        drawer: MainDrawer(),
        body: Container(
          child: PreloadPageView(
            children: <Widget>[
              HomeScreen(),
              ArduinoDoc(),
              aboutUs,
              LogInChoice()
            ],
            physics: const AlwaysScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            preloadPagesCount: 4,
            controller: _pageController,
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          defaultBubbleColor: Colors.white,
          backgroundColor: Hexcolor('172634'),
          initialIndex: pageIndex,
          controller: _menuPositionController,
          itemMargin: EdgeInsets.symmetric(horizontal: 0),
          iconRightMargin: 10,
          onTap: (_index) async {
            var duration = 250;
            if (_index == 3 && pageIndex == 0) {
              await _pageController.animateToPage(2,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration));
              _pageController.animateToPage(3,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration + 100));
            }
            if (_index == 0 && pageIndex == 3) {
              await _pageController.animateToPage(1,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration));
              _pageController.animateToPage(0,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration + 100));
            }
            if ((_index - pageIndex) == 2 || (pageIndex - _index) == 2) {
              int _indexR;
              if (_index > pageIndex)
                _indexR = pageIndex;
              else
                _indexR = _index;
              await _pageController.animateToPage(_indexR + 1,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration));
              _pageController.animateToPage(_index,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration + 100));
            } else {
              _pageController.animateToPage(_index,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: duration + 100));
            }
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
          builder: (context) => AlertDialog(
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
                child: DialogBtn('No'),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: DialogBtn('Yes'),
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

class DialogBtn extends StatelessWidget {
  final String yRN;
  DialogBtn(this.yRN);

  @override
  Widget build(BuildContext context) {
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
}
