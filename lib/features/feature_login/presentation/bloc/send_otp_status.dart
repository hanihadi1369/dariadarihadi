import 'package:flutter/material.dart';

import '../../domain/entities/send_otp_code_entity.dart';

@immutable
abstract class SendOtpStatus{}


class SendOtpInit extends SendOtpStatus{}

class SendOtpLoading extends SendOtpStatus{}

class SendOtpCompleted extends SendOtpStatus{
  final SendOtpCodeEntity sendOtpCodeEntity;
  SendOtpCompleted(this.sendOtpCodeEntity);
}

class SendOtpError extends SendOtpStatus{
  final String message;
  SendOtpError(this.message);
}