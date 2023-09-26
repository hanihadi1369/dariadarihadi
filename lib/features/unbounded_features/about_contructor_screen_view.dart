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



class AboutConstructorScreenView extends StatefulWidget {
  @override
  _AboutConstructorScreenViewState createState() => _AboutConstructorScreenViewState();
}

class _AboutConstructorScreenViewState extends State<AboutConstructorScreenView> {
  int pageIndex = 1;




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
                                child: Text("درباره سازنده")))),
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

          Expanded(flex: 17, child: Container(



            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                      height: 50,
                      width: 100,

                      child: Image.asset('assets/image_icon/moba_main_icon.png')),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Text("اپلیکیشن موبا جهت ارائه خدمات بانکی و ارزش افزوده از قبیل (کارت به کارت , شارژ , بسته اینترنت , پرداخت قبوض , بلیط مترو , خرید انواع بیمه نامه ها و بلیط سفر و هتل ) برای جامعه اتباع در نظر گرفته شده است"
                    ,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,


                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "شرکت تجارت الکترونیک آرین تاک",

                        style: TextStyle(color: Colors.lightGreen,fontFamily: "shabnam_bold"),
                        children: <TextSpan>[
                          TextSpan(text: ' به منظور استفاده از ظرفیت‌های موجود و با تکیه بر سرمایه انسانی هوشمند، پویا و متخصص، با انجام فعالیت‌های مبتنی بر فناوری اطلاعات سعی در ایجاد بسترهای نرم افزاری و بهره‌گیری از فناوری‌های نوین دارد. هدف این شرکت دست‌یابی به بیشترین سودآوری و بازده با حداقل هزینه و نیروی اجرایی برای مشتریان خود است.', style: TextStyle(color: Colors.black87,fontFamily: "shabnam_bold")),
                        ],

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text("فعالیت‌های اصلی آرین تاک"
                        ,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.blueAccent),


                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Text("فعالیت شرکت آرین تاک در دو حوزه آی تی IT سخت افزار و نرم افزار و بازرگانی (واردات و صادرات) تقسیم می‌شود و در هر قسمت خدمات فراوانی را ارائه می‌دهد."
                      ,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,


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
                      onPressed:(){


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

  }
}
