import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setThemeMod(ThemeMode? mode) {
    _themeMode = mode!;
    notifyListeners();
  }
}
