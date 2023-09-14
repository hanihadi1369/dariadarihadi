import 'dart:ffi';


import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/get_bills_entity.dart';
import '../repository/bill_repository.dart';



class GetBillsUseCase extends UseCase<DataState<GetBillsEntity>,String> {
  final BillRepository billRepository;


  GetBillsUseCase(this.billRepository);

  @override
  Future<DataState<GetBillsEntity>> call(Void) {
    return billRepository.getBillsOperation();
  }

}
