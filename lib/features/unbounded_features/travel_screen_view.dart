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
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/utils/colors.dart';



class TravelScreenView extends StatefulWidget {
  @override
  _TravelScreenViewState createState() => _TravelScreenViewState();
}

class _TravelScreenViewState extends State<TravelScreenView> {
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
    // index 1 > main travel page



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
                                child: Text("سفر")))),
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
          Expanded(flex: 16, child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(children: [
            SizedBox(height: 48,),
            InkWell(
              onTap: () async{
                try {
                  await launchUrlString("https://safar.com/");
                } catch (e) {}
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end
                ,
                children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("سایت سفر دات کام",style: TextStyle(color: Colors.black54),),
                  Text("مشاهده و خرید انواع بلیط پرواز،قطار و ...",style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right ,textDirection: TextDirection.rtl,),
                ],),

                  SizedBox(width: 15,),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/image_icon/bime_com_logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
              ],),
            )

          ],),
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
                      onPressed:
                      () async {
                        try {
                          await launchUrlString("https://safar.com/");
                        } catch (e) {}
                      },
                      child: Text('رفتن به سایت سفر دات کام'),
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
