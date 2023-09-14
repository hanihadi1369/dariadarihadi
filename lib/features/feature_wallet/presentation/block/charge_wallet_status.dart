import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart';
import 'package:flutter/material.dart';







@immutable
abstract class ChargeWalletStatus{}


class ChargeWalletInit extends ChargeWalletStatus{}

class ChargeWalletLoading extends ChargeWalletStatus{}

class ChargeWalletCompleted extends ChargeWalletStatus{
  final ChargeWalletEntity chargeWalletEntity;
  ChargeWalletCompleted(this.chargeWalletEntity);
}

class ChargeWalletError extends ChargeWalletStatus{
  final String message;
  ChargeWalletError(this.message);
}