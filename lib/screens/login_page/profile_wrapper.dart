import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/import/importall.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:erobot_app/service/auth_service.dart';
import 'dart:math' as math;

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    print('init user: ' + user.toString());
    if (user == null)
      return LogInChoice(); //on bottom of this file
    else
      return UserProfileSetting(); //on top of log in choice
  }
}

class UserProfileSetting extends StatefulWidget {
  @override
  _UserProfileSettingState createState() => _UserProfileSettingState();
}

class _UserProfileSettingState extends State<UserProfileSetting>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: Wrap(
            children: [
              Container(
                height: 225,
                width: MediaQuery.of(context).size.width,
                color: Palette.bigstone,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Palette.blue_pacific, width: 5.0),
                        borderRadius: BorderRadius.circular(60 + 5.0),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/profiles/bot2.png'),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'user@erobot.kh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Palette.blue_pacific,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'Your Profile'),
                    Tab(text: 'Activities'),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Container(
              child: ListView(
                children: [
                  UserSettingTile(
                      onPressed: () {},
                      index: 0,
                      title: "Email",
                      subtitle: "user@erobot.kh",
                      icon: FontAwesomeIcons.envelope),
                  UserSettingTile(
                      onPressed: () {},
                      index: 1,
                      title: "Phone",
                      subtitle: "012 3456 78",
                      icon: FontAwesomeIcons.phoneAlt),
                  UserSettingTile(
                      onPressed: () {},
                      index: 2,
                      title: "Password",
                      subtitle: lengthToX(6),
                      icon: FontAwesomeIcons.lock),
                ],
              ),
            ),
            Consumer<PageOffsetNotifier>(
              builder: (context, notifier, child) {
                double offset =
                    MediaQuery.of(context).size.width * 3 - notifier.offset;
                return Transform.translate(
                  offset: Offset(offset * 0.4, 0),
                  child: Opacity(
                    opacity: notifier.page > 3
                        ? math.max(0, -notifier.page % 1)
                        : notifier.page != 3
                            ? math.max(0, notifier.page % 1)
                            : 1,
                    child: child,
                  ),
                );
              },
              child: Container(
                color: Palette.red_milano,
                child: Center(
                  child: Text(
                    "In construction",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String lengthToX(int length) {
    //*****/
    String xxx = "";
    for (int i = 0; i < 8; i++) xxx += "*";
    return xxx ?? "No Password";
  }
}

class UserSettingTile extends StatelessWidget {
  final String subtitle, title;
  final IconData icon;
  final Function onPressed;
  final int index;

  const UserSettingTile({
    Key key,
    @required this.subtitle,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: notifier.page > 3
              ? math.max(0, -notifier.page % 1)
              : notifier.page != 3 ? math.max(0, notifier.page % 1) : 1,
          child: child,
        );
      },
      child: ListTile(
        leading: FaIcon(
          icon,
          color: Palette.blue_pacific,
          size: 36,
        ),
        title: Text(
          title,
          style: TextStyle(color: Palette.blue_pacific),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
          ),
        ),
      ),
    );
  }
}

class LogInChoice extends StatefulWidget {
  @override
  _LogInChoiceState createState() => _LogInChoiceState();
}

class _LogInChoiceState extends State<LogInChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity =
              notifier.page < 3 ? notifier.page % 1 : 1 - notifier.page % 1;
          
          if(notifier.scrollDerection == ScrollDirection.forward){
            print("left");
          }
          return Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Opacity(
                  opacity: opacity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 2, top: 10, bottom: 3),
                    child: Text(
                      'WELCOME OUR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Opacity(opacity: opacity, child: TwoLayerCard()),
                SizedBox(height: 10),
                Opacity(
                  opacity: opacity,
                  child: Text(
                    'Member will have access all privilege to see post, oportunity, and team reputation',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Opacity(
                  opacity: opacity,
                  child: FlatTextButton(
                    isblue: true,
                    text: 'Login as member',
                    splashColor: Palette.blueSplash,
                    color: Palette.blue_pacific,
                    onPressed: () => Navigator.pushNamed(context, '/loginP'),
                  ),
                ),
                SizedBox(height: 10),
                Opacity(
                  opacity: opacity,
                  child: FlatTextButton(
                    text: 'Join Us',
                    onPressed: () => Navigator.pushNamed(context, '/joinus'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
