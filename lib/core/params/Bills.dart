class Bills {
  Bills({
      this.billID, 
      // this.gatewayID,
      // this.paymentID,
      this.phoneNumber,
      this.operationCode,
      this.isMidTerm
  });

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
  String? operationCode;
  bool? isMidTerm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(billID!=null)
    map['billID'] = billID;
    if(phoneNumber!=null)
    map['phoneNumber'] = phoneNumber;
    // map['gatewayID'] = gatewayID;
    // map['paymentID'] = paymentID;
    map['operationCode'] = operationCode;
    if(isMidTerm!=null)
      map['isMidTerm'] = isMidTerm;
    return map;
  }

}