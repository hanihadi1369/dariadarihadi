import 'dart:ffi';


import 'package:atba_application/core/general/general_response_entity.dart';

import '../../../../core/params/update_bill_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/get_bills_entity.dart';
import '../repository/bill_repository.dart';



class UpdateBillUseCase extends UseCase<DataState<GeneralResponseEntity>,UpdateBillParam> {
  final BillRepository billRepository;


  UpdateBillUseCase(this.billRepository);

  @override
  Future<DataState<GeneralResponseEntity>> call(UpdateBillParam updateBillParam) {
    return billRepository.updateBillOperation(updateBillParam.billId, updateBillParam.billType, updateBillParam.billCode, updateBillParam.billTitle);
  }

}
