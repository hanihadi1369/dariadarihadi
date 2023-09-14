import 'dart:ffi';










import 'package:atba_application/core/params/charge_sim_param.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/charge_sim_entity.dart';
import '../repository/charge_sim_repository.dart';




class ChargeSimUseCase extends UseCase<DataState<ChargeSimEntity>,ChargeSimParam> {
  final ChargeSimRepository chargeSimRepository;


  ChargeSimUseCase(this.chargeSimRepository);

  @override
  Future<DataState<ChargeSimEntity>> call(ChargeSimParam chargeSimParam) {
    return chargeSimRepository.chargeSimOperation(
       chargeSimParam.totalAmount,
      chargeSimParam.cellNumber,
      chargeSimParam.operatorType,
      chargeSimParam.simCardType
    );
  }

}
