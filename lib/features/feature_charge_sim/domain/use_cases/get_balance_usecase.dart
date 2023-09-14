import 'dart:ffi';

import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';

import '../entities/get_balance_entity_csim.dart';
import '../repository/charge_sim_repository.dart';








class GetBalanceUseCase extends UseCase<DataState<GetBalanceEntity>,String> {
  final ChargeSimRepository chargeSimRepository;


  GetBalanceUseCase(this.chargeSimRepository);

  @override
  Future<DataState<GetBalanceEntity>> call(Void) {
    return chargeSimRepository.getBalanceOperation();
  }

}
