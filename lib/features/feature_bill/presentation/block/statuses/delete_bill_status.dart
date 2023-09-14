
import 'package:flutter/material.dart';

import '../../../../../core/general/general_response_entity.dart';





@immutable
abstract class DeleteBillStatus{}


class DeleteBillInit extends DeleteBillStatus{}

class DeleteBillLoading extends DeleteBillStatus{}

class DeleteBillCompleted extends DeleteBillStatus{
  final GeneralResponseEntity generalResponseEntity;
  DeleteBillCompleted(this.generalResponseEntity);
}

class DeleteBillError extends DeleteBillStatus{
  final String message;
  DeleteBillError(this.message);
}