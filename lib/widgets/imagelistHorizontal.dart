import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/data/arduino_docs.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/models/document_models.dart';

class ImageListHorizontal extends StatelessWidget {
  const ImageListHorizontal({
    Key key,
    @required this.context,
    @required this.widthContainer,
    @required this.section,
    @required this.doc,
  }) : super(key: key);

  final BuildContext context;
  final double widthContainer;
  final int section;
  final Document doc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: section == 2 ? components.length : software.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 2, 8),
            child: Container(
              // COMPONENT OR SOFTWARE USED
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  ' ' +
                      (section == 2
                          ? components[index].name
                          : software[index].name) +
                      ' ',
                  style: TextStyle(
                    backgroundColor: Palette.blue_pacific,
                    color: Colors.white,
                  ),
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
                  image: AssetImage(section == 2
                      ? 'assets/document/components/${components[index].path}'
                      : 'assets/document/software/${software[index].path}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
