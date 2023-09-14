import 'dart:ffi';

import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';

import '../entities/get_balance_entity_cinternet.dart';
import '../repository/charge_internet_repository.dart';








class GetBalanceUseCase extends UseCase<DataState<GetBalanceEntity>,String> {
  final ChargeInternetRepository chargeInternetRepository;


  GetBalanceUseCase(this.chargeInternetRepository);

  @override
  Future<DataState<GetBalanceEntity>> call(Void) {
    return chargeInternetRepository.getBalanceOperation();
  }

}
