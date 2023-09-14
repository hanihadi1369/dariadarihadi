class BuyInternetPackageParam{

  String bundleId;
  String amount;
  String cellNumber;
  String requestId;
  int operatorType;
  int operationCode;
  int type;



  BuyInternetPackageParam({
    required this.bundleId,
    required this.amount,
    required this.cellNumber,
    required this.requestId,
    required this.operatorType,
    required this.operationCode,
    required this.type
  });
}