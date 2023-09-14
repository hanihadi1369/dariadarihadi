

import 'package:flutter/material.dart';

import '../../domain/entities/charge_sim_entity.dart';






@immutable
abstract class ChargeSimStatus{}


class ChargeSimInit extends ChargeSimStatus{}

class ChargeSimLoading extends ChargeSimStatus{}

class ChargeSimCompleted extends ChargeSimStatus{
  final ChargeSimEntity chargeSimEntity;
  ChargeSimCompleted(this.chargeSimEntity);
}

class ChargeSimError extends ChargeSimStatus{
  final String message;
  ChargeSimError(this.message);
}