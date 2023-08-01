part of 'login_bloc.dart';

class LoginState{
  SendOtpStatus sendOtpStatus;
  VerifyOtpStatus verifyOtpStatus;
  PageLoginIndexStatus pageLoginIndexStatus;


  LoginState({required this.sendOtpStatus,required this.verifyOtpStatus,required this.pageLoginIndexStatus});

  LoginState copyWith({SendOtpStatus? newSendOtpStatus,VerifyOtpStatus? newVerifyOtpStatus , PageLoginIndexStatus? newPageLoginIndexStatus}){

    return LoginState(
        sendOtpStatus: newSendOtpStatus ?? this.sendOtpStatus,
        verifyOtpStatus: newVerifyOtpStatus?? this.verifyOtpStatus,
        pageLoginIndexStatus: newPageLoginIndexStatus?? this.pageLoginIndexStatus
    );
  }


}