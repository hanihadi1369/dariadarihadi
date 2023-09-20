part of 'bill_bloc.dart';

class BillState extends Equatable {
  BillsStatus billsStatus;
  PageBillIndexStatus pageBillIndexStatus;
  CreateBillStatus createBillStatus;
  UpdateBillStatus updateBillStatus;
  DeleteBillStatus deleteBillStatus;
  BarghBillInquiryStatus barghBillInquiryStatus;
  WaterBillInquiryStatus waterBillInquiryStatus;
  GasBillInquiryStatus gasBillInquiryStatus;
  FixLineBillInquiryStatus fixLineBillInquiryStatus;

  MciBillInquiryStatus mciBillInquiryStatus;
  MtnBillInquiryStatus mtnBillInquiryStatus;
  RightelBillInquiryStatus rightelBillInquiryStatus;

  PaymentFromWalletStatus paymentFromWalletStatus;
  BalanceStatus balanceStatus;

  BillState({
    required this.billsStatus,
    required this.pageBillIndexStatus,
    required this.createBillStatus,
    required this.updateBillStatus,
    required this.deleteBillStatus,
    required this.barghBillInquiryStatus,
    required this.waterBillInquiryStatus,
    required this.gasBillInquiryStatus,
    required this.fixLineBillInquiryStatus,

    required this.mciBillInquiryStatus,
    required this.mtnBillInquiryStatus,
    required this.rightelBillInquiryStatus,




    required this.paymentFromWalletStatus,
    required this.balanceStatus
  });


  @override
  List<Object?> get props => [
   billsStatus,
   pageBillIndexStatus,
   createBillStatus,
   updateBillStatus,
   deleteBillStatus,
   barghBillInquiryStatus,
   waterBillInquiryStatus,
   gasBillInquiryStatus,
   fixLineBillInquiryStatus,

   mciBillInquiryStatus,
   mtnBillInquiryStatus,
   rightelBillInquiryStatus,

   paymentFromWalletStatus,
   balanceStatus,
  ];

  BillState copyWith({
    BillsStatus? newBillsStatus,
    PageBillIndexStatus? newPageBillIndexStatus,
    CreateBillStatus? newCreateBillStatus,
    UpdateBillStatus? newUpdateBillStatus,
    DeleteBillStatus? newDeleteBillStatus,
    BarghBillInquiryStatus? newBarghBillInquiryStatus,
    WaterBillInquiryStatus? newWaterBillInquiryStatus,
    GasBillInquiryStatus? newGasBillInquiryStatus,
    FixLineBillInquiryStatus? newFixLineBillInquiryStatus,


    MciBillInquiryStatus? newMciBillInquiryStatus,
    MtnBillInquiryStatus? newMtnBillInquiryStatus,
    RightelBillInquiryStatus? newRightelBillInquiryStatus,





    PaymentFromWalletStatus? newPaymentFromWalletStatus,
    BalanceStatus? newBalanceStatus
  }) {
    return BillState(
      billsStatus: newBillsStatus ?? this.billsStatus,
      balanceStatus: newBalanceStatus ?? this.balanceStatus,
      pageBillIndexStatus: newPageBillIndexStatus ?? this.pageBillIndexStatus,
      createBillStatus: newCreateBillStatus ?? this.createBillStatus,
      updateBillStatus: newUpdateBillStatus ?? this.updateBillStatus,
      deleteBillStatus: newDeleteBillStatus ?? this.deleteBillStatus,
      barghBillInquiryStatus: newBarghBillInquiryStatus ?? this.barghBillInquiryStatus,
      waterBillInquiryStatus:
          newWaterBillInquiryStatus ?? this.waterBillInquiryStatus,
      gasBillInquiryStatus:
          newGasBillInquiryStatus ?? this.gasBillInquiryStatus,
      fixLineBillInquiryStatus: newFixLineBillInquiryStatus ?? this.fixLineBillInquiryStatus,

      mciBillInquiryStatus: newMciBillInquiryStatus ?? this.mciBillInquiryStatus,
      mtnBillInquiryStatus: newMtnBillInquiryStatus ?? this.mtnBillInquiryStatus,
      rightelBillInquiryStatus: newRightelBillInquiryStatus ?? this.rightelBillInquiryStatus,



      paymentFromWalletStatus:
          newPaymentFromWalletStatus ?? this.paymentFromWalletStatus,
    );
  }
}
