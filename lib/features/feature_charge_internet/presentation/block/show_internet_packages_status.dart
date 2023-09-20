

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/show_internet_packages_entity.dart';








@immutable
abstract class ShowInternetPackagesStatus extends Equatable{}


class ShowInternetPackagesInit extends ShowInternetPackagesStatus{
  @override
  List<Object?> get props => [];
}

class ShowInternetPackagesLoading extends ShowInternetPackagesStatus{
  @override
  List<Object?> get props => [];
}

class ShowInternetPackagesCompleted extends ShowInternetPackagesStatus{
  final ShowInternetPackagesEntity showInternetPackagesEntity;
  ShowInternetPackagesCompleted(this.showInternetPackagesEntity);

  @override
  List<Object?> get props => [showInternetPackagesEntity];
}

class ShowInternetPackagesError extends ShowInternetPackagesStatus{
  final String message;
  ShowInternetPackagesError(this.message);
  @override
  List<Object?> get props => [message];
}