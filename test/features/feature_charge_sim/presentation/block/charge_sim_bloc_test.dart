



import 'package:atba_application/core/params/charge_sim_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_charge_sim/domain/entities/charge_sim_entity.dart';
import 'package:atba_application/features/feature_charge_sim/domain/entities/get_balance_entity_csim.dart';
import 'package:atba_application/features/feature_charge_sim/domain/use_cases/charge_sim_usecase.dart';
import 'package:atba_application/features/feature_charge_sim/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_charge_sim/presentation/block/balance_status_csim.dart';
import 'package:atba_application/features/feature_charge_sim/presentation/block/charge_sim_bloc.dart';
import 'package:atba_application/features/feature_charge_sim/presentation/block/charge_sim_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'charge_sim_bloc_test.mocks.dart';

@GenerateMocks([ChargeSimUseCase, GetBalanceUseCase])
void main(){



  MockGetBalanceUseCase mockGetBalanceUseCase = MockGetBalanceUseCase();
  MockChargeSimUseCase mockChargeSimUseCase = MockChargeSimUseCase();


  group('all Events test', () {
    test('getBalance Success', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(GetBalanceEntity())));

      final bloc = ChargeSimBloc(mockChargeSimUseCase,mockGetBalanceUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        ChargeSimState(balanceStatus: BalanceLoading(), chargeSimStatus: ChargeSimInit()),
        ChargeSimState(balanceStatus: BalanceCompleted(GetBalanceEntity()), chargeSimStatus: ChargeSimInit()),
      ]));
    });
    test('getBalance Error', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = ChargeSimBloc(mockChargeSimUseCase,mockGetBalanceUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        ChargeSimState(balanceStatus: BalanceLoading(), chargeSimStatus: ChargeSimInit()),
        ChargeSimState(balanceStatus: BalanceError("error"), chargeSimStatus: ChargeSimInit()),
      ]));
    });
    //************************************************************************************************************
    test('ChargeSim Success', () {
      when(mockChargeSimUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(ChargeSimEntity())));

      final bloc = ChargeSimBloc(mockChargeSimUseCase,mockGetBalanceUseCase);
      ChargeSimParam chargeSimParam = ChargeSimParam(totalAmount: 1, cellNumber: "2", operatorType: 3, simCardType: 4);
      bloc.add(ChargeEvent(chargeSimParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeSimState(balanceStatus: BalanceInit(), chargeSimStatus: ChargeSimLoading()),
        ChargeSimState(balanceStatus: BalanceInit(), chargeSimStatus: ChargeSimCompleted(ChargeSimEntity())),
      ]));
    });
    test('ChargeSim Error', () {
      when(mockChargeSimUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = ChargeSimBloc(mockChargeSimUseCase,mockGetBalanceUseCase);
      ChargeSimParam chargeSimParam = ChargeSimParam(totalAmount: 1, cellNumber: "2", operatorType: 3, simCardType: 4);
      bloc.add(ChargeEvent(chargeSimParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeSimState(balanceStatus: BalanceInit(), chargeSimStatus: ChargeSimLoading()),
        ChargeSimState(balanceStatus: BalanceInit(), chargeSimStatus: ChargeSimError("error")),
      ]));
    });
  });
}