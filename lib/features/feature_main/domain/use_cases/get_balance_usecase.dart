import 'dart:ffi';

import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/main_repository.dart';


class GetBalanceUseCase extends UseCase<DataState<GetBalanceEntity>,String> {
  final MainRepository mainRepository;


  GetBalanceUseCase(this.mainRepository);

  @override
  Future<DataState<GetBalanceEntity>> call(Void) {
    return mainRepository.getBalanceOperation();
  }

}
