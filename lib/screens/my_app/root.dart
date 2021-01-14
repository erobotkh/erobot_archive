import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/widgets/bottom_navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:provider/provider.dart';

//ROOT PAGE
class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  int tabIndex = 0;
  bool userPageDragging = false;

  //CONTROLLER
  PageController _pageController;
  TabController _tabController;
  ScrollController _scrollViewController;

  List<int> blockList = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    _pageController = PageController(
      initialPage: pageIndex,
      keepPage: true,
      viewportFraction: 1,
    )..addListener(_listener);

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: tabIndex,
    );

    _scrollViewController = ScrollController();
    super.initState();
  }

  //clear blocklist on swap
  _listener() {
    if (_pageController.position.userScrollDirection ==
            ScrollDirection.reverse ||
        _pageController.position.userScrollDirection ==
            ScrollDirection.forward) {
      blockList.clear();
    }
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final List<String> titleName = [
    'E-Robot',
    'Education',
    'About Us',
    'Profile'
  ];
  @override
  Widget build(BuildContext context) {
    //ROOT PAGE
    return ScrollConfiguration(
      //ScrollConfiguration IS USED TO HIDE SCROLL EFFECT (WHITE EFFECT)
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: ChangeNotifierProvider(
          create: (e) => PageOffsetNotifier(_pageController),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(),
            drawer: MainDrawer(),
            body: Container(
              //PRELOAD : TO ENSURE PAGES ARE LOADED BEFORE USABLE
              child: PageView(
                children: <Widget>[
                  HomeScreen(),
                  ArduinoDoc(),
                  AboutUs(
                    tabController: _tabController,
                    tabIndex: tabIndex,
                  ),
                  Profile()
                ],
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => pageIndex = index);
                },
              ),
            ),
            //BOTTOM NAVIGATION
            bottomNavigationBar: AnimatedBottomNavigation(
              currentPage: pageIndex,
              blocklist: blockList,
              onTab: (index) => onBottomTab(index),
            ),
          ),
        ),
      ),
    );
  }

  void onBottomTab(_index) async {
    //remove text from bottom bar if in blocklist
    if (pageIndex - _index > 1) {
      blockList.remove(_index);
      blockList.add(pageIndex - 1);
      if (pageIndex - _index > 2) blockList.add(pageIndex - 2);
    }
    if (_index - pageIndex > 1) {
      blockList.remove(_index);
      blockList.add(_index - 1);
      if (_index - pageIndex > 2) blockList.add(_index - 2);
    }
    if (_index - pageIndex == 1 || (pageIndex - _index == 1))
      blockList.remove(_index);

    blockList = blockList.toSet().toList();
    for (int t in blockList) print(t);

    var duration = 400;
    if ((_index == 3 && pageIndex == 0) || (_index == 0 && pageIndex == 3))
      duration = duration * 2;
    if ((_index - pageIndex) == 2 || (pageIndex - _index) == 2)
      duration = duration;
    else
      duration = duration - 250;

    await _pageController.animateToPage(
      _index,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: duration + 300),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: pageIndex >= 2 ? 0 : 5,
      leading: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Builder(
          builder: (context) => IconButton(
            icon: FaIcon(
              FontAwesomeIcons.alignLeft,
              size: 20,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          return Opacity(
            opacity: (1 - notifier.page % 1) / 2 >= 0.25
                ? 1 - notifier.page % 1
                : notifier.page % 1,
            child: child,
          );
        },
        child: Row(
          children: [
            Text(
              titleName[pageIndex],
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  //HUDDLE BACK PRESSED
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
                fontSize: 18,
              ),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
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
              SizedBox(width: 10)
            ],
          ),
        ) ??
        false;
  }
}
