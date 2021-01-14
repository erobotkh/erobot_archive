import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:erobot_app/screens/aboutus/childtabs.dart';
import 'package:erobot_app/config/palette.dart';

//ABOUT US SCREEN WITH TWO TABS
class AboutUs extends StatelessWidget {
  const AboutUs({
    Key key,
    @required TabController tabController,
    @required this.tabIndex,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Palette.bigstone,
        //CENTERING APP BAR
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            kToolbarHeight,
          ),
          //kToolbarHeight HAS SAME CONSTANT THAT AppBar USES.
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Palette.bigstone,
                  blurRadius: 30.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                  // MOVE TO (RIGHT HORIZONTALLY, BOTTOM VERTICALLY)
                )
              ],
            ),
            //TAB BAR
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
                      fontSize: 15,
                    ),
                    indicatorColor: Colors.white,
                    tabs: <Widget>[
                      Tab(text: 'About Member'),
                      Tab(text: 'Team Reputation'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        //MERGE TAB VIEW WITH PAGE VIEW
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            AboutMember(),
            TeamReputation(),
          ],
        ),
      ),
    );
  }
}
