import 'package:equatable/equatable.dart';


import 'package:atba_application/features/feature_charge_sim/data/models/charge_sim_model.dart';


class ChargeSimEntity extends Equatable {
  final bool? isFailed;
  final bool? isSuccess;
  final List<Reasons>? reasons;
  final List<Errors>? errors;
  final List<Successes>? successes;
  final ValueOrDefault? valueOrDefault;
  final Value? value;

  ChargeSimEntity(
      {this.isFailed,
      this.isSuccess,
      this.reasons,
      this.errors,
      this.successes,
      this.valueOrDefault,
      this.value});

  @override
  List<Object?> get props => [
        isFailed,
        isSuccess,
        reasons,
        errors,
        successes,
        valueOrDefault,
        value,
      ];
}
