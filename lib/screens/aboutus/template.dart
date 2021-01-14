import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/widgets/image_view.dart';

class AboutTeamTemplate extends StatefulWidget {
  final Event event;
  AboutTeamTemplate(this.event);
  @override
  _AboutTeamTemplateState createState() => _AboutTeamTemplateState();
}

class _AboutTeamTemplateState extends State<AboutTeamTemplate> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    Event eventData = widget.event;
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //SLIVER APP BAR
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              //APP BAR BACKGROUND
              flexibleSpace: FlexibleSpaceBar(
                background: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .doc(widget.event.refpath)
                        .collection('memoriesImage')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<String> images = List();
                      if (snapshot.hasData) {
                        snapshot.data.docs.forEach((element) {
                          images.add(element.data()['image']);
                        });
                      }
                      return ImageViewer(
                        imageList: images,
                        pageController: _pageController,
                        currentImage: _imageIndex,
                        width: MediaQuery.of(context).size.width,
                        onPageChanged: (index) {
                          setState(() {
                            _imageIndex = index;
                          });
                        },
                      );
                    }),
              ),
              //APP BAR
              title: Text(
                eventData.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              bottom: EventCardOnClass(eventAcc: eventData),
            ),
          ];
        },
        //HIDE SCROLL END EFFECT
        body: ScrollConfiguration(
          behavior: ScrollBehavior()
            ..buildViewportChrome(context, null, AxisDirection.down),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
                //SECTION 1 - MEMORIES

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .doc(eventData.refpath)
                        .collection('articles')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<String> article = List();

                      if (snapshot.hasData) {
                        snapshot.data.docs.forEach((element) {
                          article.add(element.data()['article']);
                        });
                      }
                      return Column(
                        children: [
                          for (int index = 0; index < article.length; index++)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: paragraph(article[index]),
                            ),
                        ],
                      );
                    }),

                //SECTION2 - PARTICIPATING MEMBERS
                sectionLabel('Participating Members'),
                buildListView(0.35, eventData.refpath + "/member"),
                SizedBox(height: 8),

                //SECTION 3 - ROBOT USED
                sectionLabel('Robots used at the Event'),
                buildListView(0.35, eventData.refpath + "/robots"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //ALL METHODs STORE USED IN THIS TEMPLETE

  //SECTION LABEL TEXT
  Text sectionLabel(String text) {
    return Text(
      '   ' + text,
      style: TextStyle(
        color: Palette.shark,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  //PARAGRAPH
  Padding paragraph(String paragraph) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Text(paragraph),
    );
  }

  //AUTHOR
  RichText author(String author) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Color.fromRGBO(22, 31, 40, 1),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        children: <TextSpan>[
          TextSpan(text: '    '),
          TextSpan(text: 'Written by '),
          TextSpan(
            text: author,
            style: TextStyle(color: Palette.blue_pacific),
          ),
        ],
      ),
    );
  }

  //IMAGE LIST WITH HORIZONTAL SCROLL
  Container buildListView(double widthContainer, String path) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(path).snapshots(),
          builder: (context, snapshot) {
            List<String> name = List();
            List<String> image = List();

            if (snapshot.hasData) {
              snapshot.data.docs.forEach((element) {
                name.add(element.data()['name']);
                image.add(element.data()['image']);
              });
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: name.length,
              itemBuilder: (context, index) {
                //CLICK TO CHANGE IMAGE (SECTION 1 ONLY)
                return Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 2, 8),
                  child: Container(
                    // IF == SECTION 1 => NO NAME ON IMAGE
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        ' ' + name[index] + ' ',
                        style: TextStyle(
                            backgroundColor: Palette.blue_pacific,
                            color: Colors.white),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * widthContainer,

                    //BACKGROUND IMAGE WITH SHADOW
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(image[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

class EventCardOnClass extends StatelessWidget implements PreferredSizeWidget {
  final Event eventAcc;
  const EventCardOnClass({
    Key key,
    this.eventAcc,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 10.0, 0.0, 10.0),
            child: Container(
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //EVENT IMAGE
                  Hero(
                    tag: 'even-logo-${eventAcc.image}',
                    child: Image.network(
                      eventAcc.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //EVENT NAME AND TITLE
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //EVENT NAME
                          Text(
                            eventAcc.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          //EVENT DATE
                          Text(
                            eventAcc.date,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
