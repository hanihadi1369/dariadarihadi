


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/verify_otp_code_entity.dart';

@immutable
abstract class VerifyOtpStatus extends Equatable{}

class VerifyOtpInit extends VerifyOtpStatus{
  @override
  List<Object?> get props => [];
}

class VerifyOtpLoading extends VerifyOtpStatus{
  @override
  List<Object?> get props => [];
}

class VerifyOtpCompleted extends VerifyOtpStatus{
  final VerifyOtpCodeEntity verifyOtpCodeEntity;
  VerifyOtpCompleted(this.verifyOtpCodeEntity);

  @override
  List<Object?> get props => [verifyOtpCodeEntity];
}

class VerifyOtpError extends VerifyOtpStatus{
  final String message;
  VerifyOtpError(this.message);

  @override
  List<Object?> get props => [message];
}