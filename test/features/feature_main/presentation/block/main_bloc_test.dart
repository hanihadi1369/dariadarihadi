
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';
import 'package:atba_application/features/feature_main/domain/entities/get_profile_entity.dart';
import 'package:atba_application/features/feature_main/domain/use_cases/get_balance_usecase.dart';

import 'package:atba_application/features/feature_main/domain/use_cases/get_profile_usecase.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/balance_status.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/main_bloc.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/profile_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_bloc_test.mocks.dart';



@GenerateMocks([GetBalanceUseCase, GetProfileUseCase])
void main(){
  MockGetBalanceUseCase mockGetBalanceUseCase = MockGetBalanceUseCase();
  MockGetProfileUseCase mockGetProfileUseCase = MockGetProfileUseCase();



  group('getBalance and getProfile Event test', () {
    test('getBalance Success', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(GetBalanceEntity())));

      final bloc = MainBloc(mockGetBalanceUseCase,mockGetProfileUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        MainState(balanceStatus: BalanceLoading(), profileStatus: ProfileInit()),
        MainState(balanceStatus: BalanceCompleted(GetBalanceEntity()), profileStatus: ProfileInit()),
      ]));
    });
    test('getBalance Error', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = MainBloc(mockGetBalanceUseCase,mockGetProfileUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
            MainState(balanceStatus: BalanceLoading(), profileStatus: ProfileInit()),
            MainState(balanceStatus: BalanceError("error"), profileStatus: ProfileInit()),
      ]));
    });
    //************************************************************************************************************
    test('getProfile Success', () {
      when(mockGetProfileUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(GetProfileEntity())));

      final bloc = MainBloc(mockGetBalanceUseCase,mockGetProfileUseCase);
      bloc.add(GetProfileEvent());

      expectLater(bloc.stream,emitsInOrder([
        MainState(balanceStatus: BalanceInit(), profileStatus: ProfileLoading()),
        MainState(balanceStatus: BalanceInit(), profileStatus: ProfileCompleted(GetProfileEntity())),
      ]));
    });
    test('getProfile Error', () {
      when(mockGetProfileUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = MainBloc(mockGetBalanceUseCase,mockGetProfileUseCase);
      bloc.add(GetProfileEvent());

      expectLater(bloc.stream,emitsInOrder([
        MainState(balanceStatus: BalanceInit(), profileStatus: ProfileLoading()),
        MainState(balanceStatus: BalanceInit(), profileStatus: ProfileError("error")),
      ]));
    });
  });
}