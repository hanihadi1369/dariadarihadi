import 'package:atba_application/core/params/transfer_kifbkif_param.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/balance_status_wallet.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/loading.dart';
import '../block/charge_wallet_status.dart';
import '../block/transfer_kifbkif_status.dart';
import '../block/wallet_bloc.dart';

class WalletScreenView extends StatefulWidget {
  @override
  _WalletScreenViewState createState() => _WalletScreenViewState();
}

class _WalletScreenViewState extends State<WalletScreenView> {
  int pageIndex = 1;

  final _formKey_kart_number = GlobalKey<FormState>();
  final _formKey_increase_amount = GlobalKey<FormState>();
  final _formKey_decrease_amount = GlobalKey<FormState>();
  final _formKey_transfer_amount = GlobalKey<FormState>();

  TextEditingController _kartNumberController = TextEditingController();
  TextEditingController _kartNumberController_transfer =
      TextEditingController();
  TextEditingController _increaseAmountController = TextEditingController();
  TextEditingController _decreaseAmountController = TextEditingController();
  TextEditingController _transferAmountController = TextEditingController();

  final _formKey_cvv2 = GlobalKey<FormState>();
  final _formKey_secondPassword = GlobalKey<FormState>();
  final _formKey_kart_number_transfer = GlobalKey<FormState>();
  TextEditingController _cvv2Controller = TextEditingController();
  TextEditingController _secondPasswordController = TextEditingController();

  bool _isButtonNextDisabled_page2_condition1 = true;
  bool _isButtonNextDisabled_page21_condition1 = true; //password type2
  bool _isButtonNextDisabled_page21_condition2 = true; //cvv2
  bool _isButtonNextDisabled_page21_condition3 = true; //card number
  bool _isButtonNextDisabled_page3_condition1 = true;
  bool _isButtonNextDisabled_page4_condition1 = true; //card number transfer
  bool _isButtonNextDisabled_page4_condition2 = true;

  late Jalali selectedDate;

  int increaseAmountSelected =
      0; // >>  0 nothing ,  1 2000toman  ,2   50000toman,3   100000toman , 4  custom

  int decreaseAmountSelected =
      0; // >>  0 nothing ,  1 2000toman  ,2   50000toman,3   100000toman , 4  custom

  String balance = "***";
  String transferKifBKifRecepit = "***";

  final _formKey_kifbkif_1 = GlobalKey<FormState>();
  final _formKey_kifbkif_2 = GlobalKey<FormState>();
  TextEditingController _textEdit_controler_kifbkif_1 = TextEditingController();
  TextEditingController _textEdit_controler_kifbkif_2 = TextEditingController();
  bool _isButtonNextDisabled_page5_condition1 = true; //card number transfer
  bool _isButtonNextDisabled_page5_condition2 = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WalletBloc>(context).add(GetBalanceEvent());
    _intenetReciever();
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

