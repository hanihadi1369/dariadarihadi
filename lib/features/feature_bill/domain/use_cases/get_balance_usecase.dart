import 'dart:ffi';

import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_balance_entity_bill.dart';
import 'package:atba_application/features/feature_bill/domain/repository/bill_repository.dart';







class GetBalanceUseCase extends UseCase<DataState<GetBalanceEntity>,String> {
  final BillRepository billRepository;


  GetBalanceUseCase(this.billRepository);

  @override
  Future<DataState<GetBalanceEntity>> call(Void) {
    return billRepository.getBalanceOperation();
  }

}
