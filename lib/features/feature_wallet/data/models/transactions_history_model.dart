







import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';

class TransactionsHistoryModel extends TransactionsHistoryEntity {


  TransactionsHistoryModel({
    int? statusCode,
    bool? isSuccess,
    String? message,
    String? messageEn,
    Data? data,
    List<ValidationError>? validationErrors,
    int? errorCode

  }):super(
    statusCode : statusCode,
    isSuccess: isSuccess,
    message: message,
    messageEn: messageEn,
    data: data,
    validationErrors: validationErrors,
    errorCode: errorCode

  );

  factory TransactionsHistoryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }







    return TransactionsHistoryModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      message: json['message'],
      messageEn: json['messageEn'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      validationErrors: validationErrors,
      errorCode: json['errorCode'],

    );
  }



}



class ValidationError {
  ValidationError({
    this.propertyName,
    this.errors,
  });

  ValidationError.fromJson(dynamic json) {
    propertyName = json['propertyName'];
    errors = json['errors'] != null ? json['errors'].cast<String>() : [];
  }

  String? propertyName;
  List<String>? errors;

}






class Data {
  Data({
    this.statement,
    this.transactionCount,});

  Data.fromJson(dynamic json) {
    if (json['statement'] != null) {
      statement = [];
      json['statement'].forEach((v) {
        statement!.add(Statement.fromJson(v));
      });
    }
    transactionCount = json['transactionCount'];
  }
  List<Statement>? statement;
  int? transactionCount;


}




class Statement {




  Statement({
    this.date,
    this.clock,
    this.sumBedeAmount,
    this.sumBesAmount,
    this.operationName,
    this.operationCode,
    this.detailsCount,
    this.serialNumber,
    this.mobile,
   });






  Statement.fromJson(dynamic json) {

    date = json['date'];
    clock = json['clock'];
    sumBedeAmount = json['sumBedeAmount'];
    sumBesAmount = json['sumBesAmount'];
    operationName = json['operationName'];
    operationCode = json['operationCode'];
    detailsCount = json['detailsCount'];
    serialNumber = json['serialNumber'];
    mobile = json['mobile'];

  }


  String? date;
  String? clock;
  String? sumBedeAmount;
  String? sumBesAmount;
  String? operationName;
  int? operationCode;
  int? detailsCount;
  num? serialNumber;
  String? mobile;


}

















