import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:atba_application/core/utils/colors.dart';
import 'package:atba_application/core/utils/slide_right_transition.dart';
import 'package:atba_application/core/widgets/drawer.dart';
import 'package:atba_application/core/widgets/loading.dart';
import 'package:atba_application/features/feature_bill/presentation/block/bill_bloc.dart'
    as billbloc;
import 'package:atba_application/features/feature_bill/presentation/screens/bills_screen_view.dart';
import 'package:atba_application/features/feature_charge_sim/presentation/screens/sim_charge_screen_view.dart';
import 'package:atba_application/features/feature_login/presentation/screens/login_screen_view.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/balance_status.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/main_bloc.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/profile_status.dart';
import 'package:atba_application/features/feature_profile/presentation/screens/profile_screen_view.dart';
import 'package:atba_application/features/feature_splash/presentation/screens/splash_screen_view.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/wallet_bloc.dart'
    as wallett;
import 'package:atba_application/features/feature_wallet/presentation/screens/wallet_screen_view.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/screens/internet_charge_screen_view.dart';
import 'package:atba_application/features/unbounded_features/bime_screen_view.dart';
import 'package:atba_application/features/unbounded_features/kbk_screen_view.dart';
import 'package:atba_application/features/unbounded_features/ticket_screen_view.dart';
import 'package:atba_application/features/unbounded_features/travel_screen_view.dart';
import 'package:atba_application/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/utils/my_utils.dart';
import '../../../../core/utils/token_keeper.dart';
import '../../../feature_charge_internet/presentation/block/charge_internet_bloc.dart'
    as cinternet;
import '../../../feature_charge_sim/presentation/block/charge_sim_bloc.dart'
    as csim;
import '../../../feature_login/presentation/bloc/login_bloc.dart';
import '../../../feature_profile/presentation/bloc/profile_bloc.dart';
import '../bloc/refresh_token_status.dart';

class MainScreenView extends StatefulWidget {
  @override
  MainScreenViewState createState() => MainScreenViewState();
}

