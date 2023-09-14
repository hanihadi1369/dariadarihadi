
import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';







@immutable
abstract class BarghBillInquiryStatus{}


class BarghBillInquiryInit extends BarghBillInquiryStatus{}

class BarghBillInquiryLoading extends BarghBillInquiryStatus{}

class BarghBillInquiryCompleted extends BarghBillInquiryStatus{
  final BarghBillInquiryEntity barghBillInquiryEntity;
  BarghBillInquiryCompleted(this.barghBillInquiryEntity);
}

class BarghBillInquiryError extends BarghBillInquiryStatus{
  final String message;
  BarghBillInquiryError(this.message);
}