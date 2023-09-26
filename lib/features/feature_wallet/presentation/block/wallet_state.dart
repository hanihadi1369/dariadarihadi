part of 'wallet_bloc.dart';



class WalletState extends Equatable{
  ChargeWalletStatus chargeWalletStatus;
  TransferKifBKifStatus transferKifBKifStatus;
  PageWalletIndexStatus pageWalletIndexStatus;
  BalanceStatus balanceStatus;
  TransactionsHistoryStatus transactionsHistoryStatus;


  WalletState({
    required this.chargeWalletStatus,
    required this.transferKifBKifStatus,
    required this.balanceStatus,
    required this.pageWalletIndexStatus,
    required this.transactionsHistoryStatus
  });



  @override
  List<Object?> get props => [
   chargeWalletStatus,
   transferKifBKifStatus,
   pageWalletIndexStatus,
   balanceStatus,
   transactionsHistoryStatus
  ];



  WalletState copyWith({
    ChargeWalletStatus? newChargeWalletStatus,
    TransferKifBKifStatus? newTransferKifBKifStatus,
    BalanceStatus? newBalanceStatus,
    PageWalletIndexStatus? newPageWalletIndexStatus,
    TransactionsHistoryStatus? newTransactionsHistoryStatus


  }){





    return WalletState(
        chargeWalletStatus: newChargeWalletStatus ?? this.chargeWalletStatus,
        transferKifBKifStatus: newTransferKifBKifStatus ?? this.transferKifBKifStatus,
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        pageWalletIndexStatus: newPageWalletIndexStatus?? this.pageWalletIndexStatus,
        transactionsHistoryStatus: newTransactionsHistoryStatus ?? this.transactionsHistoryStatus
    );
  }


}