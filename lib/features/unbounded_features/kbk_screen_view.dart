import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../core/utils/colors.dart';

class KbkScreenView extends StatefulWidget {
  @override
  _KbkScreenViewState createState() => _KbkScreenViewState();
}

class _KbkScreenViewState extends State<KbkScreenView> {
  int pageIndex = 0;

  final _formKey_kart_number = GlobalKey<FormState>();
  final _formKey_amount = GlobalKey<FormState>();
  bool _isButtonNextDisabled_page1_condition1 = true;
  bool _isButtonNextDisabled_page1_condition2 = true;
  TextEditingController _kartNumberController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  final _formKey_cvv2 = GlobalKey<FormState>();
  final _formKey_secondPassword = GlobalKey<FormState>();
  TextEditingController _cvv2Controller = TextEditingController();
  TextEditingController _secondPasswordController = TextEditingController();

  bool _isButtonNextDisabled_page2_condition1 = true; // cvv2
  bool _isButtonNextDisabled_page2_condition3 = true; //password type2
  late Jalali selectedDate;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: preparePageIndex(),
        ),
      ),
    );
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
    // index 0 > comming soon
    // index 1 > kart Property 1
    // index 2 > kart Property 2
    // index 3 > result



    if (pageIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: Container()),
          Expanded(
              flex: 14,
              child: Container(
                padding:
                EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 0),
                color: Colors.transparent,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "صفحه در حال پیاده سازی می باشد.",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 16,),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Image.asset(
                          'assets/image_icon/under_dev.png',
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "تماس با پشتیبانی",
                          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                        ),

                      ],
                    ),
                  ),
                ),
              )),
          Expanded(flex: 3, child: Container()),
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
                        Navigator.of(context).pop();
                      },
                      child: Text('بازگشت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

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
                                child: Text("کارت به کارت")))),
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
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "کارت مبدأ",
                          style: TextStyle(fontSize: 13),
                        )),
                    Expanded(
                        child: Container(
                      child: Image.asset(
                        'assets/image_icon/card_frame_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    )),
                  ],
                ),
              )),
          Expanded(
              flex: 9,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 0),
                color: Colors.transparent,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "اطلاعات مقصد را وارد کنید",
                              style: TextStyle(fontSize: 12),
                            )),
                        SizedBox(
                          height: 5,
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
                                      _isButtonNextDisabled_page1_condition1 =
                                          !_formKey_kart_number.currentState!
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
                                    filled: true,
                                    fillColor: Color(0x32E1E3E0),
                                    hintText: "شماره کارت یا شبا (بدون IR)",
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
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "مبلغ مورد نظر را وارد کنید",
                              style: TextStyle(fontSize: 12),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _formKey_amount,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  maxLength: 8,
                                  controller: _amountController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'مقدار وارد شده خالی است';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _isButtonNextDisabled_page1_condition2 =
                                          !_formKey_amount.currentState!
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
                                    suffixText: "ریال",
                                    suffixStyle: TextStyle(fontSize: 12),
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
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              (_amountController.text.trim() != "")
                                  ? _amountController.text
                                          .trim()
                                          .beToman()
                                          .seRagham() +
                                      " تومان"
                                  : "",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueAccent),
                            )),
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(flex: 3, child: Container()),
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
                      onPressed: (_isButtonNextDisabled_page1_condition1 ||
                              _isButtonNextDisabled_page1_condition2)
                          ? null
                          : () {
                              setState(() {
                                pageIndex = 2;
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
                                child: Text("کارت به کارت")))),
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
              flex: 4,
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
                              "هادی قدیری",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "نام گیرنده",
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
                              _amountController.text.trim().seRagham() +
                                  " ریال",
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
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image_icon/bank_shahr_icon.png',
                              fit: BoxFit.scaleDown,
                            ),
                            Text(
                              "بانک شهر",
                              textDirection: TextDirection.rtl,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "بانک مقصد",
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
                              _kartNumberController.text.trim(),
                              textDirection: TextDirection.rtl,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "شماره کارت",
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
              flex: 11,
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
                      height: 20,
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
                                              ? ((selectedDate.formatter.yyyy) +
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
                                          if (value == null || value.isEmpty) {
                                            return 'مقدار وارد شده خالی است';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _isButtonNextDisabled_page2_condition1 =
                                                !_formKey_cvv2.currentState!
                                                    .validate();
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
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
                      height: 20,
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
                                          if (value == null || value.isEmpty) {
                                            return 'مقدار وارد شده خالی است';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _isButtonNextDisabled_page2_condition3 =
                                                !_formKey_secondPassword
                                                    .currentState!
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
                      onPressed: (_isButtonNextDisabled_page2_condition1 ||
                              (!myLateVariableInitialized()) ||
                              _isButtonNextDisabled_page2_condition3)
                          ? null
                          : () {
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
                                child: Text("کارت به کارت")))),
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
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/image_icon/bank_shahr_big_icon.png",
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(child: Text("هادی قدیری"))),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      child: Text(_kartNumberController.text)))
                            ],
                          )),
                      Expanded(
                        flex: 2,
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
                                      _amountController.text.trim().seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "مبلغ انتقال",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                          child: Container(
                        child: Image.asset(
                          'assets/image_icon/success_transfer.png',
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
                        Text("کارت به کارت"),
                        Spacer(),
                        Text(
                          "روش انتقال",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("علی رفعتی"),
                        Spacer(),
                        Text(
                          "انتقال دهنده",
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
                          "کارت مبدا",
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
                          //   child: Visibility(
                          //     visible: false,
                          //     child: Image.asset(
                          //       'assets/image_icon/save_in_gallery.png',
                          //       fit: BoxFit.scaleDown,
                          //     ),
                          //   ),
                          // )
                          //
                          //
                          //
                          // ),
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
