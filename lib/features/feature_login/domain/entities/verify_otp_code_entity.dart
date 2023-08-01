import 'package:atba_application/features/feature_login/data/models/send_otp_code_model.dart';
import 'package:atba_application/features/feature_login/data/models/verify_otp_code_model.dart' as verify;
import 'package:equatable/equatable.dart';


class VerifyOtpCodeEntity extends Equatable{

  bool? isFailed;
  bool? isSuccess;
  List<Reasons>? reasons;
  List<Errors>? errors;
  List<Successes>? successes;
  verify.ValueOrDefault? valueOrDefault;
  verify.Value? value;


  VerifyOtpCodeEntity({this.isFailed, this.isSuccess, this.reasons, this.errors,
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