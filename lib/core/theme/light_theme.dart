import 'package:flutter/material.dart';
import 'package:local_share/core/theme/light_color.dart';

final textStyle = TextStyle();

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: LightColor.bgColor,

  colorScheme: ColorScheme.light(
    primary: LightColor.activeColor,
    onPrimaryContainer: LightColor.bgColor,


    secondary: LightColor.onlineColor,
    onSecondary: LightColor.subTitleTextColor,

    tertiary: LightColor.offlineColor,


    error:  LightColor.errorColor,
  


  ),


  textTheme: TextTheme(
    titleLarge: textStyle.copyWith(fontWeight: FontWeight.bold),
    bodySmall: textStyle.copyWith(color: LightColor.subTitleTextColor)
  ),

  dividerTheme: DividerThemeData(
    color: LightColor.subTitleTextColor.withOpacity(0.2)
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColor.bgColor,
    selectedItemColor: LightColor.activeColor,
    unselectedItemColor: LightColor.subTitleTextColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)
  )
);
