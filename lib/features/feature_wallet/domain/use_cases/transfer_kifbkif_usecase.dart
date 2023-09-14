import '../../../../core/params/transfer_kifbkif_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/transfer_kifbkif_entity.dart';
import '../repository/wallet_repository.dart';


class TransferKifBKifUseCase extends UseCase<DataState<TransferKifBKifEntity>,TransferKifBKifParam> {
  final WalletRepository walletRepository;


  TransferKifBKifUseCase(this.walletRepository);

  @override
  Future<DataState<TransferKifBKifEntity>> call(TransferKifBKifParam transferKifBKifParam) {
    return walletRepository.doTransferKifBKifOperation(transferKifBKifParam.amount,transferKifBKifParam.mobileNumber);
  }

}
