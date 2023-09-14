
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class CreateBillStatus{}


class CreateBillInit extends CreateBillStatus{}

class CreateBillLoading extends CreateBillStatus{}

class CreateBillCompleted extends CreateBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  CreateBillCompleted(this.generalResponseEntity);
}

class CreateBillError extends CreateBillStatus{
  final String message;
  CreateBillError(this.message);
}