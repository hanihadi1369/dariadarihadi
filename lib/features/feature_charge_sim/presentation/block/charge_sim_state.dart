part of 'charge_sim_bloc.dart';

class ChargeSimState {
  ChargeSimStatus chargeSimStatus;
  BalanceStatus balanceStatus;

  ChargeSimState({
    required this.chargeSimStatus,
    required this.balanceStatus,

  });

  ChargeSimState copyWith({
    ChargeSimStatus? newChargeSimStatus,
    BalanceStatus? newBalanceStatus,
  }) {
    return ChargeSimState(
      chargeSimStatus: newChargeSimStatus ?? this.chargeSimStatus,
      balanceStatus: newBalanceStatus ?? this.balanceStatus,

    );
  }
}
