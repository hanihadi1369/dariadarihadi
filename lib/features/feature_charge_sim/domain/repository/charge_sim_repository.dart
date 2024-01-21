
import 'package:atba_application/core/general/general_response_entity.dart';
import 'package:atba_application/features/feature_charge_sim/domain/entities/charge_sim_entity.dart';


import '../../../../core/resources/data_state.dart';
import '../entities/get_balance_entity_csim.dart';
import '../entities/get_wage_apportions_csim_entity.dart';




abstract class ChargeSimRepository{

  Future<DataState<ChargeSimEntity>> chargeSimOperation(int totalAmount, String cellNumber,int operatorType, int simCardType);

  Future<DataState<GetBalanceEntity>> getBalanceOperation();


  Future<DataState<GetWageApportionsEntity>> getWageApportionsOperation(int operationCode, int  amount);

}