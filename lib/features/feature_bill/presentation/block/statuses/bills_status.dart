
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/get_bills_entity.dart';



@immutable
abstract class BillsStatus extends Equatable{}


class BillsInit extends BillsStatus{
  @override
  List<Object?> get props => [];
}

class BillsLoading extends BillsStatus{
  @override
  List<Object?> get props => [];
}

class BillsCompleted extends BillsStatus{
  final GetBillsEntity getBillsEntity;
  BillsCompleted(this.getBillsEntity);

  @override
  List<Object?> get props => [getBillsEntity];
}

class BillsError extends BillsStatus{
  final String message;
  BillsError(this.message);
  @override
  List<Object?> get props => [message];
}