

import 'package:atba_application/features/feature_bill/domain/entities/get_wage_apportions_bill_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';














@immutable
abstract class GetWageApprotionsStatus extends Equatable{}


class GetWageApprotionsInit extends GetWageApprotionsStatus{
  @override
  List<Object?> get props => [];
}

class GetWageApprotionsLoading extends GetWageApprotionsStatus{
  @override
  List<Object?> get props => [];
}

class GetWageApprotionsCompleted extends GetWageApprotionsStatus{
  final GetWageApportionsEntity getWageApportionsEntity;
  GetWageApprotionsCompleted(this.getWageApportionsEntity);

  @override
  List<Object?> get props => [getWageApportionsEntity];
}

class GetWageApprotionsError extends GetWageApprotionsStatus{
  final String message;
  GetWageApprotionsError(this.message);
  @override
  List<Object?> get props => [message];
}