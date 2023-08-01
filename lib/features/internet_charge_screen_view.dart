import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../core/utils/colors.dart';



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
  int timeTypeTabIndex = 1 ; // >> 1 daily , 2 threeday , 3 weekly  , 4 fifteen day  , 5 monthly

  final _formKey_page1 = GlobalKey<FormState>();
  bool _isButtonNextDisabled_page1 = true;
  TextEditingController _phoneController = TextEditingController();

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
                                child: Text("خرید بسته اینترنت")))),
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
                              "شماره سیم کارت اعتباری خود را وارد کنید",
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
                                        value
                                            .trim()
                                            .length != 11) {
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
                        //should show bottom sheet dialog
                        showMaterialModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          builder: (context) =>
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height /
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
                                child: Text("خرید بسته اینترنت")))),
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

          Expanded(flex: 2, child: Container(
            padding: EdgeInsets.only(left: 20,right: 20),
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
                    onTap: (){
                      setState(() {
                        timeTypeTabIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20.0),
                        color: (timeTypeTabIndex==1)? Colors.deepOrange:MyColors.button_label_disabled,
                      ),

                      child: Text(
                        "یک روزه", style: TextStyle(color: (timeTypeTabIndex == 1)?Colors.white:Colors.black),),),
                  ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          timeTypeTabIndex = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20.0),
                          color: (timeTypeTabIndex==2)? Colors.deepOrange:MyColors.button_label_disabled,
                        ),

                        child: Text(
                          "سه روزه", style: TextStyle(color: (timeTypeTabIndex == 2)?Colors.white:Colors.black),),),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          timeTypeTabIndex = 3;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20.0),
                          color: (timeTypeTabIndex==3)? Colors.deepOrange:MyColors.button_label_disabled,
                        ),

                        child: Text(
                          "هفتگی", style: TextStyle(color: (timeTypeTabIndex == 3)?Colors.white:Colors.black),),),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          timeTypeTabIndex = 4;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20.0),
                          color: (timeTypeTabIndex==4)? Colors.deepOrange:MyColors.button_label_disabled,
                        ),

                        child: Text(
                          "پانزده روزه", style: TextStyle(color: (timeTypeTabIndex == 4)?Colors.white:Colors.black),),),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          timeTypeTabIndex = 5;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20.0),
                          color: (timeTypeTabIndex==5)? Colors.deepOrange:MyColors.button_label_disabled,
                        ),

                        child: Text(
                          "ماهانه", style: TextStyle(color: (timeTypeTabIndex == 5)?Colors.white:Colors.black),),),
                    )

                ],),
              ),
            ),


          )),
          Expanded(flex: 16, child: Container(

            child: SingleChildScrollView(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                InkWell(

                  onTap: (){
                    setState(() {
                      pageIndex =3;
                    });
                  },

                  child: Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 32,right: 32),
                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Expanded(flex:1,child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/image_icon/go_orange_ison.png',
                            fit: BoxFit.scaleDown,
                          ),


                        ),
                      )),
                      Expanded(flex:3,child: Center(
                        child: Container(

                          child: Text("8000 ریال",textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,),
                        ),
                      )),
                      Expanded(flex:5,child: Container()),
                      Expanded(flex:5,child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                            ),
                        ],),

                      )),
                      Expanded(flex:1,child: Container()),
                      Expanded(flex:2,child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/image_icon/global_icon.png',
                            fit: BoxFit.scaleDown,
                          ),


                        ),
                      )),


                    ],),
                  )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),
                InkWell(

                    onTap: (){
                      setState(() {
                        pageIndex =3;
                      });
                    },

                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 32,right: 32),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex:1,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/go_orange_ison.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),
                          Expanded(flex:3,child: Center(
                            child: Container(

                              child: Text("8000 ریال",textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,),
                            ),
                          )),
                          Expanded(flex:5,child: Container()),
                          Expanded(flex:5,child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("یکروزه ۱.۵ گیگابایت",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("مبلغ + مالیات",textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,style: TextStyle(fontSize: 11,color: Colors.grey),),
                                ),
                              ],),

                          )),
                          Expanded(flex:1,child: Container()),
                          Expanded(flex:2,child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/image_icon/global_icon.png',
                                fit: BoxFit.scaleDown,
                              ),


                            ),
                          )),


                        ],),
                    )),



            ],)),

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
                                      "8000 ریال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    Text(
                                      "مبلغ شارژ + مالیات",
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
                                        ("موجودی کیف پول: ۲۰۰,۰۰۰ ریال"),
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
                        setState(() {
                          pageIndex = 4;
                        });
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
                                      "8000 ریال",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    Spacer(),
                                    Text(
                                      "مبلغ شارژ + مالیات",
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
                        Text("12345678"),
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
}