        if (pageIndex == 5 ||
            pageIndex == 51 ||
            pageIndex == 2 ||
            pageIndex == 3 ||
            pageIndex == 4) {
          _textEdit_controler_kifbkif_1.clear();
          _textEdit_controler_kifbkif_2.clear();
          _isButtonNextDisabled_page5_condition1 = true;
          _isButtonNextDisabled_page5_condition2 = true;

          if (pageIndex == 51) {
            BlocProvider.of<WalletBloc>(context).add(GetBalanceEvent());
          }
          setState(() {
            pageIndex = 1;
          });
        }

        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<WalletBloc, WalletState>(
            listener: (context, state) async {
              if (state.balanceStatus is BalanceError) {
                BalanceError error = state.balanceStatus as BalanceError;
                _showSnackBar(error.message);
                state.balanceStatus = BalanceInit();
              }
              if (state.chargeWalletStatus is ChargeWalletError) {
                ChargeWalletError error =
                    state.chargeWalletStatus as ChargeWalletError;
                _showSnackBar(error.message);
                state.chargeWalletStatus = ChargeWalletInit();
              }
              if (state.transferKifBKifStatus is TransferKifBKifError) {
                TransferKifBKifError error =
                    state.transferKifBKifStatus as TransferKifBKifError;
                _showSnackBar(error.message);
                state.transferKifBKifStatus = TransferKifBKifInit();
              }

              if (state.chargeWalletStatus is ChargeWalletCompleted) {
                ChargeWalletCompleted chargeWalletCompleted =
                    state.chargeWalletStatus as ChargeWalletCompleted;
                if (chargeWalletCompleted.chargeWalletEntity.isFailed ==
                    false) {
                  try {
                    await launchUrlString(
                        chargeWalletCompleted.chargeWalletEntity.value!.url!);
                  } catch (e) {}
                }
              }
            },
            builder: (context, state) {
              if (state.chargeWalletStatus is ChargeWalletLoading ||
                  state.balanceStatus is BalanceLoading ||
                  state.transferKifBKifStatus is TransferKifBKifLoading) {
                return LoadingPage();
              }

              if (state.balanceStatus is BalanceCompleted) {
                BalanceCompleted balanceCompleted =
                    state.balanceStatus as BalanceCompleted;
                if (balanceCompleted.getBalanceEntity.isFailed == false) {
                  balance = balanceCompleted.getBalanceEntity.value![0].store!
                      .toString();
                }
              }

              if (state.transferKifBKifStatus is TransferKifBKifCompleted) {
                TransferKifBKifCompleted transferKifBKifCompleted =
                    state.transferKifBKifStatus as TransferKifBKifCompleted;
                if (transferKifBKifCompleted.transferKifBKifEntity.isFailed ==
                    false) {
                  transferKifBKifRecepit = transferKifBKifCompleted
                      .transferKifBKifEntity.value!.receiptID!
                      .toString();
                  pageIndex = 51;
                  state.transferKifBKifStatus = TransferKifBKifInit();
                }
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

  void _intenetReciever() {
    try {
      ReceiveIntent.receivedIntentStream.listen((event) async {
        if (event?.extra != null) {
          int i = 5;
          i++;
        }
      });
    } on PlatformException {}
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

  bool myLateVariableInitialized() {
    try {
      selectedDate.toString();
      return true;
    } catch (e) {
      return false;
    }
  }

  preparePageIndex() {
    // index 1 > main wallet page
    // index 2 > increase main page -- 21 increase sub1 --22 increase sub2
    // index 3 > decrease main page
    // index 4 > transfer main page -- 41 transfer sub1
    // index 5 > kif b kif -- 51 result

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
                                child: Text("کیف پول")))),
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.text_field_bg,
                      border: Border.all(
                        color: MyColors.button_bg_enabled,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "موجودی کیف پول",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        (balance == "***")
                            ? "نامشخص"
                            : "${balance} ریال".toPersianDigit(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: Container(
                            decoration: BoxDecoration(
                                color: MyColors.text_field_bg,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                        color: Colors.grey,
                                        backgroundBlendMode:
                                            BlendMode.saturation,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Image.asset(
                                        'assets/image_icon/back_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "شارژ خودکار کیف پول",
                                                style: TextStyle(fontSize: 13),
                                              ))),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/image_icon/auto_wallet_charge.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _textEdit_controler_kifbkif_1.clear();
                          _textEdit_controler_kifbkif_2.clear();
                          _isButtonNextDisabled_page5_condition1 = true;
                          _isButtonNextDisabled_page5_condition2 = true;

                          setState(() {
                            pageIndex = 5;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 32, right: 32),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.text_field_bg,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        foregroundDecoration: BoxDecoration(
                                          color: Colors.grey,
                                          backgroundBlendMode:
                                              BlendMode.saturation,
                                        ),
                                        padding: EdgeInsets.all(15),
                                        child: Image.asset(
                                          'assets/image_icon/back_icon.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      )),
                                  Expanded(flex: 2, child: Container()),
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "انتقال کیف پول به کیف پول",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ))),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          'assets/image_icon/wallet_transactions.png',
                                          fit: BoxFit.contain,
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: Container(
                            decoration: BoxDecoration(
                                color: MyColors.text_field_bg,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                        color: Colors.grey,
                                        backgroundBlendMode:
                                            BlendMode.saturation,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Image.asset(
                                        'assets/image_icon/back_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                                Expanded(flex: 2, child: Container()),
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "مشاهده گردش کیف پول",
                                                style: TextStyle(fontSize: 13),
                                              ))),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/image_icon/wallet_transactions.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 6, child: Container()),
          Expanded(
            flex: 3,
            child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pageIndex = 3;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/image_icon/decrement_icon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                  child: Text("برداشت"),
                                ))
                              ],
                            ),
                          ),
                        )),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pageIndex = 4;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/image_icon/transfer_icon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                  child: Text("انتقال"),
                                ))
                              ],
                            ),
                          ),
                        )),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pageIndex = 2;
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'assets/image_icon/increment_icon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                                Expanded(
                                    child: Container(
                                  child: Text("افزایش"),
                                ))
                              ],
                            ),
                          ),
                        )),
                    Expanded(flex: 1, child: Container()),
                  ],
                )),
          ),
          Expanded(flex: 1, child: Container()),
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
                                child: Text("کیف پول")))),
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
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "مبلغ مورد نظر خود را وارد نمایید",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Form(
                                    key: _formKey_increase_amount,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 8,
                                            controller:
                                                _increaseAmountController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }
                                              int decimalValue =
                                                  int.parse(value);
                                              if (decimalValue < 1000) {
                                                return 'مقدار وارد شده معتبر نیست';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page2_condition1 =
                                                    !_formKey_increase_amount
                                                        .currentState!
                                                        .validate();

                                                if (value == 20000) {
                                                  increaseAmountSelected = 1;
                                                } else if (value == 500000) {
                                                  increaseAmountSelected = 2;
                                                } else if (value == 1000000) {
                                                  increaseAmountSelected = 3;
                                                } else {
                                                  increaseAmountSelected = 4;
                                                }
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              suffixText: "ریال",
                                              suffixStyle:
                                                  TextStyle(fontSize: 12),
                                              filled: true,
                                              hintText: "مانند 200.000 ریال",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                              fillColor: Color(0x32E1E3E0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            increaseAmountSelected = 3;
                                            _increaseAmountController.text =
                                                "1000000";
                                            _isButtonNextDisabled_page2_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (increaseAmountSelected == 3)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "1.000.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (increaseAmountSelected ==
                                                            3)
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
                                            increaseAmountSelected = 2;
                                            _increaseAmountController.text =
                                                "500000";
                                            _isButtonNextDisabled_page2_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (increaseAmountSelected == 2)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "500.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (increaseAmountSelected ==
                                                            2)
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
                                            increaseAmountSelected = 1;
                                            _increaseAmountController.text =
                                                "20000";
                                            _isButtonNextDisabled_page2_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (increaseAmountSelected == 1)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "20.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (increaseAmountSelected ==
                                                            1)
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
                            Expanded(child: Container()),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 8, child: Container()),
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
                      onPressed:
                          (_isButtonNextDisabled_page2_condition1 == true)
                              ? null
                              : () {
                                  int amountInt =
                                      int.parse(_increaseAmountController.text);

                                  BlocProvider.of<WalletBloc>(context)
                                      .add(ChargeWalletEvent(amountInt));
                                },
                      child: Text('تایید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 21) {
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
                                child: Text("کیف پول")))),
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
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "شارژ کیف پول",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "عنوان",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _increaseAmountController.text.trim() + " ریال",
                              textDirection: TextDirection.rtl,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "مبلغ واریزی",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
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
                    dashColor: Colors.grey,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 12,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page21_condition3 =
                                        !_formKey_kart_number.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              Jalali? picked = await showPersianDatePicker(
                                context: context,
                                initialDate: Jalali.now(),
                                firstDate: Jalali(1402, 1),
                                lastDate: Jalali(1410, 12),
                              );
                              setState(() {
                                selectedDate = picked!;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            (myLateVariableInitialized())
                                                ? ((selectedDate
                                                        .formatter.yyyy) +
                                                    " " +
                                                    (selectedDate.formatter.mN))
                                                : "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _isButtonNextDisabled_page21_condition2 =
                                                  !_formKey_cvv2.currentState!
                                                      .validate();
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
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
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _isButtonNextDisabled_page21_condition1 =
                                                  !_formKey_secondPassword
                                                      .currentState!
                                                      .validate();
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
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
                          )),
                        ],
                      )
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
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_page21_condition3 ||
                              _isButtonNextDisabled_page21_condition1 ||
                              (!myLateVariableInitialized()) ||
                              _isButtonNextDisabled_page21_condition2)
                          ? null
                          : () {
                              setState(() {
                                pageIndex = 22;
                              });
                            },
                      child: Text('پرداخت با کارت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 22) {
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
                                child: Text("کیف پول")))),
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
              flex: 4,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                      Container(child: Text("شارژ کیف پول"))),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "شارژ شد",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _increaseAmountController.text
                                              .trim()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "مبلغ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/image_icon/success_wallet_charge.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ))
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
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
                        Text("5047 0610 **** 5432"),
                        Spacer(),
                        Text(
                          "کارت",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("12345678"),
                        Spacer(),
                        Text(
                          "شماره پیگیری",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
              )),
          Expanded(flex: 4, child: Container()),
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
                                child: Text("کیف پول")))),
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.text_field_bg,
                      border: Border.all(
                        color: MyColors.button_bg_enabled,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "موجودی قابل برداشت",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "2.000.000 ربال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
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
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "مبلغ مورد نظر خود را وارد نمایید",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Form(
                                    key: _formKey_decrease_amount,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 8,
                                            controller:
                                                _decreaseAmountController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }
                                              int decimalValue =
                                                  int.parse(value);
                                              if (decimalValue < 1000) {
                                                return 'مقدار وارد شده معتبر نیست';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page3_condition1 =
                                                    !_formKey_decrease_amount
                                                        .currentState!
                                                        .validate();

                                                if (value == 20000) {
                                                  decreaseAmountSelected = 1;
                                                } else if (value == 500000) {
                                                  decreaseAmountSelected = 2;
                                                } else if (value == 1000000) {
                                                  decreaseAmountSelected = 3;
                                                } else {
                                                  decreaseAmountSelected = 4;
                                                }
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              suffixText: "ریال",
                                              suffixStyle:
                                                  TextStyle(fontSize: 12),
                                              filled: true,
                                              hintText: "مانند 200.000 ریال",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                              fillColor: Color(0x32E1E3E0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            decreaseAmountSelected = 3;
                                            _decreaseAmountController.text =
                                                "1000000";
                                            _isButtonNextDisabled_page3_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (decreaseAmountSelected == 3)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "1.000.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (decreaseAmountSelected ==
                                                            3)
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
                                            decreaseAmountSelected = 2;
                                            _decreaseAmountController.text =
                                                "500000";
                                            _isButtonNextDisabled_page3_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (decreaseAmountSelected == 2)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "500.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (decreaseAmountSelected ==
                                                            2)
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
                                            decreaseAmountSelected = 1;
                                            _decreaseAmountController.text =
                                                "20000";
                                            _isButtonNextDisabled_page3_condition1 =
                                                false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (decreaseAmountSelected == 1)
                                                ? MyColors.button_bg_enabled
                                                : MyColors.text_field_bg,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "20.000 ریال",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color:
                                                    (decreaseAmountSelected ==
                                                            1)
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
                            Expanded(child: Container()),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 4, child: Container()),
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
                      onPressed:
                          (_isButtonNextDisabled_page3_condition1 == true)
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                },
                      child: Text('برداشت'),
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
                                child: Text("کیف پول")))),
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.text_field_bg,
                      border: Border.all(
                        color: MyColors.button_bg_enabled,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "موجودی کیف پول",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "2.000.000 ربال",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 8,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "لطفا اطلاعات زیر را وارد کنید",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            )),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Form(
                                    key: _formKey_kart_number_transfer,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 16,
                                            controller:
                                                _kartNumberController_transfer,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              } else if (value
                                                  .isValidBankCardNumber()) {
                                                return 'شماره کارت معتبر نیست';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page4_condition1 =
                                                    !_formKey_kart_number_transfer
                                                        .currentState!
                                                        .validate();
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              filled: true,
                                              fillColor: Color(0x32E1E3E0),
                                              hintText: "شماره کارت",
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
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
                                  child: Form(
                                    key: _formKey_transfer_amount,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 8,
                                            controller:
                                                _transferAmountController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }
                                              int decimalValue =
                                                  int.parse(value);
                                              if (decimalValue < 1000) {
                                                return 'مقدار وارد شده معتبر نیست';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page4_condition2 =
                                                    !_formKey_transfer_amount
                                                        .currentState!
                                                        .validate();
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              suffixText: "ریال",
                                              suffixStyle:
                                                  TextStyle(fontSize: 12),
                                              filled: true,
                                              hintText: "مانند 200.000 ریال",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                              fillColor: Color(0x32E1E3E0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(child: Container()),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 4, child: Container()),
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
                      onPressed: (_isButtonNextDisabled_page4_condition1 ==
                                  true ||
                              _isButtonNextDisabled_page4_condition2 == true)
                          ? null
                          : () {
                              //should show bottom sheet dialog
                              showMaterialModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                builder: (context) => Container(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  height: MediaQuery.of(context).size.height /
                                      (2.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 16,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Text("هادی قدیری"),
                                            Spacer(),
                                            Text(
                                              "نام گیرنده",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 0,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              _transferAmountController.text
                                                      .trim()
                                                      .seRagham() +
                                                  " ریال",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Spacer(),
                                            Text(
                                              "مبلغ واریزی",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 0,
                                            bottom: 16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/image_icon/bank_shahr_icon.png',
                                              fit: BoxFit.scaleDown,
                                            ),
                                            Text(
                                              "بانک شهر",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            Spacer(),
                                            Text(
                                              "بانک مقصد",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 0,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Text(_kartNumberController_transfer
                                                .text
                                                .trim()),
                                            Spacer(),
                                            Text(
                                              "شماره کارت",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: MyColors.otp_underline,
                                        dashRadius: 0.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                        return Colors.white;
                                                      },
                                                    ),
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            color: MyColors
                                                                .otp_underline),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  child: Text(
                                                    "انصراف",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .otp_underline),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                        return MyColors
                                                            .otp_underline;
                                                      },
                                                    ),
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            color: MyColors
                                                                .otp_underline),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      pageIndex = 41;
                                                    });
                                                  },
                                                  child: Text(
                                                    "تایید",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                      child: Text('تایید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 41) {
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
                                child: Text("کیف پول")))),
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
              flex: 4,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "انتقال یافت",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _transferAmountController.text
                                              .trim()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "مبلغ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/image_icon/success_transfer.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ))
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
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
                        Text("5047 0610 **** 5432"),
                        Spacer(),
                        Text(
                          "کارت",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("12345678"),
                        Spacer(),
                        Text(
                          "شماره پیگیری",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
              )),
          Expanded(flex: 4, child: Container()),
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

    if (pageIndex == 5) {
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
                          _textEdit_controler_kifbkif_1.clear();
                          _textEdit_controler_kifbkif_2.clear();
                          _isButtonNextDisabled_page5_condition1 = true;
                          _isButtonNextDisabled_page5_condition2 = true;
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
                                child: Text("کیف به کیف")))),
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.text_field_bg,
                      border: Border.all(
                        color: MyColors.button_bg_enabled,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "موجودی کیف پول",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        (balance == "***")
                            ? "نامشخص"
                            : "${balance} ریال".toPersianDigit(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 8,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "لطفا اطلاعات زیر را وارد کنید",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  )),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Form(
                                    key: _formKey_kifbkif_1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 16,
                                            controller:
                                                _textEdit_controler_kifbkif_1,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page5_condition1 =
                                                    !_formKey_kifbkif_1
                                                        .currentState!
                                                        .validate();
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              filled: true,
                                              fillColor: Color(0x32E1E3E0),
                                              hintText: "شماره تلفن همراه",
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "مبلغ مورد نظر خود را وارد نمایید",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  )),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Form(
                                    key: _formKey_kifbkif_2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 8,
                                            controller:
                                                _textEdit_controler_kifbkif_2,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }
                                              int decimalValue =
                                                  int.parse(value);
                                              if (decimalValue < 1000) {
                                                return 'مقدار وارد شده معتبر نیست';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page5_condition2 =
                                                    !_formKey_kifbkif_2
                                                        .currentState!
                                                        .validate();
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              suffixText: "ریال",
                                              suffixStyle:
                                                  TextStyle(fontSize: 12),
                                              filled: true,
                                              hintText: "مانند 200.000 ریال",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                              fillColor: Color(0x32E1E3E0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(child: Container()),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 4, child: Container()),
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
                      onPressed: (_isButtonNextDisabled_page5_condition1 ==
                                  true ||
                              _isButtonNextDisabled_page5_condition2 == true)
                          ? null
                          : () {
                              //should show bottom sheet dialog
                              showMaterialModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                builder: (BuildContext _context) => Container(
                                  padding: EdgeInsets.only(left: 32, right: 32),
                                  height: MediaQuery.of(context).size.height /
                                      (2.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 16,
                                            bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("انتقال وجه کیف به کیف"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 16,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Text(_textEdit_controler_kifbkif_1
                                                .text
                                                .toString()),
                                            Spacer(),
                                            Text(
                                              "شماره تلفن همراه",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                            top: 0,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              _textEdit_controler_kifbkif_2.text
                                                      .trim()
                                                      .seRagham() +
                                                  " ریال",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Spacer(),
                                            Text(
                                              "مبلغ واریزی",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: MyColors.otp_underline,
                                        dashRadius: 0.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                        return Colors.white;
                                                      },
                                                    ),
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            color: MyColors
                                                                .otp_underline),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  child: Text(
                                                    "انصراف",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .otp_underline),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .resolveWith<Color>(
                                                      (Set<MaterialState>
                                                          states) {
                                                        return MyColors
                                                            .otp_underline;
                                                      },
                                                    ),
                                                    padding:
                                                        MaterialStateProperty.all<
                                                            EdgeInsetsGeometry>(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            color: MyColors
                                                                .otp_underline),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    TransferKifBKifParam
                                                        transferKifBKifParam =
                                                        TransferKifBKifParam(
                                                            amount: int.parse(
                                                                _textEdit_controler_kifbkif_2
                                                                    .text
                                                                    .trim()),
                                                            mobileNumber:
                                                                _textEdit_controler_kifbkif_1
                                                                    .text
                                                                    .trim());
                                                    BlocProvider.of<WalletBloc>(
                                                            context)
                                                        .add(TransferKifBKifEvent(
                                                            transferKifBKifParam));
                                                  },
                                                  child: Text(
                                                    "تایید",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                      child: Text('تایید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 51) {
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
                                child: Text("انتقال کیف به کیف")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<WalletBloc>(context)
                              .add(GetBalanceEvent());
                          _textEdit_controler_kifbkif_1.clear();
                          _textEdit_controler_kifbkif_2.clear();
                          _isButtonNextDisabled_page5_condition1 = true;
                          _isButtonNextDisabled_page5_condition2 = true;
                          setState(() {
                            pageIndex = 1;
                          });
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
              flex: 4,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "انتقال یافت",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _textEdit_controler_kifbkif_2.text
                                              .trim()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "مبلغ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              'assets/image_icon/success_transfer.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ))
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
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
                        Text(_textEdit_controler_kifbkif_1.text
                            .toString()
                            .trim()),
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
                        Text(transferKifBKifRecepit),
                        Spacer(),
                        Text(
                          "شماره پیگیری",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
              )),
          Expanded(flex: 4, child: Container()),
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
}
