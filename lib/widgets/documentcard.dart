import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';

class Author extends StatelessWidget {
  const Author({
    Key key,
    @required this.author,
    @required this.fontSize,
  }) : super(key: key);

  final String author;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Color.fromRGBO(22, 31, 40, 1),
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Written by '),
          TextSpan(
            text: author,
            style: TextStyle(color: Palette.blue_pacific),
          ),
        ],
      ),
    );
  }
}
