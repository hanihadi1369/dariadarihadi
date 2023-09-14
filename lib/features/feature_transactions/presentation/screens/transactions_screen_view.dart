//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:receive_intent/receive_intent.dart';
//
// class TransactionsScreenView extends StatefulWidget {
//   @override
//   _TransactionsScreenViewState createState() => _TransactionsScreenViewState();
// }
//
// class _TransactionsScreenViewState extends State<TransactionsScreenView> {
//   int pageIndex = 1;
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<WalletBloc>(context).add(GetBalanceEvent());
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//
//
//         return Future.value(false);
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SafeArea(
//           child: BlocConsumer<WalletBloc, WalletState>(
//             listener: (context, state) async {
//               if (state.balanceStatus is BalanceError) {
//                 BalanceError error = state.balanceStatus as BalanceError;
//                 _showSnackBar(error.message);
//                 state.balanceStatus = BalanceInit();
//               }
//               if (state.chargeWalletStatus is ChargeWalletError) {
//                 ChargeWalletError error =
//                     state.chargeWalletStatus as ChargeWalletError;
//                 _showSnackBar(error.message);
//                 state.chargeWalletStatus = ChargeWalletInit();
//               }
//               if (state.transferKifBKifStatus is TransferKifBKifError) {
//                 TransferKifBKifError error =
//                     state.transferKifBKifStatus as TransferKifBKifError;
//                 _showSnackBar(error.message);
//                 state.transferKifBKifStatus = TransferKifBKifInit();
//               }
//
//               if (state.chargeWalletStatus is ChargeWalletCompleted) {
//                 ChargeWalletCompleted chargeWalletCompleted =
//                     state.chargeWalletStatus as ChargeWalletCompleted;
//                 if (chargeWalletCompleted.chargeWalletEntity.isFailed ==
//                     false) {
//                   try {
//                     await launchUrlString(
//                         chargeWalletCompleted.chargeWalletEntity.value!.url!);
//                   } catch (e) {}
//                 }
//               }
//             },
//             builder: (context, state) {
//               if (state.chargeWalletStatus is ChargeWalletLoading ||
//                   state.balanceStatus is BalanceLoading ||
//                   state.transferKifBKifStatus is TransferKifBKifLoading) {
//                 return LoadingPage();
//               }
//
//               if (state.balanceStatus is BalanceCompleted) {
//                 BalanceCompleted balanceCompleted =
//                     state.balanceStatus as BalanceCompleted;
//                 if (balanceCompleted.getBalanceEntity.isFailed == false) {
//                   balance = balanceCompleted.getBalanceEntity.value![0].balance!
//                       .toString();
//                 }
//               }
//
//               if (state.transferKifBKifStatus is TransferKifBKifCompleted) {
//                 TransferKifBKifCompleted transferKifBKifCompleted =
//                     state.transferKifBKifStatus as TransferKifBKifCompleted;
//                 if (transferKifBKifCompleted.transferKifBKifEntity.isFailed ==
//                     false) {
//                   transferKifBKifRecepit = transferKifBKifCompleted
//                       .transferKifBKifEntity.value!.receiptID!
//                       .toString();
//                   pageIndex = 51;
//                   state.transferKifBKifStatus = TransferKifBKifInit();
//                 }
//               }
//
//               return Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.white,
//                 child: preparePageIndex(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _intenetReciever() {
//     try {
//       ReceiveIntent.receivedIntentStream.listen((event) async {
//         if (event?.extra != null) {
//           int i = 5;
//           i++;
//         }
//       });
//     } on PlatformException {}
//   }
//
//   _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         duration: Duration(seconds: 4),
//         content: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               message,
//               style: TextStyle(fontFamily: "shabnam_bold"),
//             ))));
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //       duration: Duration(seconds: 4),
//     //       content: Align(
//     //           alignment: Alignment.centerRight,
//     //           child: Text(
//     //             message,
//     //             style: TextStyle(fontFamily: "shabnam_bold"),
//     //           ))));
//     // });
//   }
//
//
//
//   preparePageIndex() {
//     // index 1 > Cost main page
//     // index 11 > انتقال وجه
//     // index 12 > کیف به کیف
//     // index 13 > شارژ و قبض
//     // index 14 > خانه و کاشانه
//     // index 2 > Income main page
//     // index 21 > انتقال وجه
//     // index 22 > شارژ حساب
//
//
//     if (pageIndex == 1) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//               flex: 3,
//               child: Container(
//                 padding: EdgeInsets.only(left: 24, right: 24),
//                 color: Colors.transparent,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () {
//                           _textEdit_controler_kifbkif_1.clear();
//                           _textEdit_controler_kifbkif_2.clear();
//                           _isButtonNextDisabled_page5_condition1 = true;
//                           _isButtonNextDisabled_page5_condition2 = true;
//                           setState(() {
//                             pageIndex = 1;
//                           });
//                         },
//                         child: Image.asset(
//                           'assets/image_icon/back_icon.png',
//                           fit: BoxFit.scaleDown,
//                         ),
//                       ),
//                     ),
//                     Expanded(flex: 5, child: Container()),
//                     Expanded(
//                         flex: 4,
//                         child: Center(
//                             child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: Text("کیف به کیف")))),
//                     Expanded(flex: 5, child: Container()),
//                     Expanded(
//                       flex: 1,
//                       child: Image.asset(
//                         'assets/image_icon/hint_green_icon.png',
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//           Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 32, right: 32),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: MyColors.text_field_bg,
//                       border: Border.all(
//                         color: MyColors.button_bg_enabled,
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "موجودی کیف پول",
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         (balance == "***")
//                             ? "نامشخص"
//                             : "${balance} ریال".toPersianDigit(),
//                         textDirection: TextDirection.rtl,
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//               flex: 8,
//               child: Container(
//                 padding:
//                 EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
//                 color: Colors.transparent,
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Container(
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Align(
//                                       alignment: Alignment.topRight,
//                                       child: Text(
//                                         "لطفا اطلاعات زیر را وارد کنید",
//                                         style: TextStyle(
//                                             color: Colors.black, fontSize: 13),
//                                       )),
//                                 ),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                       child: Form(
//                                         key: _formKey_kifbkif_1,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                           children: [
//                                             Directionality(
//                                               textDirection: TextDirection.rtl,
//                                               child: TextFormField(
//                                                 maxLength: 16,
//                                                 controller:
//                                                 _textEdit_controler_kifbkif_1,
//                                                 validator: (value) {
//                                                   if (value == null ||
//                                                       value.isEmpty) {
//                                                     return 'مقدار وارد شده خالی است';
//                                                   }
//                                                   return null;
//                                                 },
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _isButtonNextDisabled_page5_condition1 =
//                                                     !_formKey_kifbkif_1
//                                                         .currentState!
//                                                         .validate();
//                                                   });
//                                                 },
//                                                 keyboardType: TextInputType.number,
//                                                 decoration: InputDecoration(
//                                                   enabledBorder:
//                                                   UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.grey),
//                                                   ),
//                                                   focusedBorder:
//                                                   UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.grey),
//                                                   ),
//                                                   filled: true,
//                                                   fillColor: Color(0x32E1E3E0),
//                                                   hintText: "شماره تلفن همراه",
//                                                   hintStyle:
//                                                   TextStyle(fontSize: 12),
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.auto,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                                 Expanded(
//                                   child: Align(
//                                       alignment: Alignment.topRight,
//                                       child: Text(
//                                         "مبلغ مورد نظر خود را وارد نمایید",
//                                         style: TextStyle(
//                                             color: Colors.black, fontSize: 13),
//                                       )),
//                                 ),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                       child: Form(
//                                         key: _formKey_kifbkif_2,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                           children: [
//                                             Directionality(
//                                               textDirection: TextDirection.rtl,
//                                               child: TextFormField(
//                                                 maxLength: 8,
//                                                 controller:
//                                                 _textEdit_controler_kifbkif_2,
//                                                 validator: (value) {
//                                                   if (value == null ||
//                                                       value.isEmpty) {
//                                                     return 'مقدار وارد شده خالی است';
//                                                   }
//                                                   int decimalValue =
//                                                   int.parse(value);
//                                                   if (decimalValue < 1000) {
//                                                     return 'مقدار وارد شده معتبر نیست';
//                                                   }
//                                                   return null;
//                                                 },
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _isButtonNextDisabled_page5_condition2 =
//                                                     !_formKey_kifbkif_2
//                                                         .currentState!
//                                                         .validate();
//                                                   });
//                                                 },
//                                                 keyboardType: TextInputType.number,
//                                                 decoration: InputDecoration(
//                                                   enabledBorder:
//                                                   UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.grey),
//                                                   ),
//                                                   focusedBorder:
//                                                   UnderlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.grey),
//                                                   ),
//                                                   suffixText: "ریال",
//                                                   suffixStyle:
//                                                   TextStyle(fontSize: 12),
//                                                   filled: true,
//                                                   hintText: "مانند 200.000 ریال",
//                                                   hintStyle: TextStyle(
//                                                     fontSize: 12,
//                                                   ),
//                                                   fillColor: Color(0x32E1E3E0),
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.auto,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )),
//                                 Expanded(child: Container()),
//                               ],
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//           Expanded(flex: 4, child: Container()),
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: (_isButtonNextDisabled_page5_condition1 ==
//                           true ||
//                           _isButtonNextDisabled_page5_condition2 == true)
//                           ? null
//                           : () {
//                         //should show bottom sheet dialog
//                         showMaterialModalBottomSheet(
//                           context: context,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(15),
//                                   topRight: Radius.circular(15))),
//                           builder: (BuildContext _context) => Container(
//                             padding: EdgeInsets.only(left: 32, right: 32),
//                             height: MediaQuery.of(context).size.height /
//                                 (2.5),
//                             child: Column(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.stretch,
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 32,
//                                       right: 32,
//                                       top: 16,
//                                       bottom: 16),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Text("انتقال وجه کیف به کیف"),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 32,
//                                       right: 32,
//                                       top: 16,
//                                       bottom: 16),
//                                   child: Row(
//                                     children: [
//                                       Text(_textEdit_controler_kifbkif_1
//                                           .text
//                                           .toString()),
//                                       Spacer(),
//                                       Text(
//                                         "شماره تلفن همراه",
//                                         style:
//                                         TextStyle(color: Colors.grey),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 32,
//                                       right: 32,
//                                       top: 0,
//                                       bottom: 16),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         _textEdit_controler_kifbkif_2.text
//                                             .trim()
//                                             .seRagham() +
//                                             " ریال",
//                                         textDirection: TextDirection.rtl,
//                                         style: TextStyle(fontSize: 17),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "مبلغ واریزی",
//                                         style:
//                                         TextStyle(color: Colors.grey),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 DottedLine(
//                                   direction: Axis.horizontal,
//                                   lineLength: double.infinity,
//                                   lineThickness: 1.0,
//                                   dashLength: 4.0,
//                                   dashColor: MyColors.otp_underline,
//                                   dashRadius: 0.0,
//                                   dashGapLength: 4.0,
//                                   dashGapColor: Colors.transparent,
//                                   dashGapRadius: 0.0,
//                                 ),
//                                 Spacer(),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                         EdgeInsets.only(right: 10),
//                                         child: ElevatedButton(
//                                             style: ButtonStyle(
//                                               backgroundColor:
//                                               MaterialStateProperty
//                                                   .resolveWith<Color>(
//                                                     (Set<MaterialState>
//                                                 states) {
//                                                   return Colors.white;
//                                                 },
//                                               ),
//                                               padding:
//                                               MaterialStateProperty.all<
//                                                   EdgeInsetsGeometry>(
//                                                 EdgeInsets.symmetric(
//                                                     horizontal: 16,
//                                                     vertical: 8),
//                                               ),
//                                               shape: MaterialStateProperty
//                                                   .all<
//                                                   RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                                   borderRadius:
//                                                   BorderRadius
//                                                       .circular(10.0),
//                                                   side: BorderSide(
//                                                       color: MyColors
//                                                           .otp_underline),
//                                                 ),
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                               FocusScope.of(context)
//                                                   .unfocus();
//                                             },
//                                             child: Text(
//                                               "انصراف",
//                                               style: TextStyle(
//                                                   color: MyColors
//                                                       .otp_underline),
//                                             )),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                         EdgeInsets.only(left: 10),
//                                         child: ElevatedButton(
//                                             style: ButtonStyle(
//                                               backgroundColor:
//                                               MaterialStateProperty
//                                                   .resolveWith<Color>(
//                                                     (Set<MaterialState>
//                                                 states) {
//                                                   return MyColors
//                                                       .otp_underline;
//                                                 },
//                                               ),
//                                               padding:
//                                               MaterialStateProperty.all<
//                                                   EdgeInsetsGeometry>(
//                                                 EdgeInsets.symmetric(
//                                                     horizontal: 16,
//                                                     vertical: 8),
//                                               ),
//                                               shape: MaterialStateProperty
//                                                   .all<
//                                                   RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                                   borderRadius:
//                                                   BorderRadius
//                                                       .circular(10.0),
//                                                   side: BorderSide(
//                                                       color: MyColors
//                                                           .otp_underline),
//                                                 ),
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                               TransferKifBKifParam
//                                               transferKifBKifParam =
//                                               TransferKifBKifParam(
//                                                   amount: int.parse(
//                                                       _textEdit_controler_kifbkif_2
//                                                           .text
//                                                           .trim()),
//                                                   mobileNumber:
//                                                   _textEdit_controler_kifbkif_1
//                                                       .text
//                                                       .trim());
//                                               BlocProvider.of<WalletBloc>(
//                                                   context)
//                                                   .add(TransferKifBKifEvent(
//                                                   transferKifBKifParam));
//                                             },
//                                             child: Text(
//                                               "تایید",
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             )),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text('تایید'),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       );
//     }
//
//   }
// }
