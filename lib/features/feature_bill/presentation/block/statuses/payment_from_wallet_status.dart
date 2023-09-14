
import 'package:atba_application/features/feature_bill/domain/entities/payment_from_wallet_entity.dart';
import 'package:flutter/material.dart';







@immutable
abstract class PaymentFromWalletStatus{}


class PaymentFromWalletInit extends PaymentFromWalletStatus{}

class PaymentFromWalletLoading extends PaymentFromWalletStatus{}

class PaymentFromWalletCompleted extends PaymentFromWalletStatus{
  final PaymentFromWalletEntity paymentFromWalletEntity;
  PaymentFromWalletCompleted(this.paymentFromWalletEntity);
}

class PaymentFromWalletError extends PaymentFromWalletStatus{
  final String message;
  PaymentFromWalletError(this.message);
}