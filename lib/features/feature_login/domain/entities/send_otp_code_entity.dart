import 'package:equatable/equatable.dart';

import '../../data/models/send_otp_code_model.dart';

class SendOtpCodeEntity extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final Data? data;
  final List<ValidationError>? validationErrors;
  final int? errorCode;

  SendOtpCodeEntity(
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
