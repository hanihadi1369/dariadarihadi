


import 'package:atba_application/core/params/transaction_history_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart';

class TransactionHistoryUseCase extends UseCase<DataState<TransactionsHistoryEntity>,TransactionHistoryParam> {
  final WalletRepository walletRepository;


  TransactionHistoryUseCase(this.walletRepository);

  @override
  Future<DataState<TransactionsHistoryEntity>> call(TransactionHistoryParam transactionHistoryParam) {
    return walletRepository.getTransactionsHistoryOperation(transactionHistoryParam.dateFrom,transactionHistoryParam.dateTo);
  }

}
