

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/buy_internet_package_entity.dart';








@immutable
abstract class BuyInternetPackageStatus extends Equatable{}


class BuyInternetPackageInit extends BuyInternetPackageStatus{
  @override
  List<Object?> get props => [];
}

class BuyInternetPackageLoading extends BuyInternetPackageStatus{
  @override
  List<Object?> get props => [];
}

class BuyInternetPackageCompleted extends BuyInternetPackageStatus{
  final BuyInternetPackageEntity buyInternetPackageEntity;
  BuyInternetPackageCompleted(this.buyInternetPackageEntity);

  @override
  List<Object?> get props => [buyInternetPackageEntity];
}

class BuyInternetPackageError extends BuyInternetPackageStatus{
  final String message;
  BuyInternetPackageError(this.message);
  @override
  List<Object?> get props => [message];
}