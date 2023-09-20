

import 'package:atba_application/core/params/verify_otp_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_login/domain/entities/send_otp_code_entity.dart';
import 'package:atba_application/features/feature_login/domain/entities/verify_otp_code_entity.dart';
import 'package:atba_application/features/feature_login/domain/use_cases/send_otp_code_usecase.dart';
import 'package:atba_application/features/feature_login/domain/use_cases/verify_otp_code_usecase.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/login_page_index_status.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/send_otp_status.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/verify_otp_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([SendOtpCodeUseCase, VerifyOtpCodeUseCase])
void main (){


  MockSendOtpCodeUseCase mockSendOtpCodeUseCase = MockSendOtpCodeUseCase();
  MockVerifyOtpCodeUseCase mockVerifyOtpCodeUseCase = MockVerifyOtpCodeUseCase();



  group('all  Events test', () {
    test('SendOtpCode Success', () {
      when(mockSendOtpCodeUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(SendOtpCodeEntity())));

      final bloc = LoginBloc(mockSendOtpCodeUseCase,mockVerifyOtpCodeUseCase);
      bloc.add(SendOtpEvent("123456"));

      expectLater(bloc.stream,emitsInOrder([
        LoginState(
         sendOtpStatus: SendOtpLoading(),
         verifyOtpStatus: VerifyOtpInit() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
        LoginState(
            sendOtpStatus: SendOtpCompleted(SendOtpCodeEntity()),
            verifyOtpStatus: VerifyOtpInit() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
      ]));
    });
    test('SendOtpCode Error', () {
      when(mockSendOtpCodeUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = LoginBloc(mockSendOtpCodeUseCase,mockVerifyOtpCodeUseCase);
      bloc.add(SendOtpEvent("123456"));

      expectLater(bloc.stream,emitsInOrder([

        LoginState(
            sendOtpStatus: SendOtpLoading(),
            verifyOtpStatus: VerifyOtpInit() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
        LoginState(
            sendOtpStatus: SendOtpError("error"),
            verifyOtpStatus: VerifyOtpInit() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),


      ]));
    });
    //************************************************************************************************************
    test('VerifyOtpCode Success', () {
      when(mockVerifyOtpCodeUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(VerifyOtpCodeEntity())));

      final bloc = LoginBloc(mockSendOtpCodeUseCase,mockVerifyOtpCodeUseCase);
      VerifyOtpParam verifyOtpParam = VerifyOtpParam(phoneNumber: "123", otpCode: 13212);
      bloc.add(VerifyOtpEvent(verifyOtpParam));

      expectLater(bloc.stream,emitsInOrder([
        LoginState(
            sendOtpStatus: SendOtpInit(),
            verifyOtpStatus: VerifyOtpLoading() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
        LoginState(
            sendOtpStatus: SendOtpInit(),
            verifyOtpStatus: VerifyOtpCompleted(VerifyOtpCodeEntity()) ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
      ]));
    });
    test('VerifyOtpCode Error', () {
      when(mockVerifyOtpCodeUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = LoginBloc(mockSendOtpCodeUseCase,mockVerifyOtpCodeUseCase);
      VerifyOtpParam verifyOtpParam = VerifyOtpParam(phoneNumber: "123", otpCode: 13212);
      bloc.add(VerifyOtpEvent(verifyOtpParam));

      expectLater(bloc.stream,emitsInOrder([

        LoginState(
            sendOtpStatus: SendOtpInit(),
            verifyOtpStatus: VerifyOtpLoading() ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),
        LoginState(
            sendOtpStatus: SendOtpInit(),
            verifyOtpStatus: VerifyOtpError("error") ,
            pageLoginIndexStatus: PageLoginIndexStatus1()
        ),


      ]));
    });
  });

}