import 'package:flutter/material.dart';
import 'package:local_share/core/theme/light_color.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightColor.activeColor
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColor.bgColor,
    selectedItemColor: LightColor.activeColor,
    unselectedItemColor: LightColor.subTitleTextColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)
  )
);
