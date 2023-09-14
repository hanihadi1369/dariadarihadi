part of 'bill_bloc.dart';



@immutable
abstract class BillEvent {}



class GetBillsEvent extends BillEvent{
  GetBillsEvent();
}


class BillChangePageIndexEvent extends BillEvent{
  final int pageIndex;
  BillChangePageIndexEvent(this.pageIndex);
}

class CreateBillEvent extends BillEvent{
  final CreateBillParam createBillParam;
  CreateBillEvent(this.createBillParam);
}

class UpdateBillEvent extends BillEvent{
 final UpdateBillParam updateBillParam;
  UpdateBillEvent(this.updateBillParam);
}
class DeleteBillEvent extends BillEvent{
  final String billId;
  DeleteBillEvent(this.billId);
}

class BarghBillInquiryEvent extends BillEvent{
  final BarghBillInquiryParam barghBillInquiryParam;
  BarghBillInquiryEvent(this.barghBillInquiryParam);
}
class WaterBillInquiryEvent extends BillEvent{
  final WaterBillInquiryParam waterBillInquiryParam;
  WaterBillInquiryEvent(this.waterBillInquiryParam);
}
class GasBillInquiryEvent extends BillEvent{
  final GasBillInquiryParam gasBillInquiryParam;
  GasBillInquiryEvent(this.gasBillInquiryParam);
}
class FixLineBillInquiryEvent extends BillEvent{
  final FixLineBillInquiryParam fixLineBillInquiryParam;
  FixLineBillInquiryEvent(this.fixLineBillInquiryParam);
}



class MciBillInquiryEvent extends BillEvent{
  final FixMobileBillInquiryParam fixMobileBillInquiryParam;
  MciBillInquiryEvent(this.fixMobileBillInquiryParam);
}

class MtnBillInquiryEvent extends BillEvent{
  final FixMobileBillInquiryParam fixMobileBillInquiryParam;
  MtnBillInquiryEvent(this.fixMobileBillInquiryParam);
}

class RightelBillInquiryEvent extends BillEvent{
  final FixMobileBillInquiryParam fixMobileBillInquiryParam;
  RightelBillInquiryEvent(this.fixMobileBillInquiryParam);
}









class PaymentFromWalletBillEvent extends BillEvent{
  final String myRequestBody;
  PaymentFromWalletBillEvent(this.myRequestBody);
}

class GetBalanceEvent extends BillEvent{
  GetBalanceEvent();
}

