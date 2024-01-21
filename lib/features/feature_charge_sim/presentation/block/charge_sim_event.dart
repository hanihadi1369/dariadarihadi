part of 'charge_sim_bloc.dart';



@immutable
abstract class ChargeSimEvent {}




class ChargeEvent extends ChargeSimEvent{
 final ChargeSimParam chargeSimParam;
 ChargeEvent(this.chargeSimParam);
}




class GetBalanceEvent extends ChargeSimEvent{
 GetBalanceEvent();
}


class GetWageApprotionsEvent extends ChargeSimEvent{
 final GetWageApprotionsParam getWageApprotionsParam;
 GetWageApprotionsEvent(this.getWageApprotionsParam);
}
