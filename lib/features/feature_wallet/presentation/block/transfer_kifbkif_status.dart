
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class TransferKifBKifStatus extends Equatable{}


class TransferKifBKifInit extends TransferKifBKifStatus{
  @override
  List<Object?> get props => [];
}

class TransferKifBKifLoading extends TransferKifBKifStatus{
  @override
  List<Object?> get props => [];
}

class TransferKifBKifCompleted extends TransferKifBKifStatus{
  final TransferKifBKifEntity transferKifBKifEntity;
  TransferKifBKifCompleted(this.transferKifBKifEntity);

  @override
  List<Object?> get props => [transferKifBKifEntity];
}

class TransferKifBKifError extends TransferKifBKifStatus{
  final String message;
  TransferKifBKifError(this.message);

  @override
  List<Object?> get props => [message];
}