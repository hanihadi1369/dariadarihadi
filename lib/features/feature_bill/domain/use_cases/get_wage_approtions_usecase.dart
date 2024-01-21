







import 'package:atba_application/core/params/get_wage_approtions_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_wage_apportions_bill_entity.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class GetWageApprotionsUseCase extends UseCase<DataState<GetWageApportionsEntity>,GetWageApprotionsParam> {

  final BillRepository billRepository;
  GetWageApprotionsUseCase(this.billRepository);

  @override
  Future<DataState<GetWageApportionsEntity>> call(GetWageApprotionsParam getWageApprotionsParam) {
    return billRepository.getWageApportionsOperation(
      getWageApprotionsParam.operationCode,
      getWageApprotionsParam.amount,
    );
  }

}
