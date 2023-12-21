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

import '../../core/utils/colors.dart';

class TicketScreenView extends StatefulWidget {
  @override
  _TicketScreenViewState createState() => _TicketScreenViewState();
}

class _TicketScreenViewState extends State<TicketScreenView> {
  int pageIndex = 0;

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

  //***************************************************************************

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
    // index 0 > comming soon
    // index 1 > main ticket page
    // index 2 > main buy-ticket page -- 21 buy-ticket sub1 --22 buy-ticket sub2

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
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/image_icon/back_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("خرید بلیط مترو و اتوبوس")))),
                    Expanded(flex: 4, child: Container()),
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
              flex: 16,
              child: Container(
                child: Column(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/image_icon/ticket_grey_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "کاربر گرامی در حال حاضر شما بلیط فعالی ندارید",
                                style: TextStyle(fontSize: 14),
                              )),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "لطفا برای خرید بلیط بر روی دکمه خرید بلیط بزنید",
                                style: TextStyle(fontSize: 11),
                              )),
                        )),
                    Expanded(flex: 5, child: Container())
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
                          pageIndex = 2;
                        });
                      },
                      child: Text('خرید بلیط'),
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
      return Container(
        color: MyColors.text_field_bg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  color: Colors.white,
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
                      Expanded(flex: 4, child: Container()),
                      Expanded(
                          flex: 6,
                          child: Center(
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("خرید بلیط مترو و اتوبوس")))),
                      Expanded(flex: 4, child: Container()),
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
                flex: 18,
                child: Container(
                  padding: EdgeInsets.only(left: 28, right: 28, top: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 13, bottom: 13, left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Text(
                            "مهلت استفاده از بلیط تک سفره محدود است و در صورت عدم استفاده بلیط منقضی می گردد",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTicket = 1;
                            });
                            showTicketDialog(1);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "20.000 ریال",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  MyColors.button_bg_enabled),
                                        )),
                                    Spacer(),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "تک سفره مشترک مترو و بی آر تی",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        'assets/image_icon/metro_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                  ),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "انتخاب و خرید",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.orange),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTicket = 2;
                            });
                            showTicketDialog(2);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "20.000 ریال",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  MyColors.button_bg_enabled),
                                        )),
                                    Spacer(),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "تک سفره کرج",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        'assets/image_icon/train_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                  ),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "انتخاب و خرید",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.orange),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTicket = 3;
                            });
                            showTicketDialog(3);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "20.000 ریال",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  MyColors.button_bg_enabled),
                                        )),
                                    Spacer(),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "تک سفره هشتگرد",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        'assets/image_icon/train_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                  ),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "انتخاب و خرید",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.orange),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTicket = 4;
                            });
                            showTicketDialog(4);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "20.000 ریال",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color:
                                                  MyColors.button_bg_enabled),
                                        )),
                                    Spacer(),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "فرودگاه امام خمینی",
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        'assets/image_icon/airplane_icon.png',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                  ),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "انتخاب و خرید",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.orange),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
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
                                child: Text("پرداخت اینترنتی")))),
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
                      Center(
                        child: SizedBox(
                            height: 23,
                            width: 23,
                            child: Image.asset(
                              'assets/image_icon/airplane_icon.png',
                              fit: BoxFit.scaleDown,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "خرید بلیط تک سفره",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              totalPrice.toString().trim().seRagham() + " ریال",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: MyColors.button_bg_enabled,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "مبلغ",
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
                            "پرداخت از",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                      onPressed: () {
                        setState(() {
                          pageIndex = 22;
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 21;
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
                                child: Text("کیف پول")))),
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
                      Center(
                        child: SizedBox(
                            height: 23,
                            width: 23,
                            child: Image.asset(
                              'assets/image_icon/airplane_icon.png',
                              fit: BoxFit.scaleDown,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "خرید بلیط تک سفره",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              totalPrice.toString().trim().seRagham() + " ریال",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: MyColors.button_bg_enabled,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              "مبلغ",
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
  }
}
