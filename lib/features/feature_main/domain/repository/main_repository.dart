
import '../../../../core/resources/data_state.dart';
import '../entities/get_balance_entity.dart';
import '../entities/get_profile_entity.dart';


abstract class MainRepository{

  Future<DataState<GetBalanceEntity>> getBalanceOperation();

  Future<DataState<GetProfileEntity>> getProfileOperation();


}