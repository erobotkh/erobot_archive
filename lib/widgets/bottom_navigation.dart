import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarItem {
  String item;
  IconData icon;
  BarItem({this.item, this.icon});
}

class AnimatedBottomNavigation extends StatefulWidget {
  final List<BarItem> barItem = [
    BarItem(item: 'Home', icon: Icons.home),
    BarItem(item: 'Education', icon: Icons.school),
    BarItem(item: 'About us', icon: Icons.people),
    BarItem(item: 'Profile', icon: Icons.person),
  ];

  final int currentPage;
  final Function onTab;
  final List<int> blocklist; //block bottom child

  AnimatedBottomNavigation(
      {Key key,
      @required this.onTab,
      @required this.currentPage,
      @required this.blocklist})
      : super(key: key);

  @override
  _AnimatedBottomNavigationState createState() =>
      _AnimatedBottomNavigationState();
}

class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation> {
  int selectedBar = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Palette.bigstone,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 10.0,
            spreadRadius: 1,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: AnimatedBottomBar(
        barItems: widget.barItem,
        currentIndex: widget.currentPage,
        blockList: widget.blocklist,
        animationDuration: const Duration(milliseconds: 1000),
        onTab: (index) {
          setState(() => selectedBar = index);
          widget.onTab(index);
        },
      ),
    );
  }
}

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onTab;
  final int currentIndex;
  final List<int> blockList;

  const AnimatedBottomBar({
    Key key,
    this.barItems,
    this.animationDuration = const Duration(milliseconds: 1000),
    @required this.onTab,
    @required this.currentIndex,
    @required this.blockList,
  }) : super(key: key);

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    //background of each bottom nav item (on selected)
    List<double> _itemWidth = [
      width * .3,
      widget.blockList.contains(widget.currentIndex)
          ? width * .35
          : width * .33,
      widget.blockList.contains(widget.currentIndex)
          ? width * .35
          : width * .33,
      width * .26,
    ];

    int _selectedIndex = widget.currentIndex;
    return Stack(
      children: [
        Consumer<PageOffsetNotifier>(
          builder: (context, notifier, child) {
            return Positioned(
              top: 10,
              left: widget.currentIndex != 3
                  ? notifier.offset * .21
                  : notifier.offset * .23,
              bottom: 10,
              child: child,
            );
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 40,
            width: _itemWidth[widget.currentIndex],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildBarItem(_selectedIndex),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBarItem(int _selectedIndex) {
    List<Widget> _barItem = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = _selectedIndex == i &&
          !widget.blockList.contains(
            _selectedIndex,
          );

      _barItem.add(
        InkWell(
          onTap: () async {
            setState(() => _selectedIndex = i);
            await widget.onTab(i);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  item.icon,
                  size: 30,
                  color: isSelected ? Palette.bigstone : Colors.white,
                ),
                SizedBox(width: 8.0),
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  vsync: this,
                  child: Text(
                    isSelected ? item.item : "",
                    style: TextStyle(
                      color: isSelected ? Palette.bigstone : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _barItem;
  }
}
