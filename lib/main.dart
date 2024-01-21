import 'dart:io';

import 'package:atba_application/features/feature_charge_sim/data/models/sim_charge_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:receive_intent/receive_intent.dart';

import 'config/themes/app_theme.dart';
import 'core/utils/strings.dart';
import 'features/feature_login/presentation/bloc/login_bloc.dart';
import 'features/feature_login/presentation/screens/login_screen_view.dart';
import 'features/feature_splash/presentation/screens/splash_screen_view.dart';
import 'locator.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;




Future<void> main() async {

  await setup();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(SimChargeTransactionAdapter());
  await Hive.openBox<SimChargeTransaction>('sim_charge_transaction');





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






