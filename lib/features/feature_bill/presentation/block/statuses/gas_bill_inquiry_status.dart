
import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class GasBillInquiryStatus extends Equatable{}


class GasBillInquiryInit extends GasBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class GasBillInquiryLoading extends GasBillInquiryStatus{
  @override
  List<Object?> get props => [];
}

class GasBillInquiryCompleted extends GasBillInquiryStatus{
  final GasBillInquiryEntity gasBillInquiryEntity;
  GasBillInquiryCompleted(this.gasBillInquiryEntity);

  @override
  List<Object?> get props => [gasBillInquiryEntity];
}

class GasBillInquiryError extends GasBillInquiryStatus{
  final String message;
  GasBillInquiryError(this.message);
  @override
  List<Object?> get props => [message];
}