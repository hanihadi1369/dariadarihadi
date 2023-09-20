
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class DeleteBillStatus extends Equatable{}


class DeleteBillInit extends DeleteBillStatus{
  @override
  List<Object?> get props => [];
}

class DeleteBillLoading extends DeleteBillStatus{
  @override
  List<Object?> get props => [];
}

class DeleteBillCompleted extends DeleteBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  DeleteBillCompleted(this.generalResponseEntity);
  @override
  List<Object?> get props => [generalResponseEntity];
}

class DeleteBillError extends DeleteBillStatus{
  final String message;
  DeleteBillError(this.message);
  @override
  List<Object?> get props => [message];
}