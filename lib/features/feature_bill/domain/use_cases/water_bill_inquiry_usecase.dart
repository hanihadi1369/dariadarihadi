import 'dart:ffi';




import 'package:atba_application/core/params/water_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/bill_repository.dart';



class WaterBillInquiryUseCase extends UseCase<DataState<WaterBillInquiryEntity>,WaterBillInquiryParam> {
  final BillRepository billRepository;


  WaterBillInquiryUseCase(this.billRepository);

  @override
  Future<DataState<WaterBillInquiryEntity>> call(WaterBillInquiryParam waterBillInquiryParam) {
    return billRepository.waterBillInquiryOperation(waterBillInquiryParam.waterBillID, waterBillInquiryParam.traceNumber);
  }

}
