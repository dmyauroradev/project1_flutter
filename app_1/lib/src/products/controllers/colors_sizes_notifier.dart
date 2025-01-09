import 'package:flutter/material.dart';

class ColorSizesNotifier with ChangeNotifier {
  String _dimensions = '';

  String get dimensions => _dimensions;

  void setSizes(String s) {
    if (_dimensions == s) {
      _dimensions = '';
    } else {
      _dimensions = s;
    }

    notifyListeners();
  }

  String _code = '';

  String get code => _code;

  void setColor(String c) {
    if (_code == c) {
      _code = '';
    } else {
      _code = c;
    }

    notifyListeners();
  }
}
