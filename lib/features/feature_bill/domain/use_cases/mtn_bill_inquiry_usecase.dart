import 'dart:ffi';








import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class MtnBillInquiryUseCase extends UseCase<DataState<MtnBillInquiryEntity>,FixMobileBillInquiryParam> {
  final BillRepository billRepository;


  MtnBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<MtnBillInquiryEntity>> call(FixMobileBillInquiryParam fixMobileBillInquiryParam) {
    return billRepository.mtnBillInquiryOperation(fixMobileBillInquiryParam.mobileNumber, fixMobileBillInquiryParam.traceNumber);
  }

}
