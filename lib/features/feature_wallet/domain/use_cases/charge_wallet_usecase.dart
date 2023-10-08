import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/charge_wallet_entity.dart';
import '../repository/wallet_repository.dart';


class ChargeWalletUseCase extends UseCase<DataState<ChargeWalletEntity>,int> {
  final WalletRepository walletRepository;


  ChargeWalletUseCase(this.walletRepository);

  @override
  Future<DataState<ChargeWalletEntity>> call(int amount) {
    return walletRepository.doChargeWalletOperation(amount,"");


  }

}
