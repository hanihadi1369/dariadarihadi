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



class BillsScreenView extends StatefulWidget {
  @override
  _BillsScreenViewState createState() => _BillsScreenViewState();
}

class _BillsScreenViewState extends State<BillsScreenView> {
  int pageIndex = 1;

  final _formKey_kart_number = GlobalKey<FormState>();

  final _formKey_decrease_amount = GlobalKey<FormState>();
  final _formKey_transfer_amount = GlobalKey<FormState>();

  TextEditingController _kartNumberController = TextEditingController();
  TextEditingController _kartNumberController_transfer =
      TextEditingController();

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

  //***************************************************************************

  TextEditingController _editBillController = TextEditingController();
  final _formKey_edit_bill = GlobalKey<FormState>();

  TextEditingController _waterBillController1 = TextEditingController();
  final _formKey_water_bill1 = GlobalKey<FormState>();
  TextEditingController _waterBillController2 = TextEditingController();
  final _formKey_water_bill2 = GlobalKey<FormState>();

  TextEditingController _barghBillController1 = TextEditingController();
  final _formKey_bargh_bill1 = GlobalKey<FormState>();
  TextEditingController _barghBillController2 = TextEditingController();
  final _formKey_bargh_bill2 = GlobalKey<FormState>();

  TextEditingController _gazBillController1 = TextEditingController();
  final _formKey_gaz_bill1 = GlobalKey<FormState>();
  TextEditingController _gazBillController2 = TextEditingController();
  final _formKey_gaz_bill2 = GlobalKey<FormState>();

  TextEditingController _phoneBillController1 = TextEditingController();
  final _formKey_phone_bill1 = GlobalKey<FormState>();
  TextEditingController _phoneBillController2 = TextEditingController();
  final _formKey_phone_bill2 = GlobalKey<FormState>();

  int selectedTicket =
      0; // >>  0 nothing ,  1 moshtarak  ,2   karaj,3   hashtgerd , 4  emam
  int ticketAmount = 1;
  int totalPrice = 20000;
  int ticketPrice = 20000;
  int payTypeSelected = 1;

  double heightOfModalBottomSheet = 50;

  String getTicketName(int index) {
    if (index == 1) {
      return "تک سفره مشترک مترو و بی آر تی";
    }
    if (index == 2) {
      return "تک سفره کرج";
    }
    if (index == 3) {
      return "تک سفره هشتگرد";
    }
    if (index == 4) {
      return "فرودگاه امام خمینی";
    }

    return "";
  }

  String getTicketLogo(int index) {
    if (index == 1) {
      return "assets/image_icon/metro_icon.png";
    }
    if (index == 2) {
      return "assets/image_icon/train_icon.png";
    }
    if (index == 3) {
      return "assets/image_icon/train_icon.png";
    }
    if (index == 4) {
      return "assets/image_icon/airplane_icon.png";
    }

    return "";
  }

  showTicketDialog(int index) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              height: MediaQuery.of(context).size.height / (2.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                                'assets/image_icon/close_red_icon.png'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "خرید بلیط تک سفره",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(getTicketLogo(index)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getTicketName(index),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (ticketAmount > 1)
                                ticketAmount = ticketAmount - 1;

                              totalPrice = ticketAmount * ticketPrice;
                            });

