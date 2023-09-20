import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/send_otp_code_entity.dart';

@immutable
abstract class SendOtpStatus extends Equatable{}


class SendOtpInit extends SendOtpStatus{
  @override
  List<Object?> get props => [];
}

class SendOtpLoading extends SendOtpStatus{
  @override
  List<Object?> get props => [];
}

class SendOtpCompleted extends SendOtpStatus{
  final SendOtpCodeEntity sendOtpCodeEntity;
  SendOtpCompleted(this.sendOtpCodeEntity);

  @override
  List<Object?> get props => [sendOtpCodeEntity];
}

class SendOtpError extends SendOtpStatus{
  final String message;
  SendOtpError(this.message);
  @override
  List<Object?> get props => [message];
}