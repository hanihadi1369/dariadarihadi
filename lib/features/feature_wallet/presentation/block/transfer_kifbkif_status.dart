
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart';
import 'package:flutter/material.dart';







@immutable
abstract class TransferKifBKifStatus{}


class TransferKifBKifInit extends TransferKifBKifStatus{}

class TransferKifBKifLoading extends TransferKifBKifStatus{}

class TransferKifBKifCompleted extends TransferKifBKifStatus{
  final TransferKifBKifEntity transferKifBKifEntity;
  TransferKifBKifCompleted(this.transferKifBKifEntity);
}

class TransferKifBKifError extends TransferKifBKifStatus{
  final String message;
  TransferKifBKifError(this.message);
}