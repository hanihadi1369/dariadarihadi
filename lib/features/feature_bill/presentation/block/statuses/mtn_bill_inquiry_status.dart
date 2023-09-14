
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class MtnBillInquiryStatus{}


class MtnBillInquiryInit extends MtnBillInquiryStatus{}

class MtnBillInquiryLoading extends MtnBillInquiryStatus{}

class MtnBillInquiryCompleted extends MtnBillInquiryStatus{
  final MtnBillInquiryEntity mtnBillInquiryEntity;
  MtnBillInquiryCompleted(this.mtnBillInquiryEntity);
}

class MtnBillInquiryError extends MtnBillInquiryStatus{
  final String message;
  MtnBillInquiryError(this.message);
}