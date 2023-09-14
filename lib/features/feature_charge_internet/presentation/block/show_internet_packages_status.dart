

import 'package:flutter/material.dart';

import '../../domain/entities/show_internet_packages_entity.dart';








@immutable
abstract class ShowInternetPackagesStatus{}


class ShowInternetPackagesInit extends ShowInternetPackagesStatus{}

class ShowInternetPackagesLoading extends ShowInternetPackagesStatus{}

class ShowInternetPackagesCompleted extends ShowInternetPackagesStatus{
  final ShowInternetPackagesEntity showInternetPackagesEntity;
  ShowInternetPackagesCompleted(this.showInternetPackagesEntity);
}

class ShowInternetPackagesError extends ShowInternetPackagesStatus{
  final String message;
  ShowInternetPackagesError(this.message);
}