import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMod = ThemeMode.light;

  ThemeMode get themeMode => _themeMod;

  void setThemeMod(ThemeMode? themeMode) {
    _themeMod = themeMode!;
    notifyListeners();
  }
}
