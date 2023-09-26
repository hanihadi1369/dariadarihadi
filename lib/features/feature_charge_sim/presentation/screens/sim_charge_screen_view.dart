import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/params/charge_sim_param.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/loading.dart';
import '../block/balance_status_csim.dart';
import '../block/charge_sim_bloc.dart';
import '../block/charge_sim_status.dart';

class SimChargeScreenView extends StatefulWidget {
  @override
  _SimChargeScreenViewState createState() => _SimChargeScreenViewState();
}

class _SimChargeScreenViewState extends State<SimChargeScreenView> {
  int pageIndex = 1;

  int operatorSelected = 3; // >>  1 rightel ,  2 hamrah  ,3   irancell
  int chargeAmountSelected =
      0; // >>  0 nothing ,  1 5000toman  ,2   10000toman,3   15000toman,4   20000toman,5   30000toman,6   50000toman,

  int payTypeSelected = 1; // >>  1 wallet ,  2 kart

  final _formKey_page1 = GlobalKey<FormState>();
  bool _isButtonNextDisabled_page1 = true;
  TextEditingController _phoneController = TextEditingController();
  int simCardType = 0; // >> 1 etberai  2 daemi

  String balance = "نامشخص";

  int orderIdResultPayFromWallet = 0;

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
          child: BlocConsumer<ChargeSimBloc, ChargeSimState>(
            listener: (context, state) {
              if (state.balanceStatus is BalanceError) {
                BalanceError error = state.balanceStatus as BalanceError;
                _showSnackBar(error.message);
                state.balanceStatus = BalanceInit();
              }
              if (state.chargeSimStatus is ChargeSimError) {
                ChargeSimError error = state.chargeSimStatus as ChargeSimError;
                _showSnackBar(error.message);
                state.chargeSimStatus = ChargeSimInit();
              }
            },
            builder: (context, state) {
              if (state.chargeSimStatus is ChargeSimLoading ||
                  state.balanceStatus is BalanceLoading) {
                return LoadingPage();
              }

              if (state.balanceStatus is BalanceCompleted) {
                BalanceCompleted balanceCompleted =
                    state.balanceStatus as BalanceCompleted;
                if (balanceCompleted.getBalanceEntity.isFailed == false) {
                  balance = balanceCompleted.getBalanceEntity.value![0].store!
                      .toString();
                }
                state.balanceStatus = BalanceInit();
              }
              if (state.chargeSimStatus is ChargeSimCompleted) {
                ChargeSimCompleted chargeSimCompleted =
                    state.chargeSimStatus as ChargeSimCompleted;
                if (chargeSimCompleted.chargeSimEntity.isFailed == false) {
                  orderIdResultPayFromWallet = chargeSimCompleted
                      .chargeSimEntity!.value!.orderId!
                      .toInt()!;
                  pageIndex = 4;
                }
                state.balanceStatus = BalanceInit();
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
    // index 2 > get charge amount
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
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("شارژ سیم کارت")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
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
                                            pageIndex = 2;
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
                                            pageIndex = 2;
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
                                              Navigator.pop(context);
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
                              );
                              // setState(() {
                              //   simCardType = 1;
                              //   pageIndex = 2;
                              // });
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
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("انتخاب نوع شارژ")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
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
                      Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "نوع شارژ خود را انتخاب کنید",
                              style: TextStyle(color: MyColors.otp_underline),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 1;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 1)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "50.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 1)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 2;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 2)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "100.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 2)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 3;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 3)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "150.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 3)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 4;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 4)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "200.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 4)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 5;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 5)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "300.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 5)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            chargeAmountSelected = 6;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (chargeAmountSelected == 6)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "500.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (chargeAmountSelected == 6)
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 10, child: Container()),
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
                      onPressed: (chargeAmountSelected == 0)
                          ? null
                          : () {
                              BlocProvider.of<ChargeSimBloc>(context)
                                  .add(GetBalanceEvent());
                              setState(() {
                                pageIndex = 3;
                              });
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
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
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
                        'assets/image_icon/hint_green_icon.png',
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
                                      child: Text(_phoneController.text)))
                            ],
                          )),
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
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
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
                                  children: [
                                    Text(
                                      prepareFinalChargeCost().seRagham() + " ریال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    Text(
                                      "مبلغ شارژ",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            )
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
              flex: 10,
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
                    InkWell(
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                          ChargeSimParam chargeSimParam = ChargeSimParam(
                              totalAmount: int.parse(prepareFinalChargeCost()),
                              cellNumber:
                                  _phoneController.text.toString().trim(),
                              operatorType: (operatorSelected == 1)
                                  ? 2
                                  : (operatorSelected == 2)
                                      ? 1
                                      : 0,
                              simCardType: (simCardType == 1) ? 0 : 1);

                          BlocProvider.of<ChargeSimBloc>(context)
                              .add(ChargeEvent(chargeSimParam));

                          // setState(() {
                          //   pageIndex = 4;
                          // });
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
                        'assets/image_icon/hint_green_icon.png',
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
              flex: 7,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      child: Text(_phoneController.text)))
                            ],
                          )),
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
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
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
                                  children: [
                                    Text(
                                      prepareFinalChargeCost().seRagham() + " ریال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    Text(
                                      "مبلغ شارژ",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            )
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
              flex: 8,
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
                        Text((payTypeSelected == 1) ? "کیف پول" : "کارت بانکی"),
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
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/image_icon/save_in_gallery.png',
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset(
                              'assets/image_icon/share.png',
                              fit: BoxFit.scaleDown,
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

  String prepareFinalChargeCost() {
    if (chargeAmountSelected == 1) {
      return "50000";
    } else if (chargeAmountSelected == 2) {
      return "100000";
    } else if (chargeAmountSelected == 3) {
      return "150000";
    } else if (chargeAmountSelected == 4) {
      return "200000";
    } else if (chargeAmountSelected == 5) {
      return "300000";
    } else if (chargeAmountSelected == 6) {
      return "500000";
    }
    return "0";
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
}
