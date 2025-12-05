import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/router/router.dart';
import 'package:local_share/core/theme/dark_theme.dart';
import 'package:local_share/core/theme/light_theme.dart';
import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main_page.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/setting_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:logger/web.dart';

final logger = Logger();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsRepositoryImpl.instance.init();

  await DI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SendPageBloc()),
        BlocProvider(create: (context) => PickedFilesBloc()),
        BlocProvider(create: (context)=> SettingBloc(sharedRepo: getIt<SharedPrefsRepositoryImpl>())..add(SettingBlocEvent_load()))
      ],
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Local Share',
          theme: theme,
          darkTheme: darkTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
