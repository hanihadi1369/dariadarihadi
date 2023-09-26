// Mocks generated by Mockito 5.4.0 from annotations
// in atba_application/test/features/feature_wallet/presentation/block/wallet_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:atba_application/core/params/transaction_history_param.dart'
    as _i14;
import 'package:atba_application/core/params/transfer_kifbkif_param.dart'
    as _i9;
import 'package:atba_application/core/resources/data_state.dart' as _i3;
import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart'
    as _i6;
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart'
    as _i11;
import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart'
    as _i13;
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart'
    as _i8;
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart'
    as _i2;
import 'package:atba_application/features/feature_wallet/domain/use_cases/charge_wallet_usecase.dart'
    as _i4;
import 'package:atba_application/features/feature_wallet/domain/use_cases/get_balance_usecase.dart'
    as _i10;
import 'package:atba_application/features/feature_wallet/domain/use_cases/transaction_history_usecase.dart'
    as _i12;
import 'package:atba_application/features/feature_wallet/domain/use_cases/transfer_kifbkif_usecase.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWalletRepository_0 extends _i1.SmartFake
    implements _i2.WalletRepository {
  _FakeWalletRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDataState_1<T> extends _i1.SmartFake implements _i3.DataState<T> {
  _FakeDataState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ChargeWalletUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockChargeWalletUseCase extends _i1.Mock
    implements _i4.ChargeWalletUseCase {
  MockChargeWalletUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get walletRepository => (super.noSuchMethod(
        Invocation.getter(#walletRepository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#walletRepository),
        ),
      ) as _i2.WalletRepository);
  @override
  _i5.Future<_i3.DataState<_i6.ChargeWalletEntity>> call(int? amount) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [amount],
        ),
        returnValue: _i5.Future<_i3.DataState<_i6.ChargeWalletEntity>>.value(
            _FakeDataState_1<_i6.ChargeWalletEntity>(
          this,
          Invocation.method(
            #call,
            [amount],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i6.ChargeWalletEntity>>);
}

/// A class which mocks [TransferKifBKifUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransferKifBKifUseCase extends _i1.Mock
    implements _i7.TransferKifBKifUseCase {
  MockTransferKifBKifUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get walletRepository => (super.noSuchMethod(
        Invocation.getter(#walletRepository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#walletRepository),
        ),
      ) as _i2.WalletRepository);
  @override
  _i5.Future<_i3.DataState<_i8.TransferKifBKifEntity>> call(
          _i9.TransferKifBKifParam? transferKifBKifParam) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [transferKifBKifParam],
        ),
        returnValue: _i5.Future<_i3.DataState<_i8.TransferKifBKifEntity>>.value(
            _FakeDataState_1<_i8.TransferKifBKifEntity>(
          this,
          Invocation.method(
            #call,
            [transferKifBKifParam],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i8.TransferKifBKifEntity>>);
}

/// A class which mocks [GetBalanceUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBalanceUseCase extends _i1.Mock implements _i10.GetBalanceUseCase {
  MockGetBalanceUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get walletRepository => (super.noSuchMethod(
        Invocation.getter(#walletRepository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#walletRepository),
        ),
      ) as _i2.WalletRepository);
  @override
  _i5.Future<_i3.DataState<_i11.GetBalanceEntity>> call(String? Void) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [Void],
        ),
        returnValue: _i5.Future<_i3.DataState<_i11.GetBalanceEntity>>.value(
            _FakeDataState_1<_i11.GetBalanceEntity>(
          this,
          Invocation.method(
            #call,
            [Void],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i11.GetBalanceEntity>>);
}

/// A class which mocks [TransactionHistoryUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionHistoryUseCase extends _i1.Mock
    implements _i12.TransactionHistoryUseCase {
  MockTransactionHistoryUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletRepository get walletRepository => (super.noSuchMethod(
        Invocation.getter(#walletRepository),
        returnValue: _FakeWalletRepository_0(
          this,
          Invocation.getter(#walletRepository),
        ),
      ) as _i2.WalletRepository);
  @override
  _i5.Future<_i3.DataState<_i13.TransactionsHistoryEntity>> call(
          _i14.TransactionHistoryParam? transactionHistoryParam) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [transactionHistoryParam],
        ),
        returnValue:
            _i5.Future<_i3.DataState<_i13.TransactionsHistoryEntity>>.value(
                _FakeDataState_1<_i13.TransactionsHistoryEntity>(
          this,
          Invocation.method(
            #call,
            [transactionHistoryParam],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i13.TransactionsHistoryEntity>>);
}
