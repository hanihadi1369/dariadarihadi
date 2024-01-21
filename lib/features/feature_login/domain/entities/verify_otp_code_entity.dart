import 'package:atba_application/features/feature_login/data/models/verify_otp_code_model.dart';
import 'package:equatable/equatable.dart';

class VerifyOtpCodeEntity extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final Data? data;
  final List<ValidationError>? validationErrors;
  final int? errorCode;

  VerifyOtpCodeEntity(
      {this.statusCode,
        this.isSuccess,
        this.message,
        this.messageEn,
        this.data,
        this.validationErrors,
        this.errorCode});

  @override
  List<Object?> get props => [
    statusCode,
    isSuccess,
    message,
    messageEn,
    data,
    validationErrors,
    errorCode,
      ];
}
