
import 'package:atba_application/core/general/general_response_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/fixline_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_balance_entity_bill.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/bargh_bill_inquiry_entity.dart';
import '../entities/get_bills_entity.dart';
import '../entities/payment_from_wallet_entity.dart';



abstract class BillRepository{

  Future<DataState<GetBillsEntity>> getBillsOperation();
  Future<DataState<GeneralResponseEntity>> createBillOperation(int billType, String billCode, String billTitle);
  Future<DataState<GeneralResponseEntity>> updateBillOperation(String billId, int billType,String billCode, String billTitle);
  Future<DataState<GeneralResponseEntity>> deleteBillOperation(String billId);


  Future<DataState<BarghBillInquiryEntity>> barghBillInquiryOperation(String electricityBillID,String traceNumber);
  Future<DataState<WaterBillInquiryEntity>> waterBillInquiryOperation(String waterBillID,String traceNumber);
  Future<DataState<GasBillInquiryEntity>> gasBillInquiryOperation(String participateCode,String gasBillID,String traceNumber);
  Future<DataState<FixLineBillInquiryEntity>> fixLineBillInquiryOperation(String fixedLineNumber,String traceNumber);

  Future<DataState<MciBillInquiryEntity>> mciBillInquiryOperation(String mobileNumber,String traceNumber);
  Future<DataState<MtnBillInquiryEntity>> mtnBillInquiryOperation(String mobileNumber,String traceNumber);
  Future<DataState<RightelBillInquiryEntity>> rightelBillInquiryOperation(String mobileNumber,String traceNumber);


  Future<DataState<PaymentFromWalletEntity>> paymentFromWalletOperation(String myRequestBody);
  Future<DataState<GetBalanceEntity>> getBalanceOperation();


}