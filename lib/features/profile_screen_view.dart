
import 'package:atba_application/features/wallet_screen_view.dart';
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


import '../core/utils/colors.dart';
import '../core/utils/slide_right_transition.dart';
import 'kbk_screen_view.dart';

class ProfileScreenView extends StatefulWidget {
  @override
  _ProfileScreenViewState createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  int pageIndex = 1;

  final _formKey_firstname = GlobalKey<FormState>();
  final _formKey_lastname = GlobalKey<FormState>();
  final _formKey_phonenumber = GlobalKey<FormState>();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();




  bool _isButtonNextDisabled_page2_condition1 = true; //first name
  bool _isButtonNextDisabled_page2_condition2 = true; //last name
  bool _isButtonNextDisabled_page2_condition3 = true; //phone number




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

  preparePageIndex() {
    // index 1 > main profile page
    // index 2 > edit profile page


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
                                child: Text("حساب کاربری")))),
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
              child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: MyColors.button_bg_enabled,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container()
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/image_icon/add_user_image.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "09128222554",
                            style: TextStyle(
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "هادی قدیری",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: Row(children: [
                            Text(
                              "2,000,000 ریال".toPersianDigit(),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),

                            Spacer(),

                            Text(
                              "موجودی کیف پول",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 11,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex:1,child: Container()),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            pageIndex = 2;
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
                                                  "ویرایش حساب",
                                                  style: TextStyle(fontSize: 13),
                                                ))),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          'assets/image_icon/edit_profile.png',
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
                      child: InkWell(
                        onTap: (){

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
                                                  "شارژ کیف پول",
                                                  style: TextStyle(fontSize: 13),
                                                ))),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          'assets/image_icon/charge_wallet_small.png',
                                          fit: BoxFit.contain,
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Expanded(flex:6,child: Container())
                  ],
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
                      onTap: () {


                        Navigator.pop(context);

                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/image_icon/services_down_icon_grey.png',
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





                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/image_icon/profile_down_icon_green.png',
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
                                  color: MyColors.button_bg_enabled,
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
            ),
          ),
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
                                child: Text("حساب کاربری")))),
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
              flex: 12,
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
                              "لطفا اطلاعات فردی خود را کامل کنید",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                            child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Form(
                                    key: _formKey_firstname,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 20,
                                            controller:
                                                _firstnameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }

                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page2_condition1 =
                                                    !_formKey_firstname
                                                        .currentState!
                                                        .validate();


                                              });
                                            },
                                            keyboardType: TextInputType.text,
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
                                              hintText: "نام",
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
                                flex: 3,
                                child: Container(
                                  child: Form(
                                    key: _formKey_lastname,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 20,
                                            controller:
                                            _lastnameController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }

                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page2_condition2 =
                                                !_formKey_lastname
                                                    .currentState!
                                                    .validate();


                                              });
                                            },
                                            keyboardType: TextInputType.text,
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
                                              hintText: "نام خانوادگی",
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
                                flex: 3,
                                child: Container(
                                  child: Form(
                                    key: _formKey_phonenumber,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextFormField(
                                            maxLength: 11,
                                            controller:
                                            _phonenumberController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'مقدار وارد شده خالی است';
                                              }

                                              if(value.length != 11){
                                                return 'شماره تلفن همراه معتبر نیست';
                                              }

                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                _isButtonNextDisabled_page2_condition3 =
                                                !_formKey_phonenumber
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
                                              hintText: "شماره تلفن همراه",
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
                            Expanded(flex:2,child: Container()),
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
                          (_isButtonNextDisabled_page2_condition1 == true
                          ||
                              _isButtonNextDisabled_page2_condition2 ==true
                              ||
                              _isButtonNextDisabled_page2_condition3==true



                          )
                              ? null
                              : () {

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


  }
}
