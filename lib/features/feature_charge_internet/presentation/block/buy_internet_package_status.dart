

import 'package:flutter/material.dart';

import '../../domain/entities/buy_internet_package_entity.dart';








@immutable
abstract class BuyInternetPackageStatus{}


class BuyInternetPackageInit extends BuyInternetPackageStatus{}

class BuyInternetPackageLoading extends BuyInternetPackageStatus{}

class BuyInternetPackageCompleted extends BuyInternetPackageStatus{
  final BuyInternetPackageEntity buyInternetPackageEntity;
  BuyInternetPackageCompleted(this.buyInternetPackageEntity);
}

class BuyInternetPackageError extends BuyInternetPackageStatus{
  final String message;
  BuyInternetPackageError(this.message);
}