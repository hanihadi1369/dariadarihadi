
import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class WaterBillInquiryStatus extends Equatable{}


class WaterBillInquiryInit extends WaterBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class WaterBillInquiryLoading extends WaterBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class WaterBillInquiryCompleted extends WaterBillInquiryStatus{
  final WaterBillInquiryEntity waterBillInquiryEntity;
  WaterBillInquiryCompleted(this.waterBillInquiryEntity);

  @override
  List<Object?> get props => [waterBillInquiryEntity];
}

class WaterBillInquiryError extends WaterBillInquiryStatus{
  final String message;
  WaterBillInquiryError(this.message);

  @override
  List<Object?> get props => [message];
}