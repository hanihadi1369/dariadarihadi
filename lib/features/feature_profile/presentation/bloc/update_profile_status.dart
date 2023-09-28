
import 'package:atba_application/features/feature_profile/domain/entities/update_profile_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';






@immutable
abstract class UpdateProfileStatus extends Equatable{}


class UpdateProfileInit extends UpdateProfileStatus{
  @override
  List<Object?> get props => [];
}

class UpdateProfileLoading extends UpdateProfileStatus{
  @override
  List<Object?> get props => [];
}

class UpdateProfileCompleted extends UpdateProfileStatus{
  final UpdateProfileEntity updateProfileEntity;
  UpdateProfileCompleted(this.updateProfileEntity);
  @override
  List<Object?> get props => [updateProfileEntity];
}

class UpdateProfileError extends UpdateProfileStatus{
  final String message;
  UpdateProfileError(this.message);
  @override
  List<Object?> get props => [message];
}