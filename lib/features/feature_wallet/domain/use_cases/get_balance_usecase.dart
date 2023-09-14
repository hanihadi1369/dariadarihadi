import 'dart:ffi';

import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart';






class GetBalanceUseCase extends UseCase<DataState<GetBalanceEntity>,String> {
  final WalletRepository walletRepository;


  GetBalanceUseCase(this.walletRepository);

  @override
  Future<DataState<GetBalanceEntity>> call(Void) {
    return walletRepository.getBalanceOperation();
  }

}
