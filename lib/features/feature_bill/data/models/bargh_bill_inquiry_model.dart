

import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';

class BarghBillInquiryModel extends BarghBillInquiryEntity {


  BarghBillInquiryModel({
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

  factory BarghBillInquiryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }








    return BarghBillInquiryModel(
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
    this.previousDate,
    this.address,
    this.fullName,
    this.doesPaymentWithGh,
    this.amount,
    this.paymentID,
    this.billID,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.tariffType,
    this.customerType,
    this.saleYear,
    this.cycle,
    this.averageConsumption,
    this.insuranceAmount,
    this.taxAmount,
    this.paytollAmount,
    this.powerPaytollAmount,
    this.totalDays,
  });

  Data.fromJson(dynamic json) {
    previousDate = json['previousDate'];
    address = json['address'];
    fullName = json['fullName'];
    doesPaymentWithGh = json['doesPaymentWithGh'];
    amount = json['amount'];
    paymentID = json['paymentID'];
    billID = json['billID'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
    tariffType = json['tariffType'];
    customerType = json['customerType'];
    saleYear = json['saleYear'];
    cycle = json['cycle'];
    averageConsumption = json['averageConsumption'];
    insuranceAmount = json['insuranceAmount'];
    taxAmount = json['taxAmount'];
    paytollAmount = json['paytollAmount'];
    powerPaytollAmount = json['powerPaytollAmount'];
    totalDays = json['totalDays'];
  }






  String? previousDate;
  String? address;
  String? fullName;
  bool? doesPaymentWithGh;
  num? amount;
  String? paymentID;
  String? billID;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;
  String? tariffType;
  String? customerType;
  String? saleYear;
  String? cycle;
  String? averageConsumption;
  String? insuranceAmount;
  String? taxAmount;
  String? paytollAmount;
  String? powerPaytollAmount;
  String? totalDays;


}























