import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/get_profile_entity.dart';



@immutable
abstract class ProfileStatus{}


class ProfileInit extends ProfileStatus{}

class ProfileLoading extends ProfileStatus{}

class ProfileCompleted extends ProfileStatus{
  final GetProfileEntity getProfileEntity;
  ProfileCompleted(this.getProfileEntity);
}

class ProfileError extends ProfileStatus{
  final String message;
  ProfileError(this.message);
}