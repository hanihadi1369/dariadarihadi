import 'dart:ffi';










import 'package:atba_application/core/params/charge_sim_param.dart';

import '../../../../core/params/buy_internet_package_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/buy_internet_package_entity.dart';
import '../repository/charge_internet_repository.dart';





class BuyInternetPackageUseCase extends UseCase<DataState<BuyInternetPackageEntity>,BuyInternetPackageParam> {
  final ChargeInternetRepository chargeInternetRepository;


  BuyInternetPackageUseCase(this.chargeInternetRepository);

  @override
  Future<DataState<BuyInternetPackageEntity>> call(BuyInternetPackageParam buyInternetPackageParam) {
    return chargeInternetRepository.buyInternetPackageOperation(
        buyInternetPackageParam.bundleId,
        buyInternetPackageParam.amount,
        buyInternetPackageParam.cellNumber,
        buyInternetPackageParam.requestId,
        buyInternetPackageParam.operatorType,
        buyInternetPackageParam.operationCode,
        buyInternetPackageParam.type


    );
  }

}
