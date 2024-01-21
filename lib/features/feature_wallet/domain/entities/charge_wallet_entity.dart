import 'package:equatable/equatable.dart';

import '../../data/models/charge_wallet_model.dart';



class ChargeWalletEntity extends Equatable {
      final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final Data? data;
  final List<ValidationError>? validationErrors;
  final int? errorCode;

  ChargeWalletEntity(
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
