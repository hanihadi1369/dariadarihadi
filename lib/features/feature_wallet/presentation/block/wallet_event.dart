part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}



class ChargeWalletEvent extends WalletEvent{
  final int amount;
  ChargeWalletEvent(this.amount);
}

class TransferKifBKifEvent extends WalletEvent{
  final TransferKifBKifParam transferKifBKifParam;
  TransferKifBKifEvent(this.transferKifBKifParam);
}

class TransactionsHistoryEvent extends WalletEvent{
  final TransactionHistoryParam transactionsHistoryParam;
  TransactionsHistoryEvent(this.transactionsHistoryParam);
}


class TransactionStatusEvent extends WalletEvent{
  final String serial;
  TransactionStatusEvent(this.serial);
}


class WalletChangePageIndexEvent extends WalletEvent{
  final int pageIndex;
  WalletChangePageIndexEvent(this.pageIndex);
}


class GetBalanceEvent extends WalletEvent{
  GetBalanceEvent();
}