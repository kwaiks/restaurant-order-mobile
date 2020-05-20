import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme()=> _themeData;

  setTheme(bool isDark){
    if(isDark){
      _themeData = ThemeData.dark();
    }else{
      _themeData = whiteThemeData;
    }
    notifyListeners();
  }
}

ThemeData whiteThemeData = ThemeData (
  primaryColor: white,
  scaffoldBackgroundColor: Colors.white
);

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);