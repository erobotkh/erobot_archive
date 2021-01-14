import 'package:erobot_app/import/importall.dart';
import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String imagelocation;
  final Function onPressed;
  final double width;
  final double height;
  const NetworkImageLoader(
      {Key key,
      @required this.imagelocation,
      @required this.onPressed,
      this.width = 110,
      this.height = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Palette.bigstone,
      child: Image.network(
        imagelocation,
        width: width,
        height: height,
        fit: BoxFit.cover,
        frameBuilder: (
          BuildContext context,
          Widget child,
          int frame,
          bool wasSynchronouslyLoaded,
        ) {
          return wasSynchronouslyLoaded
              ? child
              : AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          print(exception);
          return FlatButton(
            height: height,
            minWidth: width,
            color: Palette.bigstone,
            onPressed: onPressed,
            child: Icon(Icons.error, color: Palette.red_milano),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Palette.bigstone,
            alignment: Alignment.center,
            child: Container(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
