









import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';

class MtnBillInquiryModel extends MtnBillInquiryEntity {


  MtnBillInquiryModel({
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

  factory MtnBillInquiryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }








    return MtnBillInquiryModel(
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
    this.doesPaymentWithGh,
    this.midTerm,
    this.finalTerm,});

  Data.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];
    midTerm = json['midTerm'] != null ? MidTerm.fromJson(json['midTerm']) : null;
    finalTerm = json['finalTerm'] != null ? FinalTerm.fromJson(json['finalTerm']) : null;
  }
  bool? doesPaymentWithGh;
  MidTerm? midTerm;
  FinalTerm? finalTerm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doesPaymentWithGh'] = doesPaymentWithGh;
    if (midTerm != null) {
      map['midTerm'] = midTerm!.toJson();
    }
    if (finalTerm != null) {
      map['finalTerm'] = finalTerm!.toJson();
    }
    return map;
  }

}

class FinalTerm {
  FinalTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,});

  FinalTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];
    extraInfo = json['extraInfo'];
  }
  int? amount;
  String? billID;
  String? paymentID;
  String? extraInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['extraInfo'] = extraInfo;
    return map;
  }

}
class MidTerm {
  MidTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,});

  MidTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];
    extraInfo = json['extraInfo'];
  }
  int? amount;
  String? billID;
  String? paymentID;
  String? extraInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['extraInfo'] = extraInfo;
    return map;
  }

}





















