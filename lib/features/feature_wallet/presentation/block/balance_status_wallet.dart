
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';
import 'package:flutter/material.dart';



@immutable
abstract class BalanceStatus{}


class BalanceInit extends BalanceStatus{}

class BalanceLoading extends BalanceStatus{}

class BalanceCompleted extends BalanceStatus{
  final GetBalanceEntity getBalanceEntity;
  BalanceCompleted(this.getBalanceEntity);
}

class BalanceError extends BalanceStatus{
  final String message;
  BalanceError(this.message);
}