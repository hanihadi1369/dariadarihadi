// flutter packages pub run build_runner build

import 'package:hive/hive.dart';
part 'internet_package_transaction.g.dart';


@HiveType(typeId: 1)
class InternetPackageTransaction extends HiveObject{
  @HiveField(0)
  final String? phoneNumber;
  @HiveField(1)
  final int? operatorType;
  @HiveField(2)
  final int? simCardType;
  @HiveField(3)
  final String? bundleID;
  @HiveField(4)
  final String? bundleName;
  @HiveField(5)
  final int? paymentType;


  InternetPackageTransaction({this.phoneNumber, this.operatorType,this.simCardType,this.bundleID,this.bundleName,this.paymentType});
}