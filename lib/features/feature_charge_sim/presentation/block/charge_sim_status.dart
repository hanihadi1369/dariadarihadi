

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/charge_sim_entity.dart';






@immutable
abstract class ChargeSimStatus extends Equatable{}


class ChargeSimInit extends ChargeSimStatus{
  @override
  List<Object?> get props => [];
}

class ChargeSimLoading extends ChargeSimStatus{
  @override
  List<Object?> get props => [];
}

class ChargeSimCompleted extends ChargeSimStatus{
  final ChargeSimEntity chargeSimEntity;
  ChargeSimCompleted(this.chargeSimEntity);

  @override
  List<Object?> get props => [chargeSimEntity];
}

class ChargeSimError extends ChargeSimStatus{
  final String message;
  ChargeSimError(this.message);
  @override
  List<Object?> get props => [message];
}