
import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';
import 'package:flutter/material.dart';






@immutable
abstract class GasBillInquiryStatus{}


class GasBillInquiryInit extends GasBillInquiryStatus{}

class GasBillInquiryLoading extends GasBillInquiryStatus{}

class GasBillInquiryCompleted extends GasBillInquiryStatus{
  final GasBillInquiryEntity gasBillInquiryEntity;
  GasBillInquiryCompleted(this.gasBillInquiryEntity);
}

class GasBillInquiryError extends GasBillInquiryStatus{
  final String message;
  GasBillInquiryError(this.message);
}