                            setModalState(() {
                              ticketAmount = ticketAmount;
                              totalPrice = totalPrice;
                            });
                          },
                          child: Container(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.asset(
                                  "assets/image_icon/minus_icon.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          ticketAmount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (ticketAmount <= 9)
                                ticketAmount = ticketAmount + 1;

                              totalPrice = ticketAmount * ticketPrice;
                            });

                            setModalState(() {
                              ticketAmount = ticketAmount;
                              totalPrice = totalPrice;
                            });
                          },
                          child: Container(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child:
                                  Image.asset("assets/image_icon/add_icon.png"),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "تعداد بلیط",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          (totalPrice.toString()).trim().seRagham() + " ریال",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: MyColors.button_bg_enabled, fontSize: 13),
                        ),
                        Spacer(),
                        Text(
                          "قیمت کل",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return MyColors.button_bg_enabled;
                            },
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: MyColors.otp_underline),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            pageIndex = 21;
                          });
                        },
                        child: Text(
                          "خرید بلیط",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          });
        });
  }

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
    // index 1 > main bills page
    // index 11 > watter bills page
    // index 12 > electricity bills page
    // index 13 > gas bills page
    // index 14 > phone bills page
    // index 2  > edit bills page

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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      )),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "20,000 ریال",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.button_bg_enabled,
                                      fontSize: 12),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
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
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 40.0,
                                                      ),
                                                      Text(
                                                        "آیا از حذف قبض مورد نظر اطمینان دارید؟",
                                                        style: TextStyle(
                                                            fontSize: 12.0),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                child: Text(
                                                                  "خیر",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.0,
                                                                      color: Colors
                                                                          .red),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            thickness: 10,
                                                            color:
                                                                Colors.black54,
                                                            width: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                child: Text(
                                                                  "بله",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.0,
                                                                      color: MyColors
                                                                          .button_bg_enabled),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Container(
                                          child: Image.asset(
                                            'assets/image_icon/delete_bill_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          pageIndex = 2;
                                        });
                                      },
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Container(
                                          child: Image.asset(
                                            'assets/image_icon/edit_bill_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "قبض آب شهریور",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      " ۲۰ مهر ماه 1402",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.asset(
                                  'assets/image_icon/water_bill_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "20,000 ریال",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.button_bg_enabled,
                                      fontSize: 12),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
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
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 40.0,
                                                      ),
                                                      Text(
                                                        "آیا از حذف قبض مورد نظر اطمینان دارید؟",
                                                        style: TextStyle(
                                                            fontSize: 12.0),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                child: Text(
                                                                  "خیر",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.0,
                                                                      color: Colors
                                                                          .red),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          VerticalDivider(
                                                            thickness: 10,
                                                            color:
                                                                Colors.black54,
                                                            width: 2,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                child: Text(
                                                                  "بله",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.0,
                                                                      color: MyColors
                                                                          .button_bg_enabled),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Container(
                                          child: Image.asset(
                                            'assets/image_icon/delete_bill_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          pageIndex = 2;
                                        });
                                      },
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Container(
                                          child: Image.asset(
                                            'assets/image_icon/edit_bill_icon.png',
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "قبض برق شهریور",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      " ۲۰ مهر ماه 1402",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.asset(
                                  'assets/image_icon/bargh_bill_icon.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ))
                        ],
                      ),
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
                      onPressed: () {},
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 11) {
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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شناسه قبض خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_water_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _waterBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                        !_formKey_water_bill1.currentState!
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
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شناسه قبض",
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
                    ),
                    Container(
                      child: Form(
                        key: _formKey_water_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _waterBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                        !_formKey_water_bill2.currentState!
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
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
                      onPressed: () {},
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 12) {
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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شناسه قبض خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_bargh_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _barghBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_bargh_bill1.currentState!
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
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شناسه قبض",
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
                    ),
                    Container(
                      child: Form(
                        key: _formKey_bargh_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _barghBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_bargh_bill2.currentState!
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
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
                      onPressed: () {},
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 13) {
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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره اشتراک خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_gaz_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _gazBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_gaz_bill1.currentState!
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
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره اشتراک",
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
                    ),
                    Container(
                      child: Form(
                        key: _formKey_gaz_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _gazBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_gaz_bill2.currentState!
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض گاز مهر ماه)",
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
                      onPressed: () {},
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 14) {
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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره تلفن ثابت خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_phone_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _phoneBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_phone_bill1.currentState!
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
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره ثابت",
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
                    ),
                    Container(
                      child: Form(
                        key: _formKey_phone_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _phoneBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                    !_formKey_phone_bill2.currentState!
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض تلفن مهر ماه)",
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
                      onPressed: () {},
                      child: Text('استعلام'),
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
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("ویرایش قبض")))),
                    Expanded(flex: 4, child: Container()),
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
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Text(
                    "شما می توانید جهت تمایز با سایر قبوض برای قبض خود یک عنوان دلخواه انتخاب نمایید",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ))),
          Expanded(
              flex: 14,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_edit_bill,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _editBillController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  int decimalValue = int.parse(value);
                                  if (decimalValue < 1000) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_page2_condition1 =
                                        !_formKey_edit_bill.currentState!
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
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Text('ثبت'),
                      ),
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
                children: [],
              ),
            ),
          )
        ],
      );
    }
  }
}
