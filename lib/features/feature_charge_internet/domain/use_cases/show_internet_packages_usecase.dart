import 'dart:ffi';










import 'package:atba_application/core/params/charge_sim_param.dart';

import '../../../../core/params/show_internet_packages_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/show_internet_packages_entity.dart';
import '../repository/charge_internet_repository.dart';





class ShowInternetPackagesUseCase extends UseCase<DataState<ShowInternetPackagesEntity>,ShowInternetPackagesParam> {
  final ChargeInternetRepository chargeInternetRepository;


  ShowInternetPackagesUseCase(this.chargeInternetRepository);

  @override
  Future<DataState<ShowInternetPackagesEntity>> call(ShowInternetPackagesParam showInternetPackagesParam) {
    return chargeInternetRepository.showInternetPackagesOperation(
      showInternetPackagesParam.operatorType,
      showInternetPackagesParam.mobile

    );
  }

}
