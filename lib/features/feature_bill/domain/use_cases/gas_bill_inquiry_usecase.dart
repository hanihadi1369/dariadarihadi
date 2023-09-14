import 'dart:ffi';






import 'package:atba_application/core/params/gas_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class GasBillInquiryUseCase extends UseCase<DataState<GasBillInquiryEntity>,GasBillInquiryParam> {
  final BillRepository billRepository;


  GasBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<GasBillInquiryEntity>> call(GasBillInquiryParam gasBillInquiryParam) {
    return billRepository.gasBillInquiryOperation(gasBillInquiryParam.participateCode,gasBillInquiryParam.gasBillID,gasBillInquiryParam.traceNumber);
  }

}
