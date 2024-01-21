



import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';

class WaterBillInquiryModel extends WaterBillInquiryEntity {


  WaterBillInquiryModel({
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

  factory WaterBillInquiryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }







    return WaterBillInquiryModel(
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
    this.doesPayMentWithGh,
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,});

  Data.fromJson(dynamic json) {
    doesPayMentWithGh = json['doesPayMentWithGh'];
    fullName = json['fullName'];
    address = json['address'];
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
  }
  bool? doesPayMentWithGh;
  String? fullName;
  String? address;
  String? amount;
  String? billID;
  String? paymentID;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;



}























