import 'dart:io';

import 'package:atba_application/core/utils/token_keeper.dart';
import 'package:atba_application/features/feature_charge_sim/data/models/sim_charge_transaction.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/params/charge_sim_param.dart';
import '../../../../core/params/get_wage_approtions_param.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/operator_finder.dart';
import '../../../../core/widgets/loading.dart';
import '../block/balance_status_csim.dart';
import '../block/charge_sim_bloc.dart';
import '../block/charge_sim_status.dart';
import 'dart:ui' as ui;

import '../block/get_wage_approtions_csim_status.dart';

class SimChargeScreenView extends StatefulWidget {
  @override
  _SimChargeScreenViewState createState() => _SimChargeScreenViewState();
}

class _SimChargeScreenViewState extends State<SimChargeScreenView> {
  String? defaultPhoneNumberFromSharedPref;

  int pageIndex = 1;

  int operatorSelected =
      4; // >>  1 rightel ,  2 hamrah  ,3   irancell , 4 nothing
  int chargeAmountSelected =
      0; // >>  0 nothing ,  1 5000toman  ,2   10000toman,3   15000toman,4   20000toman,5   30000toman,6   50000toman,

  int payTypeSelected = 1; // >>  1 wallet ,  2 kart

  final _formKey_page1 = GlobalKey<FormState>();
  bool _isButtonNextDisabled_page1 = true;
  TextEditingController _phoneController = TextEditingController();
  int simCardType = 0; // >> 1 etberai  2 daemi

  String balance = "نامشخص";
  String totalAmountWithkarmozd = "نامشخص";

  int orderIdResultPayFromWallet = 0;

  GlobalKey previewContainer4 = new GlobalKey();
  bool shouldShowLoading = false;

  bool shouldShowOperatorSelect = false;
  bool shouldShowTarabordOption = false;
  bool shouldTrabord = false;

  late Box<SimChargeTransaction> simChargeTransactionBox;
  late List<SimChargeTransaction> simTransactionsList;

