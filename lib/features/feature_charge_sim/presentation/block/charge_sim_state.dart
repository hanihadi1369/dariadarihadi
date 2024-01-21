part of 'charge_sim_bloc.dart';

class ChargeSimState extends Equatable {
  ChargeSimStatus chargeSimStatus;
  BalanceStatus balanceStatus;
  GetWageApprotionsStatus getWageApprotionsStatus;

  ChargeSimState(
      {required this.chargeSimStatus,
      required this.balanceStatus,
      required this.getWageApprotionsStatus});

  @override
  List<Object?> get props =>
      [chargeSimStatus, balanceStatus, getWageApprotionsStatus];

  ChargeSimState copyWith(
      {ChargeSimStatus? newChargeSimStatus,
      BalanceStatus? newBalanceStatus,
      GetWageApprotionsStatus? newGetWageApprotionsStatus}) {
    return ChargeSimState(
        chargeSimStatus: newChargeSimStatus ?? this.chargeSimStatus,
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        getWageApprotionsStatus:
            newGetWageApprotionsStatus ?? this.getWageApprotionsStatus);
  }
}
