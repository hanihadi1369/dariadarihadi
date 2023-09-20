// Mocks generated by Mockito 5.4.0 from annotations
// in atba_application/test/features/feature_charge_internet/presentation/block/charge_internet_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:atba_application/core/params/buy_internet_package_param.dart'
    as _i10;
import 'package:atba_application/core/params/show_internet_packages_param.dart'
    as _i7;
import 'package:atba_application/core/resources/data_state.dart' as _i3;
import 'package:atba_application/features/feature_charge_internet/domain/entities/buy_internet_package_entity.dart'
    as _i9;
import 'package:atba_application/features/feature_charge_internet/domain/entities/get_balance_entity_cinternet.dart'
    as _i12;
import 'package:atba_application/features/feature_charge_internet/domain/entities/show_internet_packages_entity.dart'
    as _i6;
import 'package:atba_application/features/feature_charge_internet/domain/repository/charge_internet_repository.dart'
    as _i2;
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/buy_internet_package_usecase.dart'
    as _i8;
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/get_balance_usecase.dart'
    as _i11;
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/show_internet_packages_usecase.dart'
    as _i4;
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

class _FakeChargeInternetRepository_0 extends _i1.SmartFake
    implements _i2.ChargeInternetRepository {
  _FakeChargeInternetRepository_0(
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

/// A class which mocks [ShowInternetPackagesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShowInternetPackagesUseCase extends _i1.Mock
    implements _i4.ShowInternetPackagesUseCase {
  MockShowInternetPackagesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChargeInternetRepository get chargeInternetRepository =>
      (super.noSuchMethod(
        Invocation.getter(#chargeInternetRepository),
        returnValue: _FakeChargeInternetRepository_0(
          this,
          Invocation.getter(#chargeInternetRepository),
        ),
      ) as _i2.ChargeInternetRepository);
  @override
  _i5.Future<_i3.DataState<_i6.ShowInternetPackagesEntity>> call(
          _i7.ShowInternetPackagesParam? showInternetPackagesParam) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [showInternetPackagesParam],
        ),
        returnValue:
            _i5.Future<_i3.DataState<_i6.ShowInternetPackagesEntity>>.value(
                _FakeDataState_1<_i6.ShowInternetPackagesEntity>(
          this,
          Invocation.method(
            #call,
            [showInternetPackagesParam],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i6.ShowInternetPackagesEntity>>);
}

/// A class which mocks [BuyInternetPackageUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuyInternetPackageUseCase extends _i1.Mock
    implements _i8.BuyInternetPackageUseCase {
  MockBuyInternetPackageUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChargeInternetRepository get chargeInternetRepository =>
      (super.noSuchMethod(
        Invocation.getter(#chargeInternetRepository),
        returnValue: _FakeChargeInternetRepository_0(
          this,
          Invocation.getter(#chargeInternetRepository),
        ),
      ) as _i2.ChargeInternetRepository);
  @override
  _i5.Future<_i3.DataState<_i9.BuyInternetPackageEntity>> call(
          _i10.BuyInternetPackageParam? buyInternetPackageParam) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [buyInternetPackageParam],
        ),
        returnValue:
            _i5.Future<_i3.DataState<_i9.BuyInternetPackageEntity>>.value(
                _FakeDataState_1<_i9.BuyInternetPackageEntity>(
          this,
          Invocation.method(
            #call,
            [buyInternetPackageParam],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i9.BuyInternetPackageEntity>>);
}

/// A class which mocks [GetBalanceUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBalanceUseCase extends _i1.Mock implements _i11.GetBalanceUseCase {
  MockGetBalanceUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChargeInternetRepository get chargeInternetRepository =>
      (super.noSuchMethod(
        Invocation.getter(#chargeInternetRepository),
        returnValue: _FakeChargeInternetRepository_0(
          this,
          Invocation.getter(#chargeInternetRepository),
        ),
      ) as _i2.ChargeInternetRepository);
  @override
  _i5.Future<_i3.DataState<_i12.GetBalanceEntity>> call(String? Void) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [Void],
        ),
        returnValue: _i5.Future<_i3.DataState<_i12.GetBalanceEntity>>.value(
            _FakeDataState_1<_i12.GetBalanceEntity>(
          this,
          Invocation.method(
            #call,
            [Void],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i12.GetBalanceEntity>>);
}
