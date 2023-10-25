import 'dart:convert';
import 'dart:io';
import 'package:atba_application/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:atba_application/features/feature_login/presentation/screens/login_screen_view.dart';
import 'package:atba_application/features/feature_main/presentation/screens/main_screen_view.dart';
import 'package:atba_application/features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'package:atba_application/features/feature_profile/presentation/screens/profile_screen_view.dart';
import 'package:atba_application/features/unbounded_features/about_contructor_screen_view.dart';
import 'package:atba_application/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/feature_main/presentation/bloc/main_bloc.dart';
import '../../features/feature_splash/presentation/screens/splash_screen_view.dart';
import '../../features/unbounded_features/aboutus_screen_view.dart';

import '../utils/colors.dart';
import '../utils/slide_right_transition.dart';
import '../utils/token_keeper.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 3, child: Container()),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Image.asset(
                          'assets/image_icon/moba_main_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      )),
                  Expanded(flex: 1, child: Container()),
                  Divider(
                    thickness: 1,
                  ),
                  Expanded(
                      flex: 13,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider.value(
                                        value: locator<ProfileBloc>(),
                                        child: ProfileScreenView(
                                          int.parse(
                                              MainScreenViewState.balance!),
                                          MainScreenViewState.firstName!,
                                          MainScreenViewState.lastName!,
                                          MainScreenViewState.phoneNumber!,
                                          MainScreenViewState.nationalCode!,
                                          MainScreenViewState.email!,
                                          MainScreenViewState.iban!,
                                        ),
                                      );
                                    },
                                  ),
                                ).then((value) => {
                                      BlocProvider.of<MainBloc>(context)
                                          .add(GetBalanceEvent()),
                                      BlocProvider.of<MainBloc>(context)
                                          .add(GetProfileEvent()),
                                      Navigator.of(context).pop()
                                    });

                                // await Navigator.push(
                                //   context,
                                //   SlideRightRoute(
                                //     page: ProfileScreenView(int.parse(MainScreenViewState.balance!),MainScreenViewState.firstName!,MainScreenViewState.lastName!,MainScreenViewState.phoneNumber!),
                                //   ),
                                // );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "پروفایل من",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/image_icon/my_profile_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "فعالیت های من",
                                      style: TextStyle(fontSize: 17, color: Colors.black38),
                                    ),
                                    Container(
                                      foregroundDecoration: BoxDecoration(
                                        color:  Color(0xa39c9c9c),
                                        backgroundBlendMode: BlendMode.saturation,
                                      ),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                          'assets/image_icon/my_activites_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "سایت اتباع",
                                      style: TextStyle(fontSize: 17, color: Colors.black38),
                                    ),
                                    Container(
                                      foregroundDecoration: BoxDecoration(
                                        color:  Color(0xa39c9c9c),
                                        backgroundBlendMode: BlendMode.saturation,
                                      ),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                          'assets/image_icon/atba_site_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "خبرنامه اتباع",
                                      style: TextStyle(fontSize: 17, color: Colors.black38),
                                    ),
                                    Container(
                                      foregroundDecoration: BoxDecoration(
                                        color:  Color(0xa39c9c9c),
                                        backgroundBlendMode: BlendMode.saturation,
                                      ),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.asset(
                                          'assets/image_icon/atba_news_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).pop();
                                await Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: AboutConstructorScreenView()),
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "درباره سازنده",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/image_icon/about_us_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).pop();
                                await Navigator.push(
                                  context,
                                  SlideRightRoute(page: AboutUsScreenView()),
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "ارتباط با ما",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/image_icon/contact_us_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        contentPadding:
                                            EdgeInsets.only(top: 10.0),
                                        content: Container(
                                          padding: EdgeInsets.only(
                                              left: 8, right: 8),
                                          width: 300.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              Text(
                                                "آیا نسبت به خروج از حساب کاربری خود اطمینان دارید؟",
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        child: Text(
                                                          "خیر",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color:
                                                                  Colors.red),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    thickness: 10,
                                                    color: Colors.black54,
                                                    width: 2,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        //todo should disable this feature and implement logout mechanisim seperatly in ui
                                                        TokenKeeper
                                                                .deleteAccessToken()
                                                            .then(
                                                                (value) async {
                                                          // Navigator.pushAndRemoveUntil<dynamic>(
                                                          //   context,
                                                          //   MaterialPageRoute<dynamic>(
                                                          //     builder: (BuildContext context) => SplashScreenView(),
                                                          //   ),
                                                          //       (route) => false,//if you want to disable back feature set to false
                                                          // );

                                                          await Navigator
                                                              .pushReplacement(
                                                            context,
                                                            SlideRightRoute(
                                                              page:
                                                                  SplashScreenView(),
                                                            ),
                                                          );

                                                          // if (Platform.isAndroid) {
                                                          //   // SystemNavigator.pop();
                                                          //   // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                                          //   // exit(0);
                                                          // } else if (Platform
                                                          //     .isIOS) {
                                                          //   exit(0);
                                                          // }
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        child: Text(
                                                          "بله",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: MyColors
                                                                  .button_bg_enabled),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "خروج",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'assets/image_icon/logout_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(flex: 6, child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
