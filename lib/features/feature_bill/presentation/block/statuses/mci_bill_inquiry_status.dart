
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class MciBillInquiryStatus extends Equatable{}


class MciBillInquiryInit extends MciBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class MciBillInquiryLoading extends MciBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class MciBillInquiryCompleted extends MciBillInquiryStatus{
  final MciBillInquiryEntity mciBillInquiryEntity;
  MciBillInquiryCompleted(this.mciBillInquiryEntity);

  @override
  List<Object?> get props => [mciBillInquiryEntity];
}

class MciBillInquiryError extends MciBillInquiryStatus{
  final String message;
  MciBillInquiryError(this.message);

  @override
  List<Object?> get props => [message];
}