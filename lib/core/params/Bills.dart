class Bills {
  Bills({
    this.billID,
    this.paymentID,
    this.operationCode,

  });


  String? billID;
  String? paymentID;
  int? operationCode;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['operationCode'] = operationCode;
    return map;
  }

}