import 'dart:async';


import 'package:atba_application/core/params/bargh_bill_inquiry_param.dart';
import 'package:atba_application/core/params/fixline_bill_inquiry_param.dart';
import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/core/params/gas_bill_inquiry_param.dart';
import 'package:atba_application/core/params/water_bill_inquiry_param.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/fixline_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/gas_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/mci_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/rightel_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/water_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/balance_status_bill.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/bill_page_index_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/bills_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/fixline_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/gas_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mci_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mtn_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/rightel_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/water_bill_inquiry_status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/params/create_bill_param.dart';
import '../../../../core/params/update_bill_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/bargh_bill_inquiry_usecase.dart';
import '../../domain/use_cases/create_bill_usecase.dart';
import '../../domain/use_cases/delete_bill_usecase.dart';
import '../../domain/use_cases/get_bills_usecase.dart';
import '../../domain/use_cases/mtn_bill_inquiry_usecase.dart';
import '../../domain/use_cases/payment_from_wallet_bill_usecase.dart';
import '../../domain/use_cases/update_bill_usecase.dart';
import 'statuses/bargh_bill_inquiry_status.dart';
import 'statuses/create_bill_status.dart';
import 'statuses/delete_bill_status.dart';
import 'statuses/payment_from_wallet_status.dart';
import 'statuses/update_bill_status.dart';


part 'bill_event.dart';
part 'bill_state.dart';


class BillBloc extends Bloc<BillEvent, BillState> {
  final GetBillsUseCase getBillsUseCase;
  final CreateBillUseCase createBillUseCase;
  final UpdateBillUseCase updateBillUseCase;
  final DeleteBillUseCase deleteBillUseCase;

  final BarghBillInquiryUseCase barghBillInquiryUseCase;
  final WaterBillInquiryUseCase waterBillInquiryUseCase;
  final GasBillInquiryUseCase gasBillInquiryUseCase;
  final FixLineBillInquiryUseCase fixLineBillInquiryUseCase;


  final MciBillInquiryUseCase mciBillInquiryUseCase;
  final MtnBillInquiryUseCase mtnBillInquiryUseCase;
  final RightelBillInquiryUseCase rightelBillInquiryUseCase;




  final PaymentFromWalletBillUseCase paymentFromWalletBillUseCase;
  final GetBalanceUseCase getBalanceUseCase;



