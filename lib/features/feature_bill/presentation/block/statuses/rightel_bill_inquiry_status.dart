

import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class RightelBillInquiryStatus extends Equatable{}


class RightelBillInquiryInit extends RightelBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class RightelBillInquiryLoading extends RightelBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class RightelBillInquiryCompleted extends RightelBillInquiryStatus{
  final RightelBillInquiryEntity rightelBillInquiryEntity;
  RightelBillInquiryCompleted(this.rightelBillInquiryEntity);
  @override
  List<Object?> get props => [rightelBillInquiryEntity];
}

class RightelBillInquiryError extends RightelBillInquiryStatus{
  final String message;
  RightelBillInquiryError(this.message);
  @override
  List<Object?> get props => [message];
}