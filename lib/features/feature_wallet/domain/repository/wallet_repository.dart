


import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart';

abstract class WalletRepository{


  Future<DataState<ChargeWalletEntity>> doChargeWalletOperation(int  amount,String redirectedUrl);
  Future<DataState<GetBalanceEntity>> getBalanceOperation();
  Future<DataState<TransferKifBKifEntity>> doTransferKifBKifOperation(int  amount,String mobileNumber);


}