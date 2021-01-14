import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double mediaWidth = MediaQuery.of(context).size.width;
    // double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StaggeredGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        children: <Widget>[
          ThreeLayerCard(
            title: 'Farm Assistant',
            desription: 'Make your farming smarter',
            cardIndex: 0,
            path: 'assets/home/arduino_doc.png',
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Palette.red_milano,
                  content: Text('Farm Assistant is in Development.'),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: "OK",
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            },
          ),
          ThreeLayerCard(
            title: 'Sender',
            desription: 'to Send text to arduino via Bluetooth',
            cardIndex: 1,
            path: 'assets/home/our_team.png',
            onPressed: () => Navigator.pushNamed(context, '/sender'),
          ),
          ThreeLayerCard(
            title: 'Ball Shooter',
            desription: 'to Control ball shooter arduino car, servo, and speed',
            cardIndex: 2,
            path: 'assets/home/ball_shooter.png',
            onPressed: () => buildtoCarController(context, 1),
          ),
          ThreeLayerCard(
            title: 'Arduino Car',
            desription: 'Remoter to Control Arduino Car with speed',
            cardIndex: 3,
            path: 'assets/home/car_runner.png',
            onPressed: () => buildtoCarController(context, 2),
          ),
          ThreeLayerCard(
            title: 'IR Remoter',
            desription: 'to Control Light and Buzzer Arduino',
            cardIndex: 4,
            path: 'assets/home/ir_controller.png',
            onPressed: () => Navigator.pushNamed(context, '/ir_remote'),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.fit(2),
          StaggeredTile.fit(1),
          StaggeredTile.fit(1),
          StaggeredTile.fit(1),
          StaggeredTile.fit(1),
        ],
      ),
    );
  }

  Future buildtoCarController(BuildContext context, int _cardIndex) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Controller(_cardIndex),
      ),
    );
  }
}
