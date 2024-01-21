// flutter packages pub run build_runner build

import 'package:hive/hive.dart';
part 'sim_charge_transaction.g.dart';

@HiveType(typeId: 0)
class SimChargeTransaction extends HiveObject{
  @HiveField(0)
  final String? phoneNumber;
  @HiveField(1)
  final int? operatorType;
  @HiveField(2)
  final int? simCardType;
  @HiveField(3)
  final int? chargeAmountType;
  @HiveField(4)
  final int? paymentType;


  SimChargeTransaction({this.phoneNumber, this.operatorType,this.simCardType,this.chargeAmountType,this.paymentType});
}