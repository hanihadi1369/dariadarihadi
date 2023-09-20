// Mocks generated by Mockito 5.4.0 from annotations
// in atba_application/test/features/feature_main/presentation/block/main_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:atba_application/core/resources/data_state.dart' as _i3;
import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart'
    as _i6;
import 'package:atba_application/features/feature_main/domain/entities/get_profile_entity.dart'
    as _i8;
import 'package:atba_application/features/feature_main/domain/repository/main_repository.dart'
    as _i2;
import 'package:atba_application/features/feature_main/domain/use_cases/get_balance_usecase.dart'
    as _i4;
import 'package:atba_application/features/feature_main/domain/use_cases/get_profile_usecase.dart'
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

class _FakeMainRepository_0 extends _i1.SmartFake
    implements _i2.MainRepository {
  _FakeMainRepository_0(
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

/// A class which mocks [GetBalanceUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBalanceUseCase extends _i1.Mock implements _i4.GetBalanceUseCase {
  MockGetBalanceUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MainRepository get mainRepository => (super.noSuchMethod(
        Invocation.getter(#mainRepository),
        returnValue: _FakeMainRepository_0(
          this,
          Invocation.getter(#mainRepository),
        ),
      ) as _i2.MainRepository);
  @override
  _i5.Future<_i3.DataState<_i6.GetBalanceEntity>> call(String? Void) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [Void],
        ),
        returnValue: _i5.Future<_i3.DataState<_i6.GetBalanceEntity>>.value(
            _FakeDataState_1<_i6.GetBalanceEntity>(
          this,
          Invocation.method(
            #call,
            [Void],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i6.GetBalanceEntity>>);
}

/// A class which mocks [GetProfileUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProfileUseCase extends _i1.Mock implements _i7.GetProfileUseCase {
  MockGetProfileUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MainRepository get mainRepository => (super.noSuchMethod(
        Invocation.getter(#mainRepository),
        returnValue: _FakeMainRepository_0(
          this,
          Invocation.getter(#mainRepository),
        ),
      ) as _i2.MainRepository);
  @override
  _i5.Future<_i3.DataState<_i8.GetProfileEntity>> call(String? Void) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [Void],
        ),
        returnValue: _i5.Future<_i3.DataState<_i8.GetProfileEntity>>.value(
            _FakeDataState_1<_i8.GetProfileEntity>(
          this,
          Invocation.method(
            #call,
            [Void],
          ),
        )),
      ) as _i5.Future<_i3.DataState<_i8.GetProfileEntity>>);
}
