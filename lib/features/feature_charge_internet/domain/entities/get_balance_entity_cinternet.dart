import 'package:equatable/equatable.dart';

import 'package:atba_application/features/feature_charge_internet/data/models/get_balance_model_cinternet.dart';





class GetBalanceEntity extends Equatable {
  final bool? isFailed;
  final bool? isSuccess;
  final List<Reasons>? reasons;
  final List<Errors>? errors;
  final List<Successes>? successes;
  final List<ValueOrDefault>? valueOrDefault;
  final List<Value>? value;

  GetBalanceEntity(
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
