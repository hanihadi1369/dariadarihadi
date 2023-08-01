
import '../../../../core/resources/data_state.dart';
import '../entities/get_balance_entity.dart';


abstract class MainRepository{

  Future<DataState<GetBalanceEntity>> getBalanceOperation();




}