import 'dart:ffi';








import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class RightelBillInquiryUseCase extends UseCase<DataState<RightelBillInquiryEntity>,FixMobileBillInquiryParam> {
  final BillRepository billRepository;


  RightelBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<RightelBillInquiryEntity>> call(FixMobileBillInquiryParam fixMobileBillInquiryParam) {
    return billRepository.rightelBillInquiryOperation(fixMobileBillInquiryParam.mobileNumber, fixMobileBillInquiryParam.traceNumber);
  }

}
