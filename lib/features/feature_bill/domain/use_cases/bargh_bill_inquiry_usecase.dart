import 'dart:ffi';


import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';

import '../../../../core/params/bargh_bill_inquiry_param.dart';
import '../../../../core/params/update_bill_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class BarghBillInquiryUseCase extends UseCase<DataState<BarghBillInquiryEntity>,BarghBillInquiryParam> {
  final BillRepository billRepository;


  BarghBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<BarghBillInquiryEntity>> call(BarghBillInquiryParam barghBillInquiryParam) {
    return billRepository.barghBillInquiryOperation(barghBillInquiryParam.electricityBillID, barghBillInquiryParam.traceNumber);
  }

}
