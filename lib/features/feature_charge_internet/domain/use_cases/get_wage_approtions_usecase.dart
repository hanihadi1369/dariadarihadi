







import 'package:atba_application/core/params/get_wage_approtions_param.dart';
import 'package:atba_application/features/feature_charge_internet/domain/repository/charge_internet_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/get_wage_apportions_cinternet_entity.dart';

class GetWageApprotionsUseCase extends UseCase<DataState<GetWageApportionsEntity>,GetWageApprotionsParam> {

  final ChargeInternetRepository chargeInternetRepository;
  GetWageApprotionsUseCase(this.chargeInternetRepository);

  @override
  Future<DataState<GetWageApportionsEntity>> call(GetWageApprotionsParam getWageApprotionsParam) {
    return chargeInternetRepository.getWageApportionsOperation(
      getWageApprotionsParam.operationCode,
      getWageApprotionsParam.amount,
    );
  }

}
