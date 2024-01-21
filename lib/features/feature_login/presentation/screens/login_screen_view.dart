import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/login_page_index_status.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../core/params/verify_otp_param.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/fade_transition.dart';
import '../../../../core/utils/token_keeper.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../locator.dart';
import '../../../feature_main/presentation/screens/main_screen_view.dart';
import '../../data/data_source/remote/api_provider_login.dart';
import '../../data/repository/login_repositoryimpl.dart';
import '../../domain/entities/send_otp_code_entity.dart';
import '../../domain/entities/verify_otp_code_entity.dart';
import '../../domain/use_cases/send_otp_code_usecase.dart';
import '../../domain/use_cases/verify_otp_code_usecase.dart';
import '../bloc/login_bloc.dart';
import '../bloc/send_otp_status.dart';
import '../bloc/verify_otp_status.dart';

class LoginScreenView extends StatefulWidget {
  @override
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  int pageIndex = 1;

  final _formKey = GlobalKey<FormState>();

  bool _isButtonPhoneDisabled = true;
  bool _isButtonOTPDisabled = true;
  TextEditingController _phoneController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  late String otpPinValue;
  bool shouldShowOnCompletedMessage = false;

  int seccondsForOtpTimer = 120;
  bool _isSnackbarActive = false;


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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.sendOtpStatus is SendOtpCompleted &&
                state.pageLoginIndexStatus is PageLoginIndexStatus2) {
              SendOtpCompleted sendOtpCompleted =
                  state.sendOtpStatus as SendOtpCompleted;
              if (sendOtpCompleted.sendOtpCodeEntity.isSuccess == true) {
                shouldShowOnCompletedMessage = false;
                seccondsForOtpTimer = 120;
                state.sendOtpStatus = SendOtpInit();
              }
            }

            if (state.sendOtpStatus is SendOtpCompleted &&
                state.pageLoginIndexStatus is PageLoginIndexStatus1) {
              SendOtpCompleted sendOtpCompleted =
                  state.sendOtpStatus as SendOtpCompleted;
              if (sendOtpCompleted.sendOtpCodeEntity.isSuccess == true) {
                shouldShowOnCompletedMessage = false;
                seccondsForOtpTimer = 120;
              }
            }

            if (state.verifyOtpStatus is VerifyOtpCompleted) {
              VerifyOtpCompleted verifyOtpCompleted =
                  state.verifyOtpStatus as VerifyOtpCompleted;
              if (verifyOtpCompleted.verifyOtpCodeEntity.isSuccess == false) {
                _showSnackBar(verifyOtpCompleted
                    .verifyOtpCodeEntity.message
                    .toString());
              } else {
                TokenKeeper.saveAccessToken(verifyOtpCompleted
                        .verifyOtpCodeEntity.data!.tokens!.accesstoken!)
                    .then(
                  (value) => {
                    TokenKeeper.accesstoken = verifyOtpCompleted
                        .verifyOtpCodeEntity.data!.tokens!.accesstoken!,
                    TokenKeeper.saveRefreshToken(verifyOtpCompleted
                            .verifyOtpCodeEntity.data!.tokens!.refreshToken!)
                        .then(
                      (value) => {
                        TokenKeeper.refreshToken = verifyOtpCompleted
                            .verifyOtpCodeEntity.data!.tokens!.refreshToken!,
                        TokenKeeper.saveRefreshTokenExpirationDate(
                                verifyOtpCompleted.verifyOtpCodeEntity.data!
                                    .tokens!.refreshTokenExpirationDate!)
                            .then(
                          (value) => {
                            TokenKeeper.refreshTokenExpirationDate =
                                verifyOtpCompleted.verifyOtpCodeEntity.data!
                                    .tokens!.refreshTokenExpirationDate!,
                            TokenKeeper.savePhoneNumber(
                                    _phoneController.text.trim())
                                .then((value) => {
                                      TokenKeeper.phoneNumber =
                                          _phoneController.text.trim(),
                                      state.sendOtpStatus = SendOtpInit(),
                                      state.verifyOtpStatus = VerifyOtpInit(),
                                      state.pageLoginIndexStatus =PageLoginIndexStatus1(),
                                      pageIndex = 1,
                                      _isButtonPhoneDisabled = true,
                                      _isButtonOTPDisabled = true,
                                      shouldShowOnCompletedMessage = false,
                                      seccondsForOtpTimer = 120,
                                      _isSnackbarActive = false,
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (_) => locator<MainBloc>(),
                                              child: MainScreenView(),
                                            );
                                          },
                                        ),
                                      )
                                    }),
                          },
                        )
                      },
                    )
                  },
                );
              }
            }

            if (state.sendOtpStatus is SendOtpError) {
              SendOtpError error = state.sendOtpStatus as SendOtpError;
              _showSnackBar(error.message);
              state.sendOtpStatus = SendOtpInit();
            }

            if (state.sendOtpStatus is SendOtpCompleted) {
              SendOtpCompleted sendOtpCompleted =
                  state.sendOtpStatus as SendOtpCompleted;
              if (sendOtpCompleted.sendOtpCodeEntity.isSuccess == false) {
                _showSnackBar(sendOtpCompleted
                    .sendOtpCodeEntity.message
                    .toString());
                state.sendOtpStatus = SendOtpInit();
              }
            }

            if (state.verifyOtpStatus is VerifyOtpError) {
              VerifyOtpError error = state.verifyOtpStatus as VerifyOtpError;
              _showSnackBar(error.message);
              state.verifyOtpStatus = VerifyOtpInit();
              _isButtonOTPDisabled = true;
            }
          },
          builder: (context, state) {
            if (state.sendOtpStatus is SendOtpLoading ||
                state.verifyOtpStatus is VerifyOtpLoading) {
              return LoadingPage();
            }
            if (state.sendOtpStatus is SendOtpCompleted &&
                state.pageLoginIndexStatus is PageLoginIndexStatus1) {
              SendOtpCompleted sendOtpCompleted =
                  state.sendOtpStatus as SendOtpCompleted;
              if (sendOtpCompleted.sendOtpCodeEntity.isSuccess == true) {
                BlocProvider.of<LoginBloc>(context)
                    .add(LoginChangePageIndexEvent(2));
              }
            }
            if (state.pageLoginIndexStatus is PageLoginIndexStatus1) {
              state.sendOtpStatus = SendOtpInit();
              pageIndex = 1;
            }
            if (state.pageLoginIndexStatus is PageLoginIndexStatus2) {
              pageIndex = 2;
            }

            return preparePageIndex();
          },
        ),
      )),
    );

    // return Scaffold(
    //     body: SafeArea(
    //       child: (showLoading)?LoadingPage():preparePageIndex()
    //     ));
  }

  _showSnackBar(String message) {
    if (!_isSnackbarActive) {
      _isSnackbarActive = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
              duration: Duration(seconds: 4),
              content: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    message.trim(),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontFamily: "shabnam_bold"),
                  ))))
          .closed
          .then((value) {
        _isSnackbarActive = false;
      });
    }

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

  // _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(seconds: 4),
  //       content: Align(
  //           alignment: Alignment.centerRight,
  //           child: Text(
  //             message,
  //             style: TextStyle(fontFamily: "shabnam_bold"),
  //           ))));
  //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   //       duration: Duration(seconds: 4),
  //   //       content: Align(
  //   //           alignment: Alignment.centerRight,
  //   //           child: Text(
  //   //             message,
  //   //             style: TextStyle(fontFamily: "shabnam_bold"),
  //   //           ))));
  //   // });
  // }

  // _startTimer() {
  //   Future.delayed(const Duration(milliseconds: 1000), () {
  //     setState(() {
  //       otpTimerController.isCompleted = false;
  //     });
  //     otpTimerController.start();
  //   });
  // }

  preparePageIndex() {
    // index 1 > get phone number
    // index 2 > get otp

    if (pageIndex == 1) {
      return Container(
        padding: EdgeInsets.only(left: 36, right: 36),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 11,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(48),
                            child: Image.asset(
                                'assets/image_icon/moba_des_icon.png'),
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      "لطفاً شماره تلفن همراه خود را وارد نمایید.",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: _phoneController,
                                      maxLength: 11,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'مقدار وارد شده خالی است';
                                        } else if ((value
                                                    .trim()
                                                    .startsWith('0') !=
                                                true) ||
                                            value.trim().length != 11) {
                                          return 'شماره تلفن وارد شده معتبر نیست';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _isButtonPhoneDisabled = !_formKey
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
                                        prefixIcon: Icon(
                                          Icons.phone_android,
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
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _isButtonPhoneDisabled
                                        ? null
                                        : () {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(SendOtpEvent(
                                                    _phoneController.text
                                                        .trim()));
                                          },
                                    child: Text('دریافت کد'),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 4, child: Container())
            ],
          ),
        ),
      );
    }

    if (pageIndex == 2) {
      return Container(
        padding: EdgeInsets.only(left: 36, right: 36),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 11,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(32),
                            child: Image.asset(
                                'assets/image_icon/moba_des_icon.png'),
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      "کد تایید به شماره شما ارسال شد.لطفا آن را وارد نمایید.",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      "شماره همراه : ${_phoneController.text.toString().trim()}",
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: MyColors.text_field_bg,
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: OTPTextField(
                                            controller: otpController,
                                            length: 5,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fieldWidth: 45,
                                            fieldStyle: FieldStyle.underline,
                                            otpFieldStyle: OtpFieldStyle(
                                                disabledBorderColor:
                                                    MyColors.otp_underline,
                                                enabledBorderColor:
                                                    MyColors.otp_underline),
                                            outlineBorderRadius: 15,
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontFamily: "IranSans"),
                                            onChanged: (pin) {
                                              print("Changed: " + pin);
                                            },
                                            onCompleted: (pin) {
                                              print("Completed: " + pin);
                                              setState(() {
                                                otpPinValue = pin.trim();
                                                _isButtonOTPDisabled = false;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(LoginChangePageIndexEvent(
                                                    1));
                                          },
                                          child: Text(
                                            "ویرایش شماره",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: (shouldShowOnCompletedMessage)
                                              ? InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<LoginBloc>(
                                                            context)
                                                        .add(SendOtpEvent(
                                                            _phoneController
                                                                .text
                                                                .trim()));
                                                  },
                                                  child: Text(
                                                    "ارسال مجدد کد تایید",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent),
                                                  ))
                                              : Countdown(
                                                  seconds: seccondsForOtpTimer,
                                                  build: (BuildContext context,
                                                      double time) {
                                                    seccondsForOtpTimer =
                                                        time.toInt();
                                                    return Text(formatMMSS(
                                                        time.toInt()));
                                                  },
                                                  interval:
                                                      Duration(seconds: 1),
                                                  onFinished: () {
                                                    setState(() {
                                                      seccondsForOtpTimer = 120;
                                                      shouldShowOnCompletedMessage =
                                                          true;
                                                    });
                                                  },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _isButtonOTPDisabled
                                        ? null
                                        : () {
                                            VerifyOtpParam verifyOtpParam =
                                                VerifyOtpParam(
                                                    phoneNumber:
                                                        _phoneController.text
                                                            .trim(),
                                                    otpCode:
                                                        int.parse(otpPinValue));

                                            BlocProvider.of<LoginBloc>(context)
                                                .add(VerifyOtpEvent(
                                                    verifyOtpParam));
                                          },
                                    child: Text('تایید کد'),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 4, child: Container())
            ],
          ),
        ),
      );
    }
  }

  String formatMMSS(int seconds) {
    if (seconds != null && seconds != 0) {
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      return "$minutesStr : $secondsStr";
    } else {
      return "";
    }
  }
}
