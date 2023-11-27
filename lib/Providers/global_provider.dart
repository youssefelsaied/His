import 'dart:collection';

import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  List<int> stack = [];
  int currentIndex = 0;

  PageController mainCheckController = PageController(initialPage: 0);

  int popTheTop() {
    stack.removeLast();
    if (stack.isNotEmpty) {
      print(stack);
      currentIndex = stack[stack.length - 1];
      notifyListeners();
      return currentIndex;
    } else {
      stack.add(0);
      return 0;
    }
  }

  addToTheTop(int num) {
    stack.add(num);
    print(stack);
    currentIndex = num;
    notifyListeners();
  }

  initaial() {
    stack.add(0);
    currentIndex = 0;
  }

  nextPage() {
    mainCheckController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  previousPage() {
    mainCheckController.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }
}
