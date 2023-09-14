import 'dart:ffi';


import '../../../../core/general/general_response_entity.dart';
import '../../../../core/params/create_bill_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class CreateBillUseCase extends UseCase<DataState<GeneralResponseEntity>,CreateBillParam> {
  final BillRepository billRepository;


  CreateBillUseCase(this.billRepository);

  @override
  Future<DataState<GeneralResponseEntity>> call(CreateBillParam createBillParam) {
    return billRepository.createBillOperation(createBillParam.billType, createBillParam.billCode, createBillParam.billTitle);
  }

}
