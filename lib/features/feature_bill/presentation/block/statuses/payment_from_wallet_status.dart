
import 'package:atba_application/features/feature_bill/domain/entities/payment_from_wallet_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class PaymentFromWalletStatus extends Equatable{}


class PaymentFromWalletInit extends PaymentFromWalletStatus{
  @override
  List<Object?> get props => [];
}

class PaymentFromWalletLoading extends PaymentFromWalletStatus{
  @override
  List<Object?> get props => [];
}

class PaymentFromWalletCompleted extends PaymentFromWalletStatus{
  final PaymentFromWalletEntity paymentFromWalletEntity;
  PaymentFromWalletCompleted(this.paymentFromWalletEntity);
  @override
  List<Object?> get props => [paymentFromWalletEntity];
}

class PaymentFromWalletError extends PaymentFromWalletStatus{
  final String message;
  PaymentFromWalletError(this.message);
  @override
  List<Object?> get props => [message];
}