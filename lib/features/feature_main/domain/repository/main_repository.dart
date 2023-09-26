
import '../../../../core/resources/data_state.dart';
import '../entities/get_balance_entity.dart';
import '../entities/get_profile_entity.dart';
import '../entities/refresh_token_entity.dart';


abstract class MainRepository{

  Future<DataState<GetBalanceEntity>> getBalanceOperation();

  Future<DataState<GetProfileEntity>> getProfileOperation();

  Future<DataState<RefreshTokenEntity>> refreshTokenOperation(String refreshToken);


}