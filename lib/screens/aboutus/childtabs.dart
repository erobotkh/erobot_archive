import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class AboutMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('members').snapshots(),
        builder: (context, snapshot) {
          List<Member> erobotmembers = List();
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((element) {
              erobotmembers.add(Member(
                name: element.data()['name'],
                path: element.data()['path'],
                role: element.data()['role'],
                fb: element.data()['fb'],
                tele: element.data()['tele'],
              ));
            });
          }
          return ListView.builder(
            itemCount: erobotmembers.length,
            itemBuilder: (context, index) {
              Member member = erobotmembers[index];
              return Consumer<PageOffsetNotifier>(
                builder: (context, notifier, child) {
                  return Opacity(
                      opacity: notifier.page > 2
                          ? math.max(0, -notifier.page % 1)
                          : notifier.page != 2
                              ? math.max(0, notifier.page % 1)
                              : 1,
                      child: child);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: index == erobotmembers.length - 1 ? 16.0 : 0,
                  ),
                  child: ProfileCard(
                    name: member.name,
                    role: member.role,
                    image: member.path,
                    onFBpressed: () {},
                    onTGpressed: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TeamReputation extends StatelessWidget {
  const TeamReputation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('team_reputation')
              .snapshots(),
          builder: (context, snapshot) {
            List<Event> event = List();
            if (snapshot.hasData) {
              snapshot.data.docs.forEach(
                (element) {
                  event.add(
                    Event(
                      article1: element.data()['article1'],
                      article2: element.data()['article2'],
                      authur: element.data()['authur'],
                      date: element.data()['date'],
                      image: element.data()['image'],
                      name: element.data()['name'],
                      refpath: element.reference.path,
                    ),
                  );
                },
              );
            }
            return ListView.builder(
              itemCount: event.length,
              itemBuilder: (context, index) {
                Event card = event[index];
                return Consumer<PageOffsetNotifier>(
                  builder: (context, notifier, child) {
                    return Opacity(
                      opacity: notifier.page > 2
                          ? math.max(0, -notifier.page % 1)
                          : notifier.page != 2
                              ? math.max(0, notifier.page % 1)
                              : 1,
                      child: child,
                    );
                  },
                  child: EventCard(
                    name: card.name,
                    role: card.date,
                    pathIMG: card.image,
                    index: index,
                    context: context,
                    onPressed: () {
                      print('see more clicked $index');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutTeamTemplate(event[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
