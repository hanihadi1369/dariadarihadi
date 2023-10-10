

import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class TransactionStatusStatus extends Equatable{}


class TransactionStatusInit extends TransactionStatusStatus{
  @override
  List<Object?> get props => [];
}

class TransactionStatusLoading extends TransactionStatusStatus{
  @override
  List<Object?> get props => [];
}

class TransactionStatusCompleted extends TransactionStatusStatus{
  final TransactionsHistoryEntity transactionsHistoryEntity;
  TransactionStatusCompleted(this.transactionsHistoryEntity);

  @override
  List<Object?> get props => [transactionsHistoryEntity];
}

class TransactionStatusError extends TransactionStatusStatus{
  final String message;
  TransactionStatusError(this.message);

  @override
  List<Object?> get props => [message];
}