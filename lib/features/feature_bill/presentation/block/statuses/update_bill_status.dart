
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class UpdateBillStatus extends Equatable{}


class UpdateBillInit extends UpdateBillStatus{
  @override
  List<Object?> get props => [];
}

class UpdateBillLoading extends UpdateBillStatus{
  @override
  List<Object?> get props => [];
}

class UpdateBillCompleted extends UpdateBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  UpdateBillCompleted(this.generalResponseEntity);
  @override
  List<Object?> get props => [generalResponseEntity];
}

class UpdateBillError extends UpdateBillStatus{
  final String message;
  UpdateBillError(this.message);
  @override
  List<Object?> get props => [message];
}