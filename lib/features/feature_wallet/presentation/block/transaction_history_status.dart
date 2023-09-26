

import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class TransactionsHistoryStatus extends Equatable{}


class TransactionsHistoryInit extends TransactionsHistoryStatus{
  @override
  List<Object?> get props => [];
}

class TransactionsHistoryLoading extends TransactionsHistoryStatus{
  @override
  List<Object?> get props => [];
}

class TransactionsHistoryCompleted extends TransactionsHistoryStatus{
  final TransactionsHistoryEntity transactionsHistoryEntity;
  TransactionsHistoryCompleted(this.transactionsHistoryEntity);

  @override
  List<Object?> get props => [transactionsHistoryEntity];
}

class TransactionsHistoryError extends TransactionsHistoryStatus{
  final String message;
  TransactionsHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}