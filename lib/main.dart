import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:local_share/core/router/router.dart';
import 'package:local_share/core/theme/dark_theme.dart';
import 'package:local_share/core/theme/light_theme.dart';
import 'package:local_share/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp.router(
        title: 'Local Share',
        theme: theme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
