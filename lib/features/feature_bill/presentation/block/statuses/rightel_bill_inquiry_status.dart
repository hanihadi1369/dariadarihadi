

import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class RightelBillInquiryStatus{}


class RightelBillInquiryInit extends RightelBillInquiryStatus{}

class RightelBillInquiryLoading extends RightelBillInquiryStatus{}

class RightelBillInquiryCompleted extends RightelBillInquiryStatus{
  final RightelBillInquiryEntity rightelBillInquiryEntity;
  RightelBillInquiryCompleted(this.rightelBillInquiryEntity);
}

class RightelBillInquiryError extends RightelBillInquiryStatus{
  final String message;
  RightelBillInquiryError(this.message);
}