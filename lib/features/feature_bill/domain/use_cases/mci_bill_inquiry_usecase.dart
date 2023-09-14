import 'dart:ffi';








import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class MciBillInquiryUseCase extends UseCase<DataState<MciBillInquiryEntity>,FixMobileBillInquiryParam> {
  final BillRepository billRepository;


  MciBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<MciBillInquiryEntity>> call(FixMobileBillInquiryParam fixMobileBillInquiryParam) {
    return billRepository.mciBillInquiryOperation(fixMobileBillInquiryParam.mobileNumber, fixMobileBillInquiryParam.traceNumber);
  }

}
