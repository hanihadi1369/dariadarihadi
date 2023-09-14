
import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class WaterBillInquiryStatus{}


class WaterBillInquiryInit extends WaterBillInquiryStatus{}

class WaterBillInquiryLoading extends WaterBillInquiryStatus{}

class WaterBillInquiryCompleted extends WaterBillInquiryStatus{
  final WaterBillInquiryEntity waterBillInquiryEntity;
  WaterBillInquiryCompleted(this.waterBillInquiryEntity);
}

class WaterBillInquiryError extends WaterBillInquiryStatus{
  final String message;
  WaterBillInquiryError(this.message);
}