import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0; //0 to width size
  double _page = 0; //1 or 0
  ScrollDirection _scrollDirection;

  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      _scrollDirection = pageController.position.userScrollDirection;
      notifyListeners();
      _listener(pageController);
    });
  }

  void _listener(PageController pageController){
    _scrollDirection = pageController.position.userScrollDirection; 
  }

  double get offset => _offset;
  double get page => _page;
  ScrollDirection get scrollDerection  => _scrollDirection;
}
