







import 'package:atba_application/core/params/get_wage_approtions_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/get_wage_apportions_csim_entity.dart';
import '../repository/charge_sim_repository.dart';


class GetWageApprotionsUseCase extends UseCase<DataState<GetWageApportionsEntity>,GetWageApprotionsParam> {

  final ChargeSimRepository chargeSimRepository;
  GetWageApprotionsUseCase(this.chargeSimRepository);

  @override
  Future<DataState<GetWageApportionsEntity>> call(GetWageApprotionsParam getWageApprotionsParam) {
    return chargeSimRepository.getWageApportionsOperation(
      getWageApprotionsParam.operationCode,
      getWageApprotionsParam.amount,
    );
  }

}
