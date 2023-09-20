
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class CreateBillStatus extends Equatable{}


class CreateBillInit extends CreateBillStatus{
  @override
  List<Object?> get props => [];
}

class CreateBillLoading extends CreateBillStatus{
  @override
  List<Object?> get props => [];
}

class CreateBillCompleted extends CreateBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  CreateBillCompleted(this.generalResponseEntity);
  @override
  List<Object?> get props => [generalResponseEntity];
}

class CreateBillError extends CreateBillStatus{
  final String message;
  CreateBillError(this.message);
  @override
  List<Object?> get props => [message];
}