




import '../../../../core/resources/data_state.dart';
import '../entities/buy_internet_package_entity.dart';
import '../entities/get_balance_entity_cinternet.dart';
import '../entities/show_internet_packages_entity.dart';




abstract class ChargeInternetRepository{




  Future<DataState<ShowInternetPackagesEntity>> showInternetPackagesOperation(int operatorType, String mobile);
  Future<DataState<BuyInternetPackageEntity>> buyInternetPackageOperation(
      String bundleId,
      String amount,
      String cellNumber,
      String requestId,
      int operatorType,
      int operationCode,
      int type,

      );
  Future<DataState<GetBalanceEntity>> getBalanceOperation();

}