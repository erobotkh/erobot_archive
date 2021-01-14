import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DocSection1 extends StatelessWidget {
  const DocSection1({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    double sizes = quiz.length < 5 ? 400.0 : 500;
    return Container(
      margin: EdgeInsets.fromLTRB(30, 17, 30, 10),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: sizes,
      decoration: BoxDecoration(
        color: Palette.appbar,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .3),
            offset: Offset(0, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            docs[index].title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            'After study, you will able to answer following question:',
            style: TextStyle(
              color: Colors.white,
              height: 1.3,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          IgnorePointer(
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              itemCount: quiz.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "${index + 1}, " + quiz[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FaIcon(
                FontAwesomeIcons.child,
                color: Palette.blue_pacific,
                size: 16,
              ),
              Text(
                ' 27 Learners',
                style: TextStyle(color: Palette.blue_pacific),
              ),
            ],
          )
        ],
      ),
    );
  }
}
