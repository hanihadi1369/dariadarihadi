import 'dart:io';

import 'package:atba_application/core/params/show_internet_packages_param.dart';
import 'package:atba_application/core/widgets/loading.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share/share.dart';

import '../../../../core/params/buy_internet_package_param.dart';
import '../../../../core/utils/colors.dart';
import '../../data/models/show_internet_packages_model.dart' as show;
import '../block/balance_status_cinternet.dart';
import '../block/buy_internet_package_status.dart';
import '../block/charge_internet_bloc.dart';
import '../block/show_internet_packages_status.dart';
import 'dart:ui' as ui;

class InternetChargeScreenView extends StatefulWidget {
  @override
  _InternetChargeScreenViewState createState() =>
      _InternetChargeScreenViewState();
}

class _InternetChargeScreenViewState extends State<InternetChargeScreenView> {
  int pageIndex = 1;

  int operatorSelected = 3; // >>  1 rightel ,  2 hamrah  ,3   irancell
  int simCardType = 0; // >> 1 etberai  2 daemi
  int payTypeSelected = 1; // >>  1 wallet ,  2 kart
  int timeTypeTabIndex =
      1; // >> 1 daily , 2 weekly , 3 monthly  , 4 threemonth  , 5 sixmonth , 6 anually , 7 other

  String balance = "نامشخص";
  bool shouldShowLoading = false;

  final _formKey_page1 = GlobalKey<FormState>();
  bool _isButtonNextDisabled_page1 = true;
  TextEditingController _phoneController = TextEditingController();

  show.Value internetPackagesResponse = show.Value();
  List<show.Daily> dailyInternetPackList = [];
  show.Daily selectedDaily = show.Daily();
  List<show.Weekly> weeklyInternetPackList = [];
  show.Weekly selectedWeekly = show.Weekly();
  List<show.Monthly> monthlyInternetPackList = [];
  show.Monthly selectedMonthly = show.Monthly();
  List<show.Trimester> trimesterInternetPackList = []; // 3month
  show.Trimester selectedTrimester = show.Trimester();
  List<show.Semiannual> semiannualInternetPackList = []; // 6mahe
  show.Semiannual selectedSemiannual = show.Semiannual();
  List<show.Annual> annualInternetPackList = [];
  show.Annual selectedAnnual = show.Annual();
  List<show.Other> otherInternetPackList = [];
  show.Other selectedOther = show.Other();

  int orderIdResultPayFromWallet = 0;

  GlobalKey previewContainer4 = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (pageIndex == 1) {
          Navigator.of(context).pop();
        }

