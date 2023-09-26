
import 'package:equatable/equatable.dart';

import '../../../../core/general/general_response_model.dart';
import 'package:atba_application/features/feature_main/data/models/refresh_token_model.dart';


class RefreshTokenEntity extends Equatable{

  bool? isFailed;
  bool? isSuccess;
  List<Reasons>? reasons;
  List<Errors>? errors;
  List<Successes>? successes;
  ValueOrDefault? valueOrDefault;
  Value? value;


  RefreshTokenEntity({this.isFailed, this.isSuccess, this.reasons, this.errors,
    this.successes, this.valueOrDefault, this.value});

  @override
  List<Object?> get props =>[
    isFailed,
    isSuccess,
    reasons,
    errors,
    successes,
    valueOrDefault,
    value,
  ];

}