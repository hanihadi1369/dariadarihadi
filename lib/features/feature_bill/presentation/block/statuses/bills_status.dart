
import 'package:flutter/material.dart';

import '../../../domain/entities/get_bills_entity.dart';



@immutable
abstract class BillsStatus{}


class BillsInit extends BillsStatus{}

class BillsLoading extends BillsStatus{}

class BillsCompleted extends BillsStatus{
  final GetBillsEntity getBillsEntity;
  BillsCompleted(this.getBillsEntity);
}

class BillsError extends BillsStatus{
  final String message;
  BillsError(this.message);
}