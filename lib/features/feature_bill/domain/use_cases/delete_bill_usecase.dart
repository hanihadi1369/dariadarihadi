import 'dart:ffi';


import 'package:atba_application/core/general/general_response_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/get_bills_entity.dart';
import '../repository/bill_repository.dart';



class DeleteBillUseCase extends UseCase<DataState<GeneralResponseEntity>,String> {
  final BillRepository billRepository;


  DeleteBillUseCase(this.billRepository);

  @override
  Future<DataState<GeneralResponseEntity>> call(String billId) {
    return billRepository.deleteBillOperation(billId);
  }

}
