import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



@immutable
abstract class BalanceStatus extends Equatable{}


class BalanceInit extends BalanceStatus{
  @override
  List<Object?> get props => [];
}

class BalanceLoading extends BalanceStatus{
  @override
  List<Object?> get props => [];
}

class BalanceCompleted extends BalanceStatus{
  final GetBalanceEntity getBalanceEntity;
  BalanceCompleted(this.getBalanceEntity);


  @override
  List<Object?> get props => [getBalanceEntity];
}

class BalanceError extends BalanceStatus{
  final String message;
  BalanceError(this.message);

  @override
  List<Object?> get props => [message];
}