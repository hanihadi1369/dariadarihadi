import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_intent/receive_intent.dart';

import 'config/themes/app_theme.dart';
import 'core/utils/strings.dart';
import 'features/feature_login/presentation/bloc/login_bloc.dart';
import 'features/feature_login/presentation/screens/login_screen_view.dart';
import 'features/feature_splash/presentation/screens/splash_screen_view.dart';
import 'locator.dart';




Future<void> main() async {

  await setup();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: AppTheme.light,
      home: SplashScreenView()
    );
  }










}






