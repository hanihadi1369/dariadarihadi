class Bills {
  Bills({
      this.billID, 
      // this.gatewayID,
      // this.paymentID,
      this.phoneNumber,
      this.operationCode,});

  Bills.fromJson(dynamic json) {
    billID = json['billID'];
    // gatewayID = json['gatewayID'];
    // paymentID = json['paymentID'];
    phoneNumber = json['phoneNumber'];
    operationCode = json['operationCode'];
  }
  String? billID;
  // String? gatewayID;
  String? phoneNumber;
  // String? paymentID;
  int? operationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billID'] = billID;
    map['phoneNumber'] = phoneNumber;
    // map['gatewayID'] = gatewayID;
    // map['paymentID'] = paymentID;
    map['operationCode'] = operationCode;
    return map;
  }

}