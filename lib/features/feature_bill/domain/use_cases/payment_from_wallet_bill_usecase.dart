import 'dart:ffi';





import 'package:atba_application/features/feature_bill/domain/entities/payment_from_wallet_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class PaymentFromWalletBillUseCase extends UseCase<DataState<PaymentFromWalletEntity>,String> {
  final BillRepository billRepository;


  PaymentFromWalletBillUseCase(this.billRepository);

  @override
  Future<DataState<PaymentFromWalletEntity>> call(String myRequestBody) {
    return billRepository.paymentFromWalletOperation(myRequestBody);
  }

}
