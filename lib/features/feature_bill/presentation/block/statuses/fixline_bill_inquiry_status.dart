
import 'package:atba_application/features/feature_bill/domain/entities/fixline_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class FixLineBillInquiryStatus{}


class FixLineBillInquiryInit extends FixLineBillInquiryStatus{}

class FixLineBillInquiryLoading extends FixLineBillInquiryStatus{}

class FixLineBillInquiryCompleted extends FixLineBillInquiryStatus{
  final FixLineBillInquiryEntity fixLineBillInquiryEntity;
  FixLineBillInquiryCompleted(this.fixLineBillInquiryEntity);
}

class FixLineBillInquiryError extends FixLineBillInquiryStatus{
  final String message;
  FixLineBillInquiryError(this.message);
}