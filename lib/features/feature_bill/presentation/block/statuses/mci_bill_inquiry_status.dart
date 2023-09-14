
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class MciBillInquiryStatus{}


class MciBillInquiryInit extends MciBillInquiryStatus{}

class MciBillInquiryLoading extends MciBillInquiryStatus{}

class MciBillInquiryCompleted extends MciBillInquiryStatus{
  final MciBillInquiryEntity mciBillInquiryEntity;
  MciBillInquiryCompleted(this.mciBillInquiryEntity);
}

class MciBillInquiryError extends MciBillInquiryStatus{
  final String message;
  MciBillInquiryError(this.message);
}