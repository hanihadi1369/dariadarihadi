
import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';







@immutable
abstract class BarghBillInquiryStatus extends Equatable{}


class BarghBillInquiryInit extends BarghBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class BarghBillInquiryLoading extends BarghBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class BarghBillInquiryCompleted extends BarghBillInquiryStatus{
  final BarghBillInquiryEntity barghBillInquiryEntity;
  BarghBillInquiryCompleted(this.barghBillInquiryEntity);

  @override
  List<Object?> get props => [barghBillInquiryEntity];
}

class BarghBillInquiryError extends BarghBillInquiryStatus{
  final String message;
  BarghBillInquiryError(this.message);

  @override
  List<Object?> get props => [message];
}