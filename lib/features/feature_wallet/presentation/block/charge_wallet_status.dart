import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class ChargeWalletStatus extends Equatable{}


class ChargeWalletInit extends ChargeWalletStatus{
  @override
  List<Object?> get props => [];
}

class ChargeWalletLoading extends ChargeWalletStatus{
  @override
  List<Object?> get props => [];
}

class ChargeWalletCompleted extends ChargeWalletStatus{
  final ChargeWalletEntity chargeWalletEntity;
  ChargeWalletCompleted(this.chargeWalletEntity);

  @override
  List<Object?> get props => [chargeWalletEntity];
}

class ChargeWalletError extends ChargeWalletStatus{
  final String message;
  ChargeWalletError(this.message);

  @override
  List<Object?> get props => [message];
}