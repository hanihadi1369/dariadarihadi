import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/get_profile_entity.dart';



@immutable
abstract class ProfileStatus extends Equatable{}


class ProfileInit extends ProfileStatus{
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileStatus{
  @override
  List<Object?> get props => [];
}

class ProfileCompleted extends ProfileStatus{
  final GetProfileEntity getProfileEntity;
  ProfileCompleted(this.getProfileEntity);
  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileStatus{
  final String message;
  ProfileError(this.message);
  @override
  List<Object?> get props => [];
}