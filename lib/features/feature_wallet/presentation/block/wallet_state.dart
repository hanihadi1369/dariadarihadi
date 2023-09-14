part of 'wallet_bloc.dart';



class WalletState{
  ChargeWalletStatus chargeWalletStatus;
  TransferKifBKifStatus transferKifBKifStatus;
  PageWalletIndexStatus pageWalletIndexStatus;
  BalanceStatus balanceStatus;


  WalletState({required this.chargeWalletStatus,required this.transferKifBKifStatus,required this.balanceStatus,required this.pageWalletIndexStatus});

  WalletState copyWith({ChargeWalletStatus? newChargeWalletStatus,TransferKifBKifStatus? newTransferKifBKifStatus,BalanceStatus? newBalanceStatus,PageWalletIndexStatus? newPageWalletIndexStatus }){

    return WalletState(
        chargeWalletStatus: newChargeWalletStatus ?? this.chargeWalletStatus,
        transferKifBKifStatus: newTransferKifBKifStatus ?? this.transferKifBKifStatus,
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        pageWalletIndexStatus: newPageWalletIndexStatus?? this.pageWalletIndexStatus
    );
  }


}