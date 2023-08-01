


import 'package:flutter/material.dart';

import '../../domain/entities/verify_otp_code_entity.dart';

@immutable
abstract class VerifyOtpStatus{}

class VerifyOtpInit extends VerifyOtpStatus{}

class VerifyOtpLoading extends VerifyOtpStatus{}

class VerifyOtpCompleted extends VerifyOtpStatus{
  final VerifyOtpCodeEntity verifyOtpCodeEntity;
  VerifyOtpCompleted(this.verifyOtpCodeEntity);
}

class VerifyOtpError extends VerifyOtpStatus{
  final String message;
  VerifyOtpError(this.message);
}