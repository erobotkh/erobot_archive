import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      '   ' + text,
      style: TextStyle(
        color: Palette.shark,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String paragraph;
  const Paragraph(this.paragraph);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
        bottom: 5,
      ),
      child: Text(paragraph),
    );
  }
}
