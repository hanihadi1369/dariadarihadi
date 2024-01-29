import 'package:atba_application/core/utils/token_keeper.dart';
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


import 'dart:convert';
import 'package:pointycastle/export.dart' as pointy;
import 'dart:typed_data';

import 'package:convert/convert.dart';





class BimeScreenView extends StatefulWidget {
  @override
  _BimeScreenViewState createState() => _BimeScreenViewState();
}

class _BimeScreenViewState extends State<BimeScreenView> {
  int pageIndex = 1;
  String defaultPhoneNumberFromSharedPref = "";


  @override
  void initState() {
    super.initState();
    TokenKeeper.getPhoneNumber()
        .then((value) => defaultPhoneNumberFromSharedPref = value);
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





  String encrypt(String plaintext, String publicKey) {







    var modulusBytes = base64.decode(publicKey);
    var modulus = BigInt.parse(hex.encode(modulusBytes), radix: 16);
    // var exponent = BigInt.from(65537);
    var exponent = BigInt.parse(hex.encode(base64.decode('AQAB')), radix: 16);
    var engine = pointy.PKCS1Encoding(pointy.RSAEngine())
      ..init(
        true,
        pointy.PublicKeyParameter<pointy.RSAPublicKey>(pointy.RSAPublicKey(modulus, exponent)),
      );

    Uint8List output = engine.process(utf8.encode(plaintext) as Uint8List);


    String base64EncodedText = base64Encode(output);
    return base64EncodedText;




    // var pubKey = RSAPublicKey(modulus, exponent);
    // var cipher = PKCS1Encoding(RSAEngine());
    // cipher.init(true, PublicKeyParameter<RSAPublicKey>(pubKey));
    // Uint8List output = cipher.process(utf8.encode(text));
    // var base64EncodedText = base64Encode(output);
    // return base64EncodedText;
    //
    // return  engine.process(utf8.encode(plaintext) as Uint8List);




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
                                child: Text("خدمات بیمه")))),
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
          Expanded(flex: 16, child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(children: [
            SizedBox(height: 48,),
            InkWell(
              onTap: () async{
                try {




                  Map<String, dynamic> jsonObject = {
                    "UserName": "${defaultPhoneNumberFromSharedPref}",
                    "IssuedAt": "${DateTime.now().millisecondsSinceEpoch ~/ 1000}"

                  };
                  String jsonString = json.encode(jsonObject);



                  String result= encrypt(jsonString,"vQULripV697WSQssjXmFhuhM76fXPzvpnDXQhXG0YFUdw1v9aEfGdmtIoG891elnf7aEjb3vmpmM7rLqyulNum+oT5TkhBgj1gmKhWUfGHj9synQIi3yyKhVLV0SJc77tJtBE0MzIsevGXsB7DMXrkMqTuDeZZpUd6YLZi9GcDcXTfWvL3ih+4JFJIjP0l2r7Dvs2dGmTSgyYru7M1azOTqVXxmphVa1Gj/yB3UAIdbyJssmLFeEoZo55zrMb8vB6kwHco3ZYyLDsUuP5NNrIgseZjcWIFGE7VAvxu0MRWIVMhWsE01NWiWN9VWKD0ohINwckaNm9X+6W9km22bg5Q==");












                  await launchUrlString("https://atba.bimeh.com/?auth=${result}",
                      mode: LaunchMode.externalApplication);
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
                  Text("سایت بیمه دات کام",style: TextStyle(color: Colors.black54),),
                  Text("مشاهده و خرید انواع بیمه نامه",style: TextStyle(fontWeight: FontWeight.bold),textAlign:TextAlign.right ,textDirection: TextDirection.rtl,),
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


                          Map<String, dynamic> jsonObject = {
                            "UserName": "${defaultPhoneNumberFromSharedPref}",
                            "IssuedAt": "${DateTime.now().millisecondsSinceEpoch ~/ 1000}"

                          };
                          String jsonString = json.encode(jsonObject);



                          String result= encrypt(jsonString,"vQULripV697WSQssjXmFhuhM76fXPzvpnDXQhXG0YFUdw1v9aEfGdmtIoG891elnf7aEjb3vmpmM7rLqyulNum+oT5TkhBgj1gmKhWUfGHj9synQIi3yyKhVLV0SJc77tJtBE0MzIsevGXsB7DMXrkMqTuDeZZpUd6YLZi9GcDcXTfWvL3ih+4JFJIjP0l2r7Dvs2dGmTSgyYru7M1azOTqVXxmphVa1Gj/yB3UAIdbyJssmLFeEoZo55zrMb8vB6kwHco3ZYyLDsUuP5NNrIgseZjcWIFGE7VAvxu0MRWIVMhWsE01NWiWN9VWKD0ohINwckaNm9X+6W9km22bg5Q==");












                          await launchUrlString("https://atba.bimeh.com/?auth=${result}",
                              mode: LaunchMode.externalApplication);
                        } catch (e) {}
                      },
                      child: Text('رفتن به سایت بیمه دات کام'),
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
