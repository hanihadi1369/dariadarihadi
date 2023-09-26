
import 'package:atba_application/features/feature_main/domain/entities/refresh_token_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



@immutable
abstract class RefreshTokenStatus extends Equatable{}


class RefreshTokenInit extends RefreshTokenStatus{
  @override
  List<Object?> get props => [];
}

class RefreshTokenLoading extends RefreshTokenStatus{
  @override
  List<Object?> get props => [];
}

class RefreshTokenCompleted extends RefreshTokenStatus{
  final RefreshTokenEntity refreshTokenEntity;
  RefreshTokenCompleted(this.refreshTokenEntity);


  @override
  List<Object?> get props => [refreshTokenEntity];
}

class RefreshTokenError extends RefreshTokenStatus{
  final String message;
  RefreshTokenError(this.message);

  @override
  List<Object?> get props => [message];
}