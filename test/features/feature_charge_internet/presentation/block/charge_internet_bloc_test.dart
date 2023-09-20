

import 'package:atba_application/core/params/buy_internet_package_param.dart';
import 'package:atba_application/core/params/show_internet_packages_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_charge_internet/domain/entities/buy_internet_package_entity.dart';
import 'package:atba_application/features/feature_charge_internet/domain/entities/get_balance_entity_cinternet.dart';
import 'package:atba_application/features/feature_charge_internet/domain/entities/show_internet_packages_entity.dart';
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/buy_internet_package_usecase.dart';
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/show_internet_packages_usecase.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/block/balance_status_cinternet.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/block/buy_internet_package_status.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/block/charge_internet_bloc.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/block/show_internet_packages_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'charge_internet_bloc_test.mocks.dart';

@GenerateMocks([ShowInternetPackagesUseCase, BuyInternetPackageUseCase,GetBalanceUseCase])
void main (){

  MockGetBalanceUseCase mockGetBalanceUseCase = MockGetBalanceUseCase();
  MockShowInternetPackagesUseCase mockShowInternetPackagesUseCase = MockShowInternetPackagesUseCase();
  MockBuyInternetPackageUseCase mockBuyInternetPackageUseCase = MockBuyInternetPackageUseCase();



  group('all Events test', () {
    test('getBalance Success', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(GetBalanceEntity())));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceLoading(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageInit()
        ),
        ChargeInternetState(
            balanceStatus: BalanceCompleted(GetBalanceEntity()),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageInit()),
      ]));
    });
    test('getBalance Error', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceLoading(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageInit()
        ),
        ChargeInternetState(
            balanceStatus: BalanceError("error"),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageInit()),
      ]));
    });
   //*****************************************************************************************************************************
    test('ShowInternetPackages Success', () {
      when(mockShowInternetPackagesUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(ShowInternetPackagesEntity())));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      ShowInternetPackagesParam showInternetPackagesParam = ShowInternetPackagesParam(mobile: "123", operatorType: 1);
      bloc.add(ShowInternetPackagesEvent(showInternetPackagesParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesLoading(),
            buyInternetPackageStatus: BuyInternetPackageInit()
        ),
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesCompleted(ShowInternetPackagesEntity()),
            buyInternetPackageStatus: BuyInternetPackageInit()),
      ]));
    });
    test('ShowInternetPackages Error', () {
      when(mockShowInternetPackagesUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      ShowInternetPackagesParam showInternetPackagesParam = ShowInternetPackagesParam(mobile: "123", operatorType: 1);
      bloc.add(ShowInternetPackagesEvent(showInternetPackagesParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesLoading(),
            buyInternetPackageStatus: BuyInternetPackageInit()
        ),
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesError("error"),
            buyInternetPackageStatus: BuyInternetPackageInit()),
      ]));
    });
    //*****************************************************************************************************************************
    test('BuyInternetPackage Success', () {
      when(mockBuyInternetPackageUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(BuyInternetPackageEntity())));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      BuyInternetPackageParam buyInternetPackageParam = BuyInternetPackageParam(bundleId: "1",amount: "2",cellNumber: "3",requestId: "4",operatorType: 1,operationCode: 2,type: 3);
      bloc.add(BuyInternetPackagesEvent(buyInternetPackageParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageLoading()
        ),
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageCompleted(BuyInternetPackageEntity())),
      ]));
    });
    test('BuyInternetPackage Error', () {
      when(mockBuyInternetPackageUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = ChargeInternetBloc(mockShowInternetPackagesUseCase,mockBuyInternetPackageUseCase,mockGetBalanceUseCase);
      BuyInternetPackageParam buyInternetPackageParam = BuyInternetPackageParam(bundleId: "1",amount: "2",cellNumber: "3",requestId: "4",operatorType: 1,operationCode: 2,type: 3);
      bloc.add(BuyInternetPackagesEvent(buyInternetPackageParam));

      expectLater(bloc.stream,emitsInOrder([
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageLoading()
        ),
        ChargeInternetState(
            balanceStatus: BalanceInit(),
            showInternetPackagesStatus: ShowInternetPackagesInit(),
            buyInternetPackageStatus: BuyInternetPackageError("error")),
      ]));
    });
    //*****************************************************************************************************************************
  });


}