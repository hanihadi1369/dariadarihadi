import 'package:atba_application/features/profile_screen_view.dart';
import 'package:atba_application/features/sim_charge_screen_view.dart';
import 'package:atba_application/features/ticket_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/slide_right_transition.dart';
import '../../../../core/widgets/drawer.dart';
import '../../../../core/widgets/loading.dart';
import '../../../bills_screen_view.dart';
import '../../../internet_charge_screen_view.dart';
import '../../../kbk_screen_view.dart';
import '../../../wallet_screen_view.dart';
import '../bloc/balance_status.dart';
import '../bloc/main_bloc.dart';

class MainScreenView extends StatefulWidget {
  @override
  _MainScreenViewState createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  String balance = "***";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context)
        .add(GetBalanceEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _key,
      endDrawer: AppDrawer(),
      body: SafeArea(
        child: BlocConsumer<MainBloc, MainState>(
          listener: (context, state) {
            if (state.balanceStatus is BalanceError) {
              BalanceError error = state.balanceStatus as BalanceError;
              _showSnackBar(error.message);
            }


          },
          builder: (context, state) {

            if (state.balanceStatus is BalanceLoading ) {
              return LoadingPage();
            }
            if (state.balanceStatus is BalanceCompleted) {
              BalanceCompleted balanceCompleted =
              state.balanceStatus as BalanceCompleted;
              if (balanceCompleted.getBalanceEntity.isFailed == false) {
                balance = balanceCompleted.getBalanceEntity.value![0].balance!.toString();
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
                                          "09128222554".toPersianDigit(),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          (balance == "***" )?"نامشخص":"${balance} ریال".toPersianDigit(),
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
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      children: [
                                        Text(
                                          "هادی قدیری",
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
                                      'assets/image_icon/dummy_profile.png',
                                      fit: BoxFit.scaleDown,
                                    ),
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
                          padding: EdgeInsets.only(
                              top: 30, left: 15, right: 15),
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
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: InternetChargeScreenView(),
                                    ),
                                  );
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
                                        "شارژ اینترنت",
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
                                      page: SimChargeScreenView(),
                                    ),
                                  );
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
                                  );
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
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: BillsScreenView(),
                                    ),
                                  );
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
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: WalletScreenView(),
                                    ),
                                  );
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
                                onTap: () {},
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
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: TicketScreenView(),
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
                                        "خرید بلیت",
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
                                onTap: () {},
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
                                  );
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
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: WalletScreenView(),
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
                                  await Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: ProfileScreenView(),
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
    );
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        content: Align(
            alignment: Alignment.centerRight,
            child: Text(
              message,
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
