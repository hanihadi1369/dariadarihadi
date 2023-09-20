import 'dart:async';

import 'package:atba_application/features/feature_login/presentation/bloc/login_page_index_status.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/send_otp_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/params/verify_otp_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/send_otp_code_usecase.dart';
import '../../domain/use_cases/verify_otp_code_usecase.dart';
import 'verify_otp_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpCodeUseCase sendOtpCodeUseCase;
  final VerifyOtpCodeUseCase verifyOtpCodeUseCase;

  LoginBloc(this.sendOtpCodeUseCase, this.verifyOtpCodeUseCase) : super(LoginState(sendOtpStatus: SendOtpInit(), verifyOtpStatus: VerifyOtpInit() , pageLoginIndexStatus: PageLoginIndexStatus1())) {

    on<SendOtpEvent>((event, emit) async {

      emit(state.copyWith(newSendOtpStatus: SendOtpLoading()));

      DataState dataState = await sendOtpCodeUseCase(event.phoneNumber);

      if(dataState is DataSuccess){
        emit(state.copyWith(newSendOtpStatus: SendOtpCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newSendOtpStatus: SendOtpError(dataState.error!)));
      }
    });



    on<VerifyOtpEvent>((event, emit) async {


      emit(state.copyWith(newVerifyOtpStatus: VerifyOtpLoading()));

      DataState dataState = await verifyOtpCodeUseCase(event.verifyOtpParam);


      if(dataState is DataSuccess){
        emit(state.copyWith(newVerifyOtpStatus: VerifyOtpCompleted(dataState.data)));
      }


      if(dataState is DataFailed){
        emit(state.copyWith(newVerifyOtpStatus: VerifyOtpError(dataState.error!)));
      }

    });






    on<LoginChangePageIndexEvent>((event, emit) async {

      if(event.pageIndex ==1){
        emit(state.copyWith(newPageLoginIndexStatus: PageLoginIndexStatus1()));
      }else if(event.pageIndex == 2) {
        emit(state.copyWith(newPageLoginIndexStatus: PageLoginIndexStatus2()));
      }

    });



  }
}
