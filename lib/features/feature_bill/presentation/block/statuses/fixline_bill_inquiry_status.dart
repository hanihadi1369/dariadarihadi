
import 'package:atba_application/features/feature_bill/domain/entities/fixline_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class FixLineBillInquiryStatus extends Equatable{}


class FixLineBillInquiryInit extends FixLineBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class FixLineBillInquiryLoading extends FixLineBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class FixLineBillInquiryCompleted extends FixLineBillInquiryStatus{
  final FixLineBillInquiryEntity fixLineBillInquiryEntity;
  FixLineBillInquiryCompleted(this.fixLineBillInquiryEntity);

  @override
  List<Object?> get props => [fixLineBillInquiryEntity];
}

class FixLineBillInquiryError extends FixLineBillInquiryStatus{
  final String message;
  FixLineBillInquiryError(this.message);
  @override
  List<Object?> get props => [message];
}