  BillBloc(
      this.getBillsUseCase,
      this.createBillUseCase,
      this.updateBillUseCase,
      this.deleteBillUseCase,
      this.barghBillInquiryUseCase,
      this.waterBillInquiryUseCase,
      this.gasBillInquiryUseCase,
      this.fixLineBillInquiryUseCase,

      this.mciBillInquiryUseCase,
      this.mtnBillInquiryUseCase,
      this.rightelBillInquiryUseCase,




      this.paymentFromWalletBillUseCase,
      this.getBalanceUseCase,
      ) : super(
      BillState(
          billsStatus: BillsInit(),
          pageBillIndexStatus: PageBillIndexStatus1(),
          createBillStatus: CreateBillInit(),
          updateBillStatus: UpdateBillInit(),
          deleteBillStatus: DeleteBillInit(),

          barghBillInquiryStatus: BarghBillInquiryInit(),
          waterBillInquiryStatus: WaterBillInquiryInit(),
          gasBillInquiryStatus: GasBillInquiryInit(),
          fixLineBillInquiryStatus: FixLineBillInquiryInit(),

          mciBillInquiryStatus: MciBillInquiryInit(),
          mtnBillInquiryStatus: MtnBillInquiryInit(),
          rightelBillInquiryStatus: RightelBillInquiryInit(),

          paymentFromWalletStatus: PaymentFromWalletInit(),
          balanceStatus: BalanceInit()
      )) {

    on<GetBillsEvent>((event, emit) async {

      emit(state.copyWith(newBillsStatus: BillsLoading()));

      DataState dataState = await getBillsUseCase("");

      if(dataState is DataSuccess){
        emit(state.copyWith(newBillsStatus: BillsCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newBillsStatus: BillsError(dataState.error!)));
      }
    });


    on<GetBalanceEvent>((event, emit) async {

      emit(state.copyWith(newBalanceStatus: BalanceLoading()));

      DataState dataState = await getBalanceUseCase("");

      if(dataState is DataSuccess){
        emit(state.copyWith(newBalanceStatus: BalanceCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newBalanceStatus: BalanceError(dataState.error!)));
      }
    });




    on<BillChangePageIndexEvent>((event, emit) async {

      if(event.pageIndex ==1){
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus1()));
      }else if(event.pageIndex == 11) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus11()));
      }else if(event.pageIndex == 12) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus12()));
      }else if(event.pageIndex == 13) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus13()));
      }else if(event.pageIndex == 14) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus14()));
      }else if(event.pageIndex == 30) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus30()));
      }else if(event.pageIndex == 31) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus31()));
      }else if(event.pageIndex == 32) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus32()));
      }else if(event.pageIndex == 33) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus33()));
      }else if(event.pageIndex == 34) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus34()));
      }else if(event.pageIndex == 2) {
        emit(state.copyWith(newPageBillIndexStatus: PageBillIndexStatus2()));
      }

    });




    on<CreateBillEvent>((event, emit) async {

      emit(state.copyWith(newCreateBillStatus: CreateBillLoading()));

      DataState dataState = await createBillUseCase(event.createBillParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newCreateBillStatus: CreateBillCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newCreateBillStatus: CreateBillError(dataState.error!)));
      }
    });


    on<UpdateBillEvent>((event, emit) async {

      emit(state.copyWith(newUpdateBillStatus: UpdateBillLoading()));

      DataState dataState = await updateBillUseCase(event.updateBillParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newUpdateBillStatus: UpdateBillCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newUpdateBillStatus: UpdateBillError(dataState.error!)));
      }
    });

    on<DeleteBillEvent>((event, emit) async {

      emit(state.copyWith(newDeleteBillStatus: DeleteBillLoading()));

      DataState dataState = await deleteBillUseCase(event.billId);

      if(dataState is DataSuccess){
        emit(state.copyWith(newDeleteBillStatus: DeleteBillCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newDeleteBillStatus: DeleteBillError(dataState.error!)));
      }
    });

    on<BarghBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newBarghBillInquiryStatus: BarghBillInquiryLoading()));

      DataState dataState = await barghBillInquiryUseCase(event.barghBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newBarghBillInquiryStatus: BarghBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newBarghBillInquiryStatus: BarghBillInquiryError(dataState.error!)));
      }
    });

    on<WaterBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newWaterBillInquiryStatus: WaterBillInquiryLoading()));

      DataState dataState = await waterBillInquiryUseCase(event.waterBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newWaterBillInquiryStatus: WaterBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newWaterBillInquiryStatus: WaterBillInquiryError(dataState.error!)));
      }
    });


    on<GasBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newGasBillInquiryStatus: GasBillInquiryLoading()));

      DataState dataState = await gasBillInquiryUseCase(event.gasBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newGasBillInquiryStatus: GasBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newGasBillInquiryStatus: GasBillInquiryError(dataState.error!)));
      }
    });


    on<FixLineBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newFixLineBillInquiryStatus: FixLineBillInquiryLoading()));

      DataState dataState = await fixLineBillInquiryUseCase(event.fixLineBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newFixLineBillInquiryStatus: FixLineBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newFixLineBillInquiryStatus: FixLineBillInquiryError(dataState.error!)));
      }
    });



















    on<MciBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newMciBillInquiryStatus: MciBillInquiryLoading()));

      DataState dataState = await mciBillInquiryUseCase(event.fixMobileBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newMciBillInquiryStatus: MciBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newMciBillInquiryStatus: MciBillInquiryError(dataState.error!)));
      }
    });




    on<MtnBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newMtnBillInquiryStatus: MtnBillInquiryLoading()));

      DataState dataState = await mtnBillInquiryUseCase(event.fixMobileBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newMtnBillInquiryStatus: MtnBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newMtnBillInquiryStatus: MtnBillInquiryError(dataState.error!)));
      }
    });




    on<RightelBillInquiryEvent>((event, emit) async {

      emit(state.copyWith(newRightelBillInquiryStatus: RightelBillInquiryLoading()));

      DataState dataState = await rightelBillInquiryUseCase(event.fixMobileBillInquiryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newRightelBillInquiryStatus: RightelBillInquiryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newRightelBillInquiryStatus: RightelBillInquiryError(dataState.error!)));
      }
    });


















    on<PaymentFromWalletBillEvent>((event, emit) async {

      emit(state.copyWith(newPaymentFromWalletStatus: PaymentFromWalletLoading()));

      DataState dataState = await paymentFromWalletBillUseCase(event.myRequestBody);

      if(dataState is DataSuccess){
        emit(state.copyWith(newPaymentFromWalletStatus: PaymentFromWalletCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newPaymentFromWalletStatus: PaymentFromWalletError(dataState.error!)));
      }
    });


  }
}
