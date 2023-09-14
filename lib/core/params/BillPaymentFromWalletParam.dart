import 'Bills.dart';

class BillPaymentFromWalletParam {
  BillPaymentFromWalletParam({
      required this.bills,});


  List<Bills> bills;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bills != null) {
      map['bills'] = bills.map((v) => v.toJson()).toList();
    }
    return map;
  }

}