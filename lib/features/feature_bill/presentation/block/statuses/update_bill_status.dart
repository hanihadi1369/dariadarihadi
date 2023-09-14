
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class UpdateBillStatus{}


class UpdateBillInit extends UpdateBillStatus{}

class UpdateBillLoading extends UpdateBillStatus{}

class UpdateBillCompleted extends UpdateBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  UpdateBillCompleted(this.generalResponseEntity);
}

class UpdateBillError extends UpdateBillStatus{
  final String message;
  UpdateBillError(this.message);
}