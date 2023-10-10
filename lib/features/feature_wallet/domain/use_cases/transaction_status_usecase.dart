



import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart';

class TransactionStatusUseCase extends UseCase<DataState<TransactionsHistoryEntity>,String> {
  final WalletRepository walletRepository;


  TransactionStatusUseCase(this.walletRepository);

  @override
  Future<DataState<TransactionsHistoryEntity>> call(String serial) {
    return walletRepository.getTransactionStatusOperation(serial);
  }

}