        if (pageIndex == 4) {
          Navigator.of(context).pop();
        }
        if (pageIndex == 2) {
          setState(() {
            pageIndex = 1;
          });
        }
        if (pageIndex == 3) {
          setState(() {
            pageIndex = 2;
          });
        }

        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<ChargeInternetBloc, ChargeInternetState>(
            listener: (context, state) {
              if (state.showInternetPackagesStatus
                  is ShowInternetPackagesError) {
                ShowInternetPackagesError error = state
                    .showInternetPackagesStatus as ShowInternetPackagesError;
                _showSnackBar(error.message);
                state.showInternetPackagesStatus = ShowInternetPackagesInit();
              }
              if (state.buyInternetPackageStatus is BuyInternetPackageError) {
                BuyInternetPackageError error =
                    state.buyInternetPackageStatus as BuyInternetPackageError;
                _showSnackBar(error.message);
                state.buyInternetPackageStatus = BuyInternetPackageInit();
              }

              if (state.balanceStatus is BalanceError) {
                BalanceError error = state.balanceStatus as BalanceError;
                _showSnackBar(error.message);
                state.balanceStatus = BalanceInit();
              }
            },
            builder: (context, state) {
              if (state.showInternetPackagesStatus
                      is ShowInternetPackagesLoading ||
                  state.buyInternetPackageStatus is BuyInternetPackageLoading ||
                  state.balanceStatus is BalanceLoading) {
                return LoadingPage();
              }

              if (state.showInternetPackagesStatus
                  is ShowInternetPackagesCompleted) {
                ShowInternetPackagesCompleted showInternetPackagesCompleted =
                    state.showInternetPackagesStatus
                        as ShowInternetPackagesCompleted;
                if (showInternetPackagesCompleted
                        .showInternetPackagesEntity.isFailed ==
                    false) {
                  if (showInternetPackagesCompleted
                          .showInternetPackagesEntity.value !=
                      null)
                    internetPackagesResponse = showInternetPackagesCompleted
                        .showInternetPackagesEntity.value!;

                  if (internetPackagesResponse.bundles != null) {
                    if (internetPackagesResponse.bundles!.daily != null) {
                      dailyInternetPackList =
                          internetPackagesResponse.bundles!.daily!;
                    } else {
                      dailyInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.weekly != null) {
                      weeklyInternetPackList =
                          internetPackagesResponse.bundles!.weekly!;
                    } else {
                      weeklyInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.monthly != null) {
                      monthlyInternetPackList =
                          internetPackagesResponse.bundles!.monthly!;
                    } else {
                      monthlyInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.trimester != null) {
                      trimesterInternetPackList =
                          internetPackagesResponse.bundles!.trimester!;
                    } else {
                      trimesterInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.semiannual != null) {
                      semiannualInternetPackList =
                          internetPackagesResponse.bundles!.semiannual!;
                    } else {
                      semiannualInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.annual != null) {
                      annualInternetPackList =
                          internetPackagesResponse.bundles!.annual!;
                    } else {
                      annualInternetPackList = [];
                    }

                    if (internetPackagesResponse.bundles!.other != null) {
                      otherInternetPackList =
                          internetPackagesResponse.bundles!.other!;
                    } else {
                      otherInternetPackList = [];
                    }
                  } else {
                    dailyInternetPackList = [];
                    weeklyInternetPackList = [];
                    monthlyInternetPackList = [];
                    trimesterInternetPackList = [];
                    semiannualInternetPackList = [];
                    annualInternetPackList = [];
                    otherInternetPackList = [];
                  }

                  pageIndex = 2;
                }
                state.showInternetPackagesStatus = ShowInternetPackagesInit();
              }

              if (state.balanceStatus is BalanceCompleted) {
                BalanceCompleted balanceCompleted =
                    state.balanceStatus as BalanceCompleted;
                if (balanceCompleted.getBalanceEntity.isFailed == false) {
                  balance = balanceCompleted
                      .getBalanceEntity.value![0].availablebalance!
                      .toString();
                }
                state.balanceStatus = BalanceInit();
              }

              if (state.buyInternetPackageStatus
                  is BuyInternetPackageCompleted) {
                BuyInternetPackageCompleted buyInternetPackageCompleted = state
                    .buyInternetPackageStatus as BuyInternetPackageCompleted;
                if (buyInternetPackageCompleted
                        .buyInternetPackageEntity.isFailed ==
                    false) {
                  orderIdResultPayFromWallet = buyInternetPackageCompleted
                      .buyInternetPackageEntity.value!.orderId!
                      .toInt();
                  pageIndex = 4;
                }
                state.buyInternetPackageStatus = BuyInternetPackageInit();
              }

              if (shouldShowLoading) {
                return LoadingPage();
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: preparePageIndex(),
              );
            },
          ),
        ),
      ),
    );
  }

  preparePageIndex() {
    // index 1 > get operator type and phone number
    // index 2 > select internet package type
    // index 3 > select pay type
    // index 4 > result

    if (pageIndex == 1) {
      return Column(
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/image_icon/back_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("خرید بسته اینترنت")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_black_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "انتخاب اپراتور",
                            style: TextStyle(color: MyColors.otp_underline),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  operatorSelected = 1;
                                });
                              },
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  color: (operatorSelected == 1)
                                      ? Colors.transparent
                                      : Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        child: Image.asset(
                                          'assets/image_icon/rightel_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    Text("رایتل")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  operatorSelected = 2;
                                });
                              },
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  color: (operatorSelected == 2)
                                      ? Colors.transparent
                                      : Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset(
                                        'assets/image_icon/hamrah_aval_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Text("همراه اول")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  operatorSelected = 3;
                                });
                              },
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  color: (operatorSelected == 3)
                                      ? Colors.transparent
                                      : Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset(
                                        'assets/image_icon/irancell_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Text("ایرانسل")
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
                color: Colors.transparent,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "شماره سیم کارت خود را وارد کنید",
                              style: TextStyle(color: MyColors.otp_underline),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formKey_page1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: _phoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'مقدار وارد شده خالی است';
                                    } else if ((value.trim().startsWith('0') !=
                                            true) ||
                                        value.trim().length != 11) {
                                      return 'شماره تلفن وارد شده معتبر نیست';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _isButtonNextDisabled_page1 =
                                          !_formKey_page1.currentState!
                                              .validate();
                                    });
                                  },
                                  maxLength: 11,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.account_box_outlined,
                                      color: MyColors.icon_1,
                                    ),
                                    filled: true,
                                    fillColor: Color(0x32E1E3E0),
                                    labelText: 'شماره تلفن همراه',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isButtonNextDisabled_page1
                          ? null
                          : () {
                              // should show bottom sheet dialog
                              showMaterialModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height /
                                      (2.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Text(
                                        "نوع سیم کارت",
                                        style: TextStyle(
                                            color: MyColors.otp_underline,
                                            fontSize: 16),
                                      )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                          child: Text(
                                        _phoneController.text,
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            simCardType = 1;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 16, top: 5, bottom: 5),
                                          width: double.infinity,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "اعتباری",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            simCardType = 2;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 16, top: 5, bottom: 5),
                                          width: double.infinity,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "دائمی",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 32, right: 32),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: MyColors
                                                          .otp_underline),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                simCardType = 0;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "انصراف",
                                              style: TextStyle(
                                                  color:
                                                      MyColors.otp_underline),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ).then((value) => {
                                    if (simCardType != 0)
                                      {
                                        BlocProvider.of<ChargeInternetBloc>(
                                                context)
                                            .add(ShowInternetPackagesEvent(
                                                ShowInternetPackagesParam(
                                                    mobile: _phoneController
                                                        .text
                                                        .toString()
                                                        .trim(),
                                                    operatorType:
                                                        (operatorSelected == 1)
                                                            ? 2
                                                            : (operatorSelected ==
                                                                    2)
                                                                ? 1
                                                                : 0)))
                                      }
                                  });

                              // //should show bottom sheet dialog
                              // showMaterialModalBottomSheet(
                              //   context: context,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(15),
                              //           topRight: Radius.circular(15))),
                              //   builder: (context) => Container(
                              //     height: MediaQuery.of(context).size.height /
                              //         (2.5),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.stretch,
                              //       children: [
                              //         SizedBox(
                              //           height: 10,
                              //         ),
                              //         Center(
                              //             child: Text(
                              //           "نوع سیم کارت",
                              //           style: TextStyle(
                              //               color: MyColors.otp_underline,
                              //               fontSize: 16),
                              //         )),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         Center(
                              //             child: Text(
                              //           _phoneController.text,
                              //           style: TextStyle(color: Colors.grey),
                              //         )),
                              //         Divider(
                              //           thickness: 1,
                              //           color: Colors.black,
                              //         ),
                              //         InkWell(
                              //           onTap: () {
                              //             setState(() {
                              //               simCardType = 1;
                              //               pageIndex = 2;
                              //               Navigator.pop(context);
                              //             });
                              //           },
                              //           child: Container(
                              //             padding: EdgeInsets.only(
                              //                 right: 16, top: 5, bottom: 5),
                              //             width: double.infinity,
                              //             child: Align(
                              //                 alignment: Alignment.centerRight,
                              //                 child: Text(
                              //                   "اعتباری",
                              //                   style: TextStyle(
                              //                       color: Colors.black),
                              //                 )),
                              //           ),
                              //         ),
                              //         Divider(
                              //           thickness: 0.5,
                              //           color: Colors.grey,
                              //         ),
                              //         InkWell(
                              //           onTap: () {
                              //             setState(() {
                              //               simCardType = 2;
                              //               Navigator.pop(context);
                              //             });
                              //
                              //
                              //
                              //
                              //
                              //
                              //           },
                              //           child: Container(
                              //             padding: EdgeInsets.only(
                              //                 right: 16, top: 5, bottom: 5),
                              //             width: double.infinity,
                              //             child: Align(
                              //                 alignment: Alignment.centerRight,
                              //                 child: Text(
                              //                   "دائمی",
                              //                   style: TextStyle(
                              //                       color: Colors.black),
                              //                 )),
                              //           ),
                              //         ),
                              //         Divider(
                              //           thickness: 0.5,
                              //           color: Colors.grey,
                              //         ),
                              //         Spacer(),
                              //         Padding(
                              //           padding: EdgeInsets.only(
                              //               left: 32, right: 32),
                              //           child: ElevatedButton(
                              //               style: ButtonStyle(
                              //                 backgroundColor:
                              //                     MaterialStateProperty
                              //                         .resolveWith<Color>(
                              //                   (Set<MaterialState> states) {
                              //                     return Colors.white;
                              //                   },
                              //                 ),
                              //                 padding: MaterialStateProperty
                              //                     .all<EdgeInsetsGeometry>(
                              //                   EdgeInsets.symmetric(
                              //                       horizontal: 16,
                              //                       vertical: 8),
                              //                 ),
                              //                 shape: MaterialStateProperty.all<
                              //                     RoundedRectangleBorder>(
                              //                   RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10.0),
                              //                     side: BorderSide(
                              //                         color: MyColors
                              //                             .otp_underline),
                              //                   ),
                              //                 ),
                              //               ),
                              //               onPressed: () {
                              //                 Navigator.pop(context);
                              //               },
                              //               child: Text(
                              //                 "انصراف",
                              //                 style: TextStyle(
                              //                     color:
                              //                         MyColors.otp_underline),
                              //               )),
                              //         ),
                              //         SizedBox(
                              //           height: 20,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // );
                            },
                      child: Text('ادامه'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 2) {
      return Column(
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/image_icon/back_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("خرید بسته اینترنت")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_black_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 1)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "یک روزه",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 1)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 2)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "هفتگی",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 2)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 3;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 3)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "یک ماهه",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 3)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 4;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 4)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "سه ماهه",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 4)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 5;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 5)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "شش ماهه",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 5)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 6;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 6)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "دوازده ماهه",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 6)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              timeTypeTabIndex = 7;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (timeTypeTabIndex == 7)
                                  ? MyColors.otp_underline2
                                  : MyColors.button_label_disabled,
                            ),
                            child: Text(
                              "سایر",
                              style: TextStyle(
                                  color: (timeTypeTabIndex == 7)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 16,
              child: Container(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: prepareEPackWidgets())),
              )),
        ],
      );
    }

    if (pageIndex == 3) {
      return Column(
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/image_icon/back_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("نوع پرداخت")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_black_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 8,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      (operatorSelected == 1)
                                          ? 'assets/image_icon/rightel_icon.png'
                                          : (operatorSelected == 2)
                                              ? 'assets/image_icon/hamrah_aval_icon.png'
                                              : 'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      child: Text(_phoneController.text)))
                            ],
                          )),
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Text((operatorSelected == 1)
                                    ? 'رایتل'
                                    : (operatorSelected == 2)
                                        ? 'همراه اول'
                                        : 'ایرانسل'),
                                Spacer(),
                                Text(
                                  "نوع اپراتور",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    prepareSelectedItemTitle(),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "محصول انتخابی",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${prepareSelectedItemCost().seRagham()} ریال",
                                  textDirection: TextDirection.rtl,
                                ),
                                Spacer(),
                                Text(
                                  "مبلغ شارژ + مالیات",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "نامشخص")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            payTypeSelected = 2;
                          });
                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: (payTypeSelected == 2)
                                  ? MyColors.otp_underline
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          ("کارت بانکی"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (payTypeSelected == 2)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bank_shahr_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          BuyInternetPackageParam buyInternetPackageParam =
                              BuyInternetPackageParam(
                            bundleId: prepareSelectedItemBundelId(),
                            amount: prepareSelectedItemCost(),
                            cellNumber: _phoneController.text.trim(),
                            requestId: (operatorSelected == 1)
                                ? "${internetPackagesResponse.requestId}"
                                : "",
                            operatorType: (operatorSelected == 1)
                                ? 2
                                : (operatorSelected == 2)
                                    ? 1
                                    : 0,
                            operationCode: (operatorSelected == 1)
                                ? 313
                                : (operatorSelected == 2)
                                    ? 3
                                    : 5,
                            type: int.parse(prepareSelectedItemType()),
                          );

                          BlocProvider.of<ChargeInternetBloc>(context).add(
                              BuyInternetPackagesEvent(
                                  buyInternetPackageParam));
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 4) {
      return Column(
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
                        'assets/image_icon/hint_black_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("رسید پرداخت")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 16,
              child: RepaintBoundary(
                key: previewContainer4,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 9,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 35, right: 35, top: 10, bottom: 10),
                            color: Colors.transparent,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Image.asset(
                                                  (operatorSelected == 1)
                                                      ? 'assets/image_icon/rightel_icon.png'
                                                      : (operatorSelected == 2)
                                                          ? 'assets/image_icon/hamrah_aval_icon.png'
                                                          : 'assets/image_icon/irancell_icon.png',
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  child: Text(
                                                      _phoneController.text)))
                                        ],
                                      )),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                        child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text((operatorSelected == 1)
                                                ? 'رایتل'
                                                : (operatorSelected == 2)
                                                    ? 'همراه اول'
                                                    : 'ایرانسل'),
                                            Spacer(),
                                            Text(
                                              "نوع اپراتور",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                prepareSelectedItemTitle(),
                                                textDirection:
                                                    TextDirection.rtl,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "محصول",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${prepareSelectedItemCost().seRagham()} ریال",
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Spacer(),
                                            Text(
                                              "مبلغ شارژ + مالیات",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Image.asset(
                                      'assets/image_icon/success_payment.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: MyColors.otp_underline,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ))),
                      Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(left: 32, right: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Text(_phoneController.text),
                                    Spacer(),
                                    Text(
                                      "شماره همراه",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text("${orderIdResultPayFromWallet}"),
                                    Spacer(),
                                    Text(
                                      "شماره پیگیری",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(DateTime.now().toPersianDate(
                                        twoDigits: true,
                                        showTime: true,
                                        timeSeprator: ' - ')),
                                    //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                                    Spacer(),
                                    Text(
                                      "تاریخ و ساعت",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text((payTypeSelected == 1)
                                        ? "کیف پول"
                                        : "کارت بانکی"),
                                    Spacer(),
                                    Text(
                                      "پرداخت از",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Expanded(
                          //     child: Container(
                          //   padding: EdgeInsets.only(right: 10),
                          //   child:  Visibility(
                          //     visible: false,
                          //     child: Image.asset(
                          //       'assets/image_icon/save_in_gallery.png',
                          //       fit: BoxFit.scaleDown,
                          //     ),
                          //   ),
                          // )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              _captureSocialPng(previewContainer4);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }
  }

  List<Widget> prepareEPackWidgets() {




    List<Widget> widgetList = [];
    if (timeTypeTabIndex == 1) {
      for (var i = 0; i < dailyInternetPackList.length; i++) {
        if(simCardType==1){
          //etebari
          if(dailyInternetPackList[i].type == "1" || dailyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedDaily = dailyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${dailyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${dailyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi

          if(dailyInternetPackList[i].type == "2" || dailyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedDaily = dailyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${dailyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${dailyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 2) {
      for (var i = 0; i < weeklyInternetPackList.length; i++) {

        if(simCardType==1){
          //etebari
          if(weeklyInternetPackList[i].type == "1"||weeklyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedWeekly = weeklyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${weeklyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${weeklyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi

          if(weeklyInternetPackList[i].type == "2"||weeklyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedWeekly = weeklyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${weeklyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${weeklyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 3) {
      for (var i = 0; i < monthlyInternetPackList.length; i++) {



        if(simCardType==1){
          //etebari

          if(monthlyInternetPackList[i].type == "1"||monthlyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedMonthly = monthlyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${monthlyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${monthlyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi

          if(monthlyInternetPackList[i].type == "2"||monthlyInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedMonthly = monthlyInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${monthlyInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${monthlyInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 4) {
      for (var i = 0; i < trimesterInternetPackList.length; i++) {




        if(simCardType==1){
          //etebari
          if(trimesterInternetPackList[i].type == "1"||trimesterInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedTrimester = trimesterInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${trimesterInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${trimesterInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi
          if(trimesterInternetPackList[i].type == "2" || trimesterInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedTrimester = trimesterInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${trimesterInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${trimesterInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 5) {
      for (var i = 0; i < semiannualInternetPackList.length; i++) {



        if(simCardType==1){
          //etebari
          if(semiannualInternetPackList[i].type == "1"||semiannualInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedSemiannual = semiannualInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${semiannualInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${semiannualInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi

          if(semiannualInternetPackList[i].type == "2"||semiannualInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedSemiannual = semiannualInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${semiannualInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${semiannualInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 6) {
      for (var i = 0; i < annualInternetPackList.length; i++) {



        if(simCardType==1){
          //etebari

          if(annualInternetPackList[i].type == "1"||annualInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedAnnual = annualInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${annualInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${annualInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi
          if(annualInternetPackList[i].type == "2"||annualInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedAnnual = annualInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${annualInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${annualInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    if (timeTypeTabIndex == 7) {
      for (var i = 0; i < otherInternetPackList.length; i++) {




        if(simCardType==1){
          //etebari

          if(otherInternetPackList[i].type == "1"||otherInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedOther = otherInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${otherInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${otherInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }

        }else if (simCardType == 2){
          //daemi

          if(otherInternetPackList[i].type == "2"||otherInternetPackList[i].type == "3"){
            widgetList.add(
              InkWell(
                  onTap: () {
                    BlocProvider.of<ChargeInternetBloc>(context)
                        .add(GetBalanceEvent());
                    setState(() {
                      selectedOther = otherInternetPackList[i];
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    height: 95,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/go_orange_ison.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${otherInternetPackList[i].billAmount!.seRagham()} ریال",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "مبلغ + مالیات",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${otherInternetPackList[i].title!.trim()}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                // padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/image_icon/global_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }
        }

      }
    }
    return widgetList;
  }

  String prepareSelectedItemCost() {
    // timeTypeTabIndex // >> 1 daily , 2 weekly , 3 monthly  , 4 threemonth  , 5 sixmonth , 6 anually , 7 other
    String result = "نامشخص";
    if (timeTypeTabIndex == 1) {
      if (selectedDaily.billAmount != null) return selectedDaily.billAmount!;
    }
    if (timeTypeTabIndex == 2) {
      if (selectedWeekly.billAmount != null) return selectedWeekly.billAmount!;
    }
    if (timeTypeTabIndex == 3) {
      if (selectedMonthly.billAmount != null)
        return selectedMonthly.billAmount!;
    }
    if (timeTypeTabIndex == 4) {
      if (selectedTrimester.billAmount != null)
        return selectedTrimester.billAmount!;
    }
    if (timeTypeTabIndex == 5) {
      if (selectedSemiannual.billAmount != null)
        return selectedSemiannual.billAmount!;
    }
    if (timeTypeTabIndex == 6) {
      if (selectedAnnual.billAmount != null) return selectedAnnual.billAmount!;
    }
    if (timeTypeTabIndex == 7) {
      if (selectedOther.billAmount != null) return selectedOther.billAmount!;
    }

    return result;
  }

  String prepareSelectedItemTitle() {
    // timeTypeTabIndex // >> 1 daily , 2 weekly , 3 monthly  , 4 threemonth  , 5 sixmonth , 6 anually , 7 other
    String result = "نامشخص";
    if (timeTypeTabIndex == 1) {
      if (selectedDaily.title != null) return selectedDaily.title!.trim()!;
    }
    if (timeTypeTabIndex == 2) {
      if (selectedWeekly.title != null) return selectedWeekly.title!.trim()!;
    }
    if (timeTypeTabIndex == 3) {
      if (selectedMonthly.title != null) return selectedMonthly.title!.trim()!;
    }
    if (timeTypeTabIndex == 4) {
      if (selectedTrimester.title != null)
        return selectedTrimester.title!.trim()!;
    }
    if (timeTypeTabIndex == 5) {
      if (selectedSemiannual.title != null)
        return selectedSemiannual.title!.trim()!;
    }
    if (timeTypeTabIndex == 6) {
      if (selectedAnnual.title != null) return selectedAnnual.title!.trim()!;
    }
    if (timeTypeTabIndex == 7) {
      if (selectedOther.title != null) return selectedOther.title!.trim()!;
    }

    return result;
  }

  String prepareSelectedItemBundelId() {
    // timeTypeTabIndex // >> 1 daily , 2 weekly , 3 monthly  , 4 threemonth  , 5 sixmonth , 6 anually , 7 other
    String result = "";
    if (timeTypeTabIndex == 1) {
      if (selectedDaily.id != null) return selectedDaily.id!.trim()!;
    }
    if (timeTypeTabIndex == 2) {
      if (selectedWeekly.id != null) return selectedWeekly.id!.trim()!;
    }
    if (timeTypeTabIndex == 3) {
      if (selectedMonthly.id != null) return selectedMonthly.id!.trim()!;
    }
    if (timeTypeTabIndex == 4) {
      if (selectedTrimester.id != null) return selectedTrimester.id!.trim()!;
    }
    if (timeTypeTabIndex == 5) {
      if (selectedSemiannual.id != null) return selectedSemiannual.id!.trim()!;
    }
    if (timeTypeTabIndex == 6) {
      if (selectedAnnual.id != null) return selectedAnnual.id!.trim()!;
    }
    if (timeTypeTabIndex == 7) {
      if (selectedOther.id != null) return selectedOther.id!.trim()!;
    }

    return result;
  }

  String prepareSelectedItemType() {
    // timeTypeTabIndex // >> 1 daily , 2 weekly , 3 monthly  , 4 threemonth  , 5 sixmonth , 6 anually , 7 other
    String result = "0";
    if (timeTypeTabIndex == 1) {
      if (selectedDaily.type != null) return selectedDaily.type!;
    }
    if (timeTypeTabIndex == 2) {
      if (selectedWeekly.type != null) return selectedWeekly.type!;
    }
    if (timeTypeTabIndex == 3) {
      if (selectedMonthly.type != null) return selectedMonthly.type!;
    }
    if (timeTypeTabIndex == 4) {
      if (selectedTrimester.type != null) return selectedTrimester.type!;
    }
    if (timeTypeTabIndex == 5) {
      if (selectedSemiannual.type != null) return selectedSemiannual.type!;
    }
    if (timeTypeTabIndex == 6) {
      if (selectedAnnual.type != null) return selectedAnnual.type!;
    }
    if (timeTypeTabIndex == 7) {
      if (selectedOther.type != null) return selectedOther.type!;
    }

    return result;
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

  _showSnackBarPost(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          content: Align(
              alignment: Alignment.centerRight,
              child: Text(
                message,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: "shabnam_bold"),
              ))));
    });
  }

  Future<void> _captureSocialPng(GlobalKey previewContainer) {
    List<String> imagePaths = [];

    final RenderBox box = context.findRenderObject() as RenderBox;
    return new Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      setState(() {
        shouldShowLoading = true;
      });
      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
                subject: 'Share',
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size)
            .then((value) {
          setState(() {
            shouldShowLoading = false;
          });
        });
      }).catchError((onError) {
        print(onError);
      });
    });
  }

  saveToGallery(GlobalKey previewContainer) {
    List<String> imagePaths = [];

    final RenderBox box = context.findRenderObject() as RenderBox;
    return new Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      setState(() {
        shouldShowLoading = true;
      });
      ui.Image image = await boundary!.toImage();

      ByteData? byteData =
          await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

        setState(() {
          shouldShowLoading = false;
        });
      }
    });
  }
}
