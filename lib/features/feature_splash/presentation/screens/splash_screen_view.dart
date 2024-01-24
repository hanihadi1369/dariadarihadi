import 'dart:ui';

import 'package:atba_application/features/feature_charge_sim/presentation/screens/sim_charge_screen_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/fade_transition.dart';
import '../../../../core/utils/slide_right_transition.dart';
import '../../../../core/utils/token_keeper.dart';
import '../../../../locator.dart';
import '../../../feature_login/presentation/bloc/login_bloc.dart';
import '../../../feature_login/presentation/screens/login_screen_view.dart';
import '../../../feature_main/presentation/bloc/main_bloc.dart';
import '../../../feature_main/presentation/screens/main_screen_view.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();


    Future.delayed(Duration(milliseconds: 5000), () {



      TokenKeeper.getAccessToken().then(
            (token) async {
          print(token);
          TokenKeeper.accesstoken = token;


          //todo should check expiration date
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                // return   BlocProvider(
                //                   create: (_)=>  locator<LoginBloc>(),
                //                   child: LoginScreenView(),
                //                 );



                return (token.isEmpty) ?
                BlocProvider(
                  create: (_)=>  locator<LoginBloc>(),
                  child: LoginScreenView(),
                )
                    :
                BlocProvider(
                  create: (_)=> locator<MainBloc>(),
                  child: MainScreenView(),
                );




              },
            ),
          );









        },
      );
























    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style to fullscreen.
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Visibility(
                      visible: false,
                      child: Image.asset(
                        'assets/image_icon/splash_top.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  )).animate().fade(
                      delay: 2000.ms, duration: 750.ms, begin: 1.0, end: 0.0),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Visibility(
                      visible: false,
                      child: Image.asset(
                        'assets/image_icon/splash_down.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  )).animate().fade(
                      delay: 2000.ms, duration: 750.ms, begin: 0.0, end: 1.0),
                )
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

                        child:
                            Padding(
                              padding: const EdgeInsets.only(left: 32,right: 32),
                              child: Image.asset('assets/image_icon/moba_des_icon.png', fit: BoxFit.scaleDown,),
                            ),
                      ).animate().move(
                          delay: 2000.ms,
                          duration: 750.ms,
                          begin: Offset(0, 400),
                          end: Offset(0, 60)),
                      // Container(
                      //   child: Text(
                      //     "موبایل   بانک   اتباع",
                      //     style: TextStyle(
                      //         fontFamily: "Snapp",
                      //         fontWeight: FontWeight.normal,
                      //         color: Colors.black,
                      //         fontSize: 15),
                      //   ),
                      // )
                      //     .animate()
                      //     .move(
                      //         delay: 2000.ms,
                      //         duration: 750.ms,
                      //         begin: Offset(0, 400),
                      //         end: Offset(0, 60))
                      //     .fade(
                      //         delay: 2000.ms,
                      //         duration: 1500.ms,
                      //         begin: 0.0,
                      //         end: 1.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
