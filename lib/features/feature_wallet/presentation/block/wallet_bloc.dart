import 'dart:async';



import 'package:atba_application/core/params/transaction_history_param.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/balance_status_wallet.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/transaction_history_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/params/transfer_kifbkif_param.dart';
import '../../../../core/resources/data_state.dart';

import '../../domain/use_cases/charge_wallet_usecase.dart';
import '../../domain/use_cases/transaction_history_usecase.dart';
import '../../domain/use_cases/transfer_kifbkif_usecase.dart';
import 'charge_wallet_status.dart';
import 'transfer_kifbkif_status.dart';
import 'wallet_page_index_status.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final ChargeWalletUseCase chargeWalletUseCase;
  final TransferKifBKifUseCase transferKifBKifUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final TransactionHistoryUseCase transactionHistoryUseCase;


  WalletBloc(
      this.chargeWalletUseCase,
      this.transferKifBKifUseCase,
      this.getBalanceUseCase,
      this.transactionHistoryUseCase
      ) : super(WalletState(
      chargeWalletStatus: ChargeWalletInit(),
      transferKifBKifStatus: TransferKifBKifInit(),
      pageWalletIndexStatus:PageWalletIndexStatus1(),
      balanceStatus: BalanceInit(),
      transactionsHistoryStatus: TransactionsHistoryInit()
  )) {

    on<ChargeWalletEvent>((event, emit) async {

      emit(state.copyWith(newChargeWalletStatus: ChargeWalletLoading()));

      DataState dataState = await chargeWalletUseCase(event.amount);

      if(dataState is DataSuccess){
        emit(state.copyWith(newChargeWalletStatus: ChargeWalletCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newChargeWalletStatus: ChargeWalletError(dataState.error!)));
      }
    });


    on<TransferKifBKifEvent>((event, emit) async {

      emit(state.copyWith(newTransferKifBKifStatus: TransferKifBKifLoading()));

      DataState dataState = await transferKifBKifUseCase(event.transferKifBKifParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newTransferKifBKifStatus: TransferKifBKifCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newTransferKifBKifStatus: TransferKifBKifError(dataState.error!)));
      }
    });















    on<TransactionsHistoryEvent>((event, emit) async {

      emit(state.copyWith(newTransactionsHistoryStatus: TransactionsHistoryLoading()));

      DataState dataState = await transactionHistoryUseCase(event.transactionsHistoryParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newTransactionsHistoryStatus: TransactionsHistoryCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newTransactionsHistoryStatus: TransactionsHistoryError(dataState.error!)));
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






    on<WalletChangePageIndexEvent>((event, emit) async {

      if(event.pageIndex ==1){
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus1()));
      }else if(event.pageIndex == 2) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus2()));
      }else if(event.pageIndex == 21) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus21()));
      }else if(event.pageIndex == 22) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus22()));
      }else if(event.pageIndex == 3) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus3()));
      }else if(event.pageIndex == 4) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus4()));
      }else if(event.pageIndex == 41) {
        emit(state.copyWith(newPageWalletIndexStatus: PageWalletIndexStatus41()));
      }



    });



  }
}
