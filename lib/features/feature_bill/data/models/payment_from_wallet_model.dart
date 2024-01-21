




import 'package:atba_application/features/feature_bill/domain/entities/payment_from_wallet_entity.dart';

class PaymentFromWalletModel extends PaymentFromWalletEntity {


  PaymentFromWalletModel({
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

  factory PaymentFromWalletModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }








    return PaymentFromWalletModel(
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
   this.orderId});

  Data.fromJson(dynamic json) {
    orderId = json['orderId'];
  }
  num? orderId;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    return map;
  }

}
























