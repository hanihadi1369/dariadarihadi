
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class MtnBillInquiryStatus extends Equatable{}


class MtnBillInquiryInit extends MtnBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class MtnBillInquiryLoading extends MtnBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class MtnBillInquiryCompleted extends MtnBillInquiryStatus{
  final MtnBillInquiryEntity mtnBillInquiryEntity;
  MtnBillInquiryCompleted(this.mtnBillInquiryEntity);
  @override
  List<Object?> get props => [mtnBillInquiryEntity];
}

class MtnBillInquiryError extends MtnBillInquiryStatus{
  final String message;
  MtnBillInquiryError(this.message);

  @override
  List<Object?> get props => [message];
}