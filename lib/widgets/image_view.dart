import 'package:erobot_app/import/importall.dart';
import 'package:erobot_app/widgets/networkimage.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key key,
    @required this.pageController,
    @required this.imageList,
    @required this.width,
    @required this.currentImage,
    this.onPageChanged,
  }) : super(key: key);

  final PageController pageController;
  final List<String> imageList;
  final double width;
  final int currentImage;
  final Function onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          allowImplicitScrolling: true,
          onPageChanged: onPageChanged,
          children: [
            for (int index = 0; index < imageList.length; index++)
              buildImage(
                index: index,
                child: NetworkImageLoader(
                  imagelocation: imageList[index],
                  onPressed: () {},
                ),
              )
          ],
        ),
        Positioned(
          right: 20,
          top: 280,
          child: Container(
            width: (10.0 + 5) * imageList.length,
            height: 10,
            alignment: Alignment.centerRight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: currentImage == index ? 10 : 8,
                    height: currentImage == index ? 10 : 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentImage == index ? Palette.blueFacebook : Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container buildImage({int index, Widget child}) {
    return Container(
      width: width,
      height: 150 + 48.0,
      child: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned.fill(
            child: FlatButton(
              highlightColor: Colors.white.withOpacity(0.2),
              splashColor: Colors.black.withOpacity(0.2),
              onPressed: () {
                print(index);
                print(imageList.length);
                if (index == imageList.length - 1) {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                } else {
                  pageController.animateToPage(
                    index + 1,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}