  @override
  void initState() {
    super.initState();
    simChargeTransactionBox =
        Hive.box<SimChargeTransaction>('sim_charge_transaction');

    if (simChargeTransactionBox.length > 3) {
      simChargeTransactionBox.deleteAt(0);
    }

    simTransactionsList = simChargeTransactionBox.values
        .toList()
        .reversed
        .toList(); //reversed so as to keep the new data to the top;
    if (simTransactionsList != null) {
      print("xeagle691313 ${simTransactionsList.length}");
    } else {
      print("xeagle691313 simTransactionsList is null");
    }

    TokenKeeper.getPhoneNumber()
        .then((value) => defaultPhoneNumberFromSharedPref = value);
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
              if (state.getWageApprotionsStatus is GetWageApprotionsError) {
                GetWageApprotionsError error =
                    state.getWageApprotionsStatus as GetWageApprotionsError;
                _showSnackBar(error.message);
                state.getWageApprotionsStatus = GetWageApprotionsInit();
              }
            },
            builder: (context, state) {
              if (state.chargeSimStatus is ChargeSimLoading ||
                  state.balanceStatus is BalanceLoading ||
                  state.getWageApprotionsStatus is GetWageApprotionsLoading) {
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
                state.balanceStatus = BalanceInit();
              }
              if (state.getWageApprotionsStatus is GetWageApprotionsCompleted) {
                GetWageApprotionsCompleted getWageApprotionsCompleted =
                    state.getWageApprotionsStatus as GetWageApprotionsCompleted;
                if (getWageApprotionsCompleted
                        .getWageApportionsEntity.isSuccess ==
                    true) {
                  totalAmountWithkarmozd = getWageApprotionsCompleted
                      .getWageApportionsEntity.data!.totalAmount
                      .toString();
                  pageIndex = 3;
                }
                state.getWageApprotionsStatus = GetWageApprotionsInit();
              }
              if (state.chargeSimStatus is ChargeSimCompleted) {
                ChargeSimCompleted chargeSimCompleted =
                    state.chargeSimStatus as ChargeSimCompleted;
                if (chargeSimCompleted.chargeSimEntity.isSuccess == true) {
                  orderIdResultPayFromWallet = chargeSimCompleted
                      .chargeSimEntity!.data!.orderId!
                      .toInt()!;
                  pageIndex = 4;



                  List<SimChargeTransaction> tempList = simChargeTransactionBox.values
                      .toList()
                      .reversed
                      .toList();



                  final newSimTransaction = SimChargeTransaction(
                      phoneNumber: _phoneController.text.trim(),
                      operatorType: operatorSelected,
                      chargeAmountType: chargeAmountSelected,
                      paymentType: payTypeSelected);


                  if(tempList.length == 0){
                    simChargeTransactionBox.add(newSimTransaction);
                  }else{
                    bool shouldAdd = true;
                    tempList.forEach((element) {
                      if(
                      element.phoneNumber!.trim() == newSimTransaction.phoneNumber!.trim() &&
                      element.operatorType == newSimTransaction.operatorType &&
                      element.chargeAmountType == newSimTransaction.chargeAmountType
                      ){
                        shouldAdd = false;
                      }
                    });
                    if(shouldAdd){
                      simChargeTransactionBox.add(newSimTransaction);
                    }

                  }





                }
                state.chargeSimStatus = ChargeSimInit();
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
                                child: Text("شارژ سیم کارت")))),
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
              child: Visibility(
                visible:
                    (prepareEnteredMobileOperatorName() == "" || shouldTrabord)
                        ? false
                        : true,
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          prepareEnteredMobileOperatorIcon(),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(prepareEnteredMobileOperatorName())
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 0),
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
                          height: 5,
                        ),
                        Form(
                          key: _formKey_page1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  maxLength: 11,
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
                                    int resultOperator =
                                        OperatorFinder.findOperator(value);

                                    setState(() {
                                      _isButtonNextDisabled_page1 =
                                          !_formKey_page1.currentState!
                                              .validate();
                                      shouldShowTarabordOption = _formKey_page1
                                          .currentState!
                                          .validate();

                                      switch (resultOperator) {
                                        case 1:
                                          operatorSelected = 2;
                                          break;
                                        case 2:
                                          operatorSelected = 3;
                                          break;
                                        case 3:
                                          operatorSelected = 1;
                                          break;
                                        case 4:
                                          operatorSelected = 4;
                                          break;
                                        case 5:
                                          operatorSelected = 4;
                                          break;
                                      }
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
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await TokenKeeper.getPhoneNumber()
                                                .then((value) => {
                                                      if (value != null &&
                                                          value.isNotEmpty)
                                                        {
                                                          setState(() {
                                                            _phoneController
                                                                    .text =
                                                                value.trim();

                                                            _isButtonNextDisabled_page1 =
                                                                !_formKey_page1
                                                                    .currentState!
                                                                    .validate();

                                                            shouldShowTarabordOption =
                                                                _formKey_page1
                                                                    .currentState!
                                                                    .validate();
                                                            shouldTrabord =
                                                                false;

                                                            switch (OperatorFinder
                                                                .findOperator(
                                                                    value)) {
                                                              case 1:
                                                                operatorSelected =
                                                                    2;
                                                                break;
                                                              case 2:
                                                                operatorSelected =
                                                                    3;
                                                                break;
                                                              case 3:
                                                                operatorSelected =
                                                                    1;
                                                                break;
                                                              case 4:
                                                                operatorSelected =
                                                                    4;
                                                                break;
                                                              case 5:
                                                                operatorSelected =
                                                                    4;
                                                                break;
                                                            }
                                                          }),
                                                          _showSnackBar(
                                                              "شماره تلفن همراه شما جایگذاری شد")
                                                        }
                                                    });
                                          },
                                          child: Icon(
                                            Icons.sim_card_outlined,
                                            color: MyColors.icon_1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                             PhoneContact contact =
                                                await FlutterContactPicker
                                                    .pickPhoneContact();




                                            if (contact != null &&
                                                (contact.phoneNumber != null)) {

                                              String tempNumber = contact
                                                  .phoneNumber!.number!
                                                  .trim();

                                              if(tempNumber.startsWith("+98")){
                                                tempNumber = tempNumber.replaceFirst("+98", "0");
                                              }
                                              if(tempNumber.startsWith("0098")){
                                                tempNumber = tempNumber.replaceFirst("0098", "0");
                                              }




                                              setState(() {
                                                _phoneController.text = tempNumber;

                                                _isButtonNextDisabled_page1 =
                                                    !_formKey_page1
                                                        .currentState!
                                                        .validate();

                                                shouldShowTarabordOption =
                                                    _formKey_page1.currentState!
                                                        .validate();
                                                shouldTrabord = false;

                                                switch (
                                                    OperatorFinder.findOperator(tempNumber)) {
                                                  case 1:
                                                    operatorSelected = 2;
                                                    break;
                                                  case 2:
                                                    operatorSelected = 3;
                                                    break;
                                                  case 3:
                                                    operatorSelected = 1;
                                                    break;
                                                  case 4:
                                                    operatorSelected = 4;
                                                    break;
                                                  case 5:
                                                    operatorSelected = 4;
                                                    break;
                                                }
                                              });
                                              _showSnackBar(
                                                  "شماره تلفن  ${contact.fullName!.trim()}  جایگذاری شد");
                                            }
                                          },
                                          child: Icon(
                                            Icons.account_box_outlined,
                                            color: MyColors.icon_1,
                                          ),
                                        ),
                                      ],
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
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: shouldShowTarabordOption,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 70,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CupertinoSwitch(
                                      value: shouldTrabord,
                                      onChanged: (value) {
                                        setState(() {
                                          shouldTrabord = value;
                                          if (value) {
                                            operatorSelected = 4;
                                          } else {
                                            switch (OperatorFinder.findOperator(
                                                _phoneController.text.trim())) {
                                              case 1:
                                                operatorSelected = 2;
                                                break;
                                              case 2:
                                                operatorSelected = 3;
                                                break;
                                              case 3:
                                                operatorSelected = 1;
                                                break;
                                              case 4:
                                                operatorSelected = 4;
                                                break;
                                              case 5:
                                                operatorSelected = 4;
                                                break;
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "درصورت ترابرد سیمکارت،اپراتور را انتخاب کنید",
                                    style: TextStyle(
                                        color: MyColors.otp_underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: shouldTrabord,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 35, right: 35, top: 10, bottom: 10),
                            color: Colors.transparent,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                operatorSelected = 1;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              foregroundDecoration: BoxDecoration(
                                                color: (operatorSelected == 1)
                                                    ? Colors.transparent
                                                    : Colors.grey,
                                                backgroundBlendMode:
                                                BlendMode.saturation,
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
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
                                                  Text("رایتل",style: TextStyle(fontSize: 10),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                operatorSelected = 2;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              foregroundDecoration: BoxDecoration(
                                                color: (operatorSelected == 2)
                                                    ? Colors.transparent
                                                    : Colors.grey,
                                                backgroundBlendMode:
                                                BlendMode.saturation,
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: Container(


                                                      child: Image.asset(
                                                        'assets/image_icon/hamrah_aval_icon.png',
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                  ),
                                                  Text("همراه اول",style: TextStyle(fontSize: 10),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                operatorSelected = 3;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              foregroundDecoration: BoxDecoration(
                                                color: (operatorSelected == 3)
                                                    ? Colors.transparent
                                                    : Colors.grey,
                                                backgroundBlendMode:
                                                BlendMode.saturation,
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: Container(


                                                      child: Image.asset(
                                                        'assets/image_icon/irancell_icon.png',
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                  ),
                                                  Text("ایرانسل",style: TextStyle(fontSize: 10),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Visibility(
                            visible:
                                (simTransactionsList.length > 0) ? true : false,
                            child: Divider(
                              thickness: 1,
                            )),
                        Visibility(
                          visible:
                              (simTransactionsList.length > 0) ? true : false,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "خرید های قبلی",
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                            visible:
                                (simTransactionsList.length > 0) ? true : false,
                            child: Row(
                              children: prepareListOfLastTransactions(),
                            ))
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
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
                      onPressed: (_isButtonNextDisabled_page1 ||
                              (operatorSelected == 4))
                          ? null
                          : () async {
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
                                child: Text("انتخاب نوع شارژ")))),
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
                                                ? MyColors.otp_underline2
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
                                                ? MyColors.otp_underline2
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
                                                ? MyColors.otp_underline2
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
                                                ? MyColors.otp_underline2
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
                                                ? MyColors.otp_underline2
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
                                                ? MyColors.otp_underline2
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

                              GetWageApprotionsParam getWageApprotionsParam =
                                  GetWageApprotionsParam(
                                      operationCode: (operatorSelected == 3)
                                          ? 9
                                          : (operatorSelected == 2)
                                              ? 7
                                              : 8,
                                      amount:
                                          int.parse(prepareFinalChargeCost()));

                              BlocProvider.of<ChargeSimBloc>(context).add(
                                  GetWageApprotionsEvent(
                                      getWageApprotionsParam));
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
                                      totalAmountWithkarmozd.seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    Text(
                                      "مبلغ شارژ + کارمزد",
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
                          flex: 7,
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
                                    flex: 3,
                                    child: Container(
                                        child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32, right: 32),
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
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32, right: 32),
                                            child: Row(
                                              children: [
                                                Text(
                                                  totalAmountWithkarmozd
                                                          .seRagham() +
                                                      " ریال",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                                Spacer(),
                                                Text(
                                                  "مبلغ شارژ + کارمزد",
                                                  style: TextStyle(
                                                      color: Colors.grey),
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

  List<Widget> prepareListOfLastTransactions() {
    List<Widget> totalList = [];
    if (simTransactionsList.length == 1) {
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[0].operatorType!;
              _phoneController.text = simTransactionsList[0].phoneNumber!;
              chargeAmountSelected = simTransactionsList[0].chargeAmountType!;
              payTypeSelected = simTransactionsList[0].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[0].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[0].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[0].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(flex: 20, child: Container()));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(flex: 20, child: Container()));
    }

    if (simTransactionsList.length == 2) {
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[0].operatorType!;
              _phoneController.text = simTransactionsList[0].phoneNumber!;
              chargeAmountSelected = simTransactionsList[0].chargeAmountType!;
              payTypeSelected = simTransactionsList[0].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[0].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[0].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[0].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[1].operatorType!;
              _phoneController.text = simTransactionsList[1].phoneNumber!;
              chargeAmountSelected = simTransactionsList[1].chargeAmountType!;
              payTypeSelected = simTransactionsList[1].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[1].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[1].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[1].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(flex: 20, child: Container()));
    }

    if (simTransactionsList.length == 3) {
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[0].operatorType!;
              _phoneController.text = simTransactionsList[0].phoneNumber!;
              chargeAmountSelected = simTransactionsList[0].chargeAmountType!;
              payTypeSelected = simTransactionsList[0].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[0].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[0].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[0].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[1].operatorType!;
              _phoneController.text = simTransactionsList[1].phoneNumber!;
              chargeAmountSelected = simTransactionsList[1].chargeAmountType!;
              payTypeSelected = simTransactionsList[1].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[1].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[1].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[1].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
      totalList.add(Expanded(flex: 2, child: Container()));
      totalList.add(Expanded(
          flex: 20,
          child: InkWell(
            onTap: () {
              operatorSelected = simTransactionsList[2].operatorType!;
              _phoneController.text = simTransactionsList[2].phoneNumber!;
              chargeAmountSelected = simTransactionsList[2].chargeAmountType!;
              payTypeSelected = simTransactionsList[2].paymentType!;

              BlocProvider.of<ChargeSimBloc>(context).add(GetBalanceEvent());

              GetWageApprotionsParam getWageApprotionsParam =
                  GetWageApprotionsParam(
                      operationCode: (operatorSelected == 3)
                          ? 9
                          : (operatorSelected == 2)
                              ? 7
                              : 8,
                      amount: int.parse(prepareFinalChargeCost()));

              BlocProvider.of<ChargeSimBloc>(context)
                  .add(GetWageApprotionsEvent(getWageApprotionsParam));
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      prepareBuyedMobileOperatorIcon(
                          simTransactionsList[2].operatorType!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(simTransactionsList[2].phoneNumber.toString()),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                        prepareBuyedMobileChargeAmount(
                                    simTransactionsList[2].chargeAmountType!)
                                .seRagham() +
                            " ریال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
          )));
    }

    return totalList;
  }

  String prepareEnteredMobileOperatorName() {
    int resultOperator =
        OperatorFinder.findOperator(_phoneController.text.trim());
    String result = "";

    switch (resultOperator) {
      case 1:
        result = "همراه اول";
        break;
      case 2:
        result = "ایرانسل";
        break;
      case 3:
        result = "رایتل";
        break;
    }

    return result;
  }

  String prepareEnteredMobileOperatorIcon() {
    int resultOperator =
        OperatorFinder.findOperator(_phoneController.text.trim());
    String result = "";

    switch (resultOperator) {
      case 1:
        result = "assets/image_icon/hamrah_aval_icon.png";
        break;
      case 2:
        result = "assets/image_icon/irancell_icon.png";
        break;
      case 3:
        result = "assets/image_icon/rightel_icon.png";
        break;
    }

    return result;
  }

  String prepareBuyedMobileOperatorIcon(int operatorType) {
    String result = "";

    switch (operatorType) {
      case 2:
        result = "assets/image_icon/hamrah_aval_icon.png";
        break;
      case 3:
        result = "assets/image_icon/irancell_icon.png";
        break;
      case 1:
        result = "assets/image_icon/rightel_icon.png";
        break;
    }

    return result;
  }

  String prepareBuyedMobileChargeAmount(int chargeAmountSelected) {
    // 1 5000toman  ,2   10000toman,3   15000toman,4   20000toman,5   30000toman,6   50000toman,

    String result = "";

    switch (chargeAmountSelected) {
      case 1:
        result = "50000";
        break;
      case 2:
        result = "100000";
        break;
      case 3:
        result = "150000";
        break;
      case 4:
        result = "200000";
        break;
      case 5:
        result = "300000";
        break;
      case 6:
        result = "500000";
        break;
    }

    return result;
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
                subject: ' ',
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