class MainScreenViewState extends State<MainScreenView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  static String balance = "***";
  static String firstName = "***";
  static String lastName = "***";
  static String nationalCode = "***";
  static String email = "***";
  static String iban = "***";
  static String phoneNumber = "***";
  Uint8List? avatarProfile = null;

  @override
  void initState() {
    super.initState();
    _getPhoneNumber();
    BlocProvider.of<MainBloc>(context).add(GetBalanceEvent());
    BlocProvider.of<MainBloc>(context).add(GetProfileEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(32.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  padding:
                  EdgeInsets.only(left: 8, right: 8),
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
                        style: TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 20,
                                child: Text(
                                  "خیر",
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.red),
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
                                    .then((value) async {



                                  // Navigator.pushAndRemoveUntil<dynamic>(
                                  //   context,
                                  //   MaterialPageRoute<dynamic>(
                                  //     builder: (BuildContext context) => SplashScreenView(),
                                  //   ),
                                  //       (route) => false,//if you want to disable back feature set to false
                                  // );


                                  await Navigator.pushReplacement(
                                    context,
                                    SlideRightRoute(
                                      page: SplashScreenView(),
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
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        endDrawer: AppDrawer(),
        body: SafeArea(
          child: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (state.balanceStatus is BalanceError) {
                BalanceError error = state.balanceStatus as BalanceError;
                if (error.message == "عدم پاسخگویی سرور : شناسه نامعتبر") {
                  TokenKeeper.getRefreshToken().then((value) {
                    BlocProvider.of<MainBloc>(context)
                        .add(RefreshTokenEvent(value));
                    state.balanceStatus = BalanceInit();
                  });
                } else {
                  _showSnackBar(error.message);
                  state.balanceStatus = BalanceInit();
                }
              }
              if (state.profileStatus is ProfileError) {
                ProfileError error = state.profileStatus as ProfileError;
                if (error.message == "عدم پاسخگویی سرور : شناسه نامعتبر") {
                  state.profileStatus = ProfileInit();
                } else {
                  _showSnackBar(error.message);
                  state.profileStatus = ProfileInit();
                }
              }
              if (state.refreshTokenStatus is RefreshTokenError) {
                TokenKeeper.deleteAccessToken().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider.value(
                          value: locator<LoginBloc>(),
                          child: LoginScreenView(),
                        );
                      },
                    ),
                  );
                });
              }

              if (state.refreshTokenStatus is RefreshTokenCompleted) {
                RefreshTokenCompleted refreshTokenCompleted =
                    state.refreshTokenStatus as RefreshTokenCompleted;
                if (refreshTokenCompleted.refreshTokenEntity.isFailed == true) {
                  TokenKeeper.deleteAccessToken().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider.value(
                            value: locator<LoginBloc>(),
                            child: LoginScreenView(),
                          );
                        },
                      ),
                    );
                  });
                } else {
                  TokenKeeper.saveAccessToken(refreshTokenCompleted
                          .refreshTokenEntity.value!.tokens!.accesstoken!)
                      .then(
                    (value) => {
                      TokenKeeper.accesstoken = refreshTokenCompleted
                          .refreshTokenEntity.value!.tokens!.accesstoken!,
                      TokenKeeper.saveRefreshToken(refreshTokenCompleted
                              .refreshTokenEntity.value!.tokens!.refreshToken!)
                          .then(
                        (value) => {
                          TokenKeeper.refreshToken = refreshTokenCompleted
                              .refreshTokenEntity.value!.tokens!.refreshToken!,
                          TokenKeeper.saveRefreshTokenExpirationDate(
                                  refreshTokenCompleted.refreshTokenEntity.value!
                                      .tokens!.refreshTokenExpirationDate!)
                              .then(
                            (value) => {
                              TokenKeeper.refreshTokenExpirationDate =
                                  refreshTokenCompleted.refreshTokenEntity.value!
                                      .tokens!.refreshTokenExpirationDate!,
                              state.refreshTokenStatus = RefreshTokenInit(),
                              state.balanceStatus = BalanceInit(),
                              state.profileStatus = ProfileInit(),
                              _getPhoneNumber(),
                              BlocProvider.of<MainBloc>(context)
                                  .add(GetBalanceEvent()),
                              BlocProvider.of<MainBloc>(context)
                                  .add(GetProfileEvent()),
                            },
                          )
                        },
                      )
                    },
                  );
                }
              }
            },
            builder: (context, state) {
              if (state.balanceStatus is BalanceLoading ||
                  state.profileStatus is ProfileLoading ||
                  state.refreshTokenStatus is RefreshTokenLoading) {
                return LoadingPage();
              }
              if (state.balanceStatus is BalanceCompleted) {
                BalanceCompleted balanceCompleted =
                    state.balanceStatus as BalanceCompleted;
                if (balanceCompleted.getBalanceEntity.isFailed == false) {
                  balance = balanceCompleted
                      .getBalanceEntity.value![0].availablebalance!
                      .toString();
                }
              }

              if (state.profileStatus is ProfileCompleted) {
                ProfileCompleted profileCompleted =
                    state.profileStatus as ProfileCompleted;
                if (profileCompleted.getProfileEntity.isFailed == false) {
                  firstName = profileCompleted.getProfileEntity.value!.firstName
                      .toString();

                  lastName = profileCompleted.getProfileEntity.value!.lastName
                      .toString();

                  nationalCode = profileCompleted
                      .getProfileEntity.value!.nationalCode
                      .toString();
                  email =
                      profileCompleted.getProfileEntity.value!.email.toString();
                  iban = profileCompleted.getProfileEntity.value!.iban.toString();

                  if (profileCompleted.getProfileEntity.value!.image != null) {
                    avatarProfile = base64Decode(
                        profileCompleted.getProfileEntity.value!.image!);
                  }
                }
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xf072b864), Color(0xA6B2D2B0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  'assets/image_icon/hint_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Expanded(flex: 3, child: Container()),
                              Expanded(
                                flex: 3,
                                child: Image.asset(
                                  'assets/image_icon/moba_white_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Expanded(flex: 3, child: Container()),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    _key.currentState!.openEndDrawer();
                                  },
                                  child: Image.asset(
                                    'assets/image_icon/navigation_drawer_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          color: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            (phoneNumber == "***")
                                                ? "نامشخض"
                                                : phoneNumber.toPersianDigit(),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            (balance == "***")
                                                ? "نامشخص"
                                                : "${balance.seRagham()} ریال"
                                                    .toPersianDigit(),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.orange),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.transparent,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 5),
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            prepareFirstLastTitle(),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "موجودی کیف پول",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Image.asset(
                                        'assets/image_icon/fake_avatar.png',
                                        fit: BoxFit.scaleDown,
                                      ),

                                      // (avatarProfile != null)
                                      //     ? Image.memory(avatarProfile!)
                                      //     : Icon(
                                      //         Icons.account_circle_sharp,
                                      //         color: MyColors.icon_1,
                                      //         size: 42,
                                      //       ),
                                    ))
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 13,
                        child: Container(
                          padding: EdgeInsets.only(top: 15),
                          color: Colors.transparent,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(top: 30, left: 15, right: 15),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(30.0),
                                    topRight: const Radius.circular(30.0))),
                            child: GridView.count(
                              primary: false,
                              padding: const EdgeInsets.all(5),
                              crossAxisCount: 3,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<
                                                cinternet.ChargeInternetBloc>(),
                                            child: InternetChargeScreenView(),
                                          );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });

                                    // await Navigator.push(
                                    //   context,
                                    //   SlideRightRoute(
                                    //     page: InternetChargeScreenView(),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/internet_charge_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "بسته اینترنت",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<csim.ChargeSimBloc>(),
                                            child: SimChargeScreenView(),
                                          );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });

                                    // await Navigator.push(
                                    //   context,
                                    //   SlideRightRoute(
                                    //     page: SimChargeScreenView(),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/simcard_charge_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "شارژ سیم کارت",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: KbkScreenView(),
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/kbk_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "کارت به کارت",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<billbloc.BillBloc>(),
                                            child: BillsScreenView(),
                                          );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/pay_ghabz_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "پرداخت قبوض",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<wallett.WalletBloc>(),
                                            child: WalletScreenView(1),
                                          );

                                          // return BlocProvider(
                                          //   create: (_) =>
                                          //       locator<wallett.WalletBloc>(),
                                          //   child: WalletScreenView(),
                                          // );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/wallet_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "کیف پول",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: BimeScreenView(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/bime_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "خدمات بیمه",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        SlideRightRoute(
                                          page: TicketScreenView(),
                                        ),
                                      ).then((value) => {
                                            BlocProvider.of<MainBloc>(context)
                                                .add(GetBalanceEvent())
                                          });
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/image_icon/buy_ticket_main_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "بلیط شهری",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: TravelScreenView(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/buy_ticket_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "سفر",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: TicketScreenView(),
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/image_icon/buy_ticket_main_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "بلیط شهری",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: Offset(0, -5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: BimeScreenView(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            'assets/image_icon/bime_down_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "بیمه من",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      SlideRightRoute(
                                        page: KbkScreenView(),
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            'assets/image_icon/kbk_down_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "کارت به کارت",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            'assets/image_icon/services_down_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "سرویس ها",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: MyColors.otp_underline,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<wallett.WalletBloc>(),
                                            child: WalletScreenView(1),
                                          );

                                          // return BlocProvider(
                                          //   create: (_) =>
                                          //       locator<wallett.WalletBloc>(),
                                          //   child: WalletScreenView(),
                                          // );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent())
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            'assets/image_icon/wallet_down_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "کیف پول",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider.value(
                                            value: locator<ProfileBloc>(),
                                            child: ProfileScreenView(
                                                int.parse(balance),
                                                firstName,
                                                lastName,
                                                phoneNumber,
                                                nationalCode,
                                                email,
                                                iban),
                                          );
                                        },
                                      ),
                                    ).then((value) => {
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetBalanceEvent()),
                                          BlocProvider.of<MainBloc>(context)
                                              .add(GetProfileEvent())
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            'assets/image_icon/profile_down_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "پروفایل من",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  prepareFirstLastTitle() {
    if (firstName == "***" || lastName == "***") {
      return "نامشخص";
    }

    if (firstName.trim() == "" || lastName.trim() == "") {
      return "نامشخص";
    }
    if (firstName == "null" || lastName == "null") {
      return "نامشخص";
    }
    if (firstName != null && lastName != null) {
      return "${firstName}  ${lastName}";
    } else {
      return "نامشخص";
    }
  }

  _getPhoneNumber() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TokenKeeper.getPhoneNumber().then((value) {
        setState(() {
          if (value == "") {
            phoneNumber = "نامشخص";
          } else {
            phoneNumber = value;
          }
        });
      });
    });
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        content: Align(
            alignment: Alignment.centerRight,
            child: Text(
              message,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "shabnam_bold"),
            ))));
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       duration: Duration(seconds: 4),
    //       content: Align(
    //           alignment: Alignment.centerRight,
    //           child: Text(
    //             message,
    //             style: TextStyle(fontFamily: "shabnam_bold"),
    //           ))));
    // });
  }
}
