import 'dart:ffi';






import 'package:atba_application/core/params/fixline_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/fixline_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class FixLineBillInquiryUseCase extends UseCase<DataState<FixLineBillInquiryEntity>,FixLineBillInquiryParam> {
  final BillRepository billRepository;


  FixLineBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<FixLineBillInquiryEntity>> call(FixLineBillInquiryParam fixLineBillInquiryParam) {
    return billRepository.fixLineBillInquiryOperation(fixLineBillInquiryParam.fixedLineNumber, fixLineBillInquiryParam.traceNumber);
  }

}
