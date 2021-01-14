import 'package:erobot_app/import/importall.dart';

class TitleCard extends StatelessWidget implements PreferredSizeWidget {
  const TitleCard(
    this.title,
    this.author,
    this.date,
  );

  final String title;
  final String date;
  final String author;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        kToolbarHeight,
      ), //kToolbarHeight has same constant that AppBar uses.
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 10.0, 0.0, 10.0),
              child: Container(
                height: 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //EVENT NAME
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Author(
                      author: author,
                      fontSize: 12,
                    ),
                    SizedBox(height: 5),
                    // DATE
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
