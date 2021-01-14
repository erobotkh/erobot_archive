import 'package:erobot_app/import/importall.dart';
import 'package:video_player/video_player.dart';

class DocumentTemplate extends StatefulWidget {
  final index;
  DocumentTemplate(this.index);
  @override
  _DocumentTemplateState createState() => _DocumentTemplateState(index);
}

class _DocumentTemplateState extends State<DocumentTemplate> {
  final int index;
  VideoPlayerController playerController;
  VoidCallback listener;

  _DocumentTemplateState(this.index);
  @override
  Widget build(BuildContext context) {
    Document docs = doc[0];
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //SLIVER APP BAR
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: 400,
              floating: false,
              pinned: true,
              //APP BAR BACKGROUND
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'document-image-uniqe-$index',
                  child: Image.asset(
                    'assets/home/arduino_doc.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //APP BAR
              title: Text(
                'Document',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              bottom: TitleCard(
                'How to change Name and Password of HC-05',
                'Suy Kosal',
                '12 May 2020',
              ),
            ),
          ];
        },

        //BODY
        body: ScrollConfiguration(
          //HIDE SCROLL END EFFECT
          behavior: ScrollBehavior()
            ..buildViewportChrome(
              context,
              null,
              AxisDirection.down,
            ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //SECTION 1 - DEMO VIDEO
                SectionLabel('Demo Video'),
                ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset(
                    "assets/video/video1.mp4",
                  ),
                ),
                SizedBox(height: 8),

                //SECTION2 - COMPONENT USED
                SectionLabel('Component Used'),
                ImageListHorizontal(
                  context: context,
                  widthContainer: 0.35,
                  section: 2,
                  doc: docs,
                ),
                SizedBox(height: 8),

                //SECTION 3 - SOFTWARE USED
                SectionLabel('Software Used'),
                ImageListHorizontal(
                  context: context,
                  widthContainer: 0.35,
                  section: 3,
                  doc: docs,
                ),
                SizedBox(height: 5),

                //SETION 4 - ALL STEPS
                for (int i = 0; i < steps.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SectionLabel("Step ${i + 1}"),
                      Paragraph(steps[i].text),
                      steps[i].picture != null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.fromLTRB(
                                15,
                                5,
                                15,
                                5,
                              ),
                              child: Image.asset(
                                'assets/document/step/${steps[i].picture}',
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : Container(),
                    ],
                  ),

                //SECTION 5 - VIDEO TUTORIAL
                SectionLabel('Tutorial Video'),
                ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset(
                    "assets/video/video1.mp4",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
