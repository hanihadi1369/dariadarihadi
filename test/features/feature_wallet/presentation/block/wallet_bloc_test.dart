





import 'package:atba_application/core/params/transfer_kifbkif_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/charge_wallet_usecase.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/transaction_history_usecase.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/transfer_kifbkif_usecase.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/balance_status_wallet.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/charge_wallet_status.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/transaction_history_status.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/transfer_kifbkif_status.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/wallet_bloc.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/wallet_page_index_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'wallet_bloc_test.mocks.dart';

@GenerateMocks([ChargeWalletUseCase, TransferKifBKifUseCase,GetBalanceUseCase,TransactionHistoryUseCase])
void main (){

  MockChargeWalletUseCase mockChargeWalletUseCase = MockChargeWalletUseCase();
  MockTransferKifBKifUseCase mockTransferKifBKifUseCase = MockTransferKifBKifUseCase();
  MockGetBalanceUseCase mockGetBalanceUseCase = MockGetBalanceUseCase();
  MockTransactionHistoryUseCase mockTransactionHistoryUseCase = MockTransactionHistoryUseCase();


  group('all Events test', () {
    test('getBalance Success', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(GetBalanceEntity())));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceLoading(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceCompleted(GetBalanceEntity()),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    test('getBalance Error', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);
      bloc.add(GetBalanceEvent());

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceLoading(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceError("error"),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    //************************************************************************************************************
    test('TransferKifBKif Success', () {
      when(mockTransferKifBKifUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(TransferKifBKifEntity())));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);
      TransferKifBKifParam transferKifBKifParam = TransferKifBKifParam(amount: 1, mobileNumber: "2");
      bloc.add(TransferKifBKifEvent(transferKifBKifParam));

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifLoading(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifCompleted(TransferKifBKifEntity()),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    test('TransferKifBKif Error', () {
      when(mockTransferKifBKifUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);
      TransferKifBKifParam transferKifBKifParam = TransferKifBKifParam(amount: 1, mobileNumber: "2");
      bloc.add(TransferKifBKifEvent(transferKifBKifParam));

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifLoading(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletInit(),
            transferKifBKifStatus: TransferKifBKifError("error"),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    //************************************************************************************************************
    test('ChargeWallet Success', () {
      when(mockChargeWalletUseCase.call(any)).thenAnswer((_) async => Future.value(DataSuccess(ChargeWalletEntity())));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);

      bloc.add(ChargeWalletEvent(100));

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletLoading(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletCompleted(ChargeWalletEntity()),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    test('ChargeWallet Error', () {
      when(mockChargeWalletUseCase.call(any)).thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = WalletBloc(mockChargeWalletUseCase,mockTransferKifBKifUseCase,mockGetBalanceUseCase,mockTransactionHistoryUseCase);
      bloc.add(ChargeWalletEvent(100));

      expectLater(bloc.stream,emitsInOrder([
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletLoading(),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
        WalletState(
            balanceStatus: BalanceInit(),
            chargeWalletStatus: ChargeWalletError("error"),
            transferKifBKifStatus: TransferKifBKifInit(),
            pageWalletIndexStatus: PageWalletIndexStatus1(),
            transactionsHistoryStatus: TransactionsHistoryInit()
        ),
      ]));
    });
    //************************************************************************************************************


  });

}