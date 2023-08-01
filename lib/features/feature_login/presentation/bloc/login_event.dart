part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}



class SendOtpEvent extends LoginEvent{
  final String phoneNumber;
  SendOtpEvent(this.phoneNumber);
}


class VerifyOtpEvent extends LoginEvent{
  final VerifyOtpParam verifyOtpParam;
  VerifyOtpEvent(this.verifyOtpParam);
}


class LoginChangePageIndexEvent extends LoginEvent{
  final int pageIndex;
  LoginChangePageIndexEvent(this.pageIndex);
}
