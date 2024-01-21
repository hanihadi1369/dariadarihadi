import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';

class RightelBillInquiryModel extends RightelBillInquiryEntity {
  RightelBillInquiryModel({
    int? statusCode,
    bool? isSuccess,
    String? message,
    String? messageEn,
    Data? data,
    List<ValidationError>? validationErrors,
    int? errorCode
  }) : super(
      statusCode : statusCode,
      isSuccess: isSuccess,
      message: message,
      messageEn: messageEn,
      data: data,
      validationErrors: validationErrors,
      errorCode: errorCode);

  factory RightelBillInquiryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }





    return RightelBillInquiryModel(
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
    this.address,
    this.mobileNumber,
    this.fullName,
    this.midTerm,
    this.finalTerm,
  });

  Data.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];

    address = json['address'];
    mobileNumber = json['mobileNumber'];
    fullName = json['fullName'];

    midTerm =
        json['midTerm'] != null ? MidTerm.fromJson(json['midTerm']) : null;
    finalTerm = json['finalTerm'] != null
        ? FinalTerm.fromJson(json['finalTerm'])
        : null;
  }

  bool? doesPaymentWithGh;

  String? address;
  String? mobileNumber;
  String? fullName;

  MidTerm? midTerm;
  FinalTerm? finalTerm;
}



class FinalTerm {
  FinalTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
  });

  FinalTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];

    extraInfo = json['extraInfo'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
  }

  int? amount;
  String? billID;
  String? paymentID;

  String? extraInfo;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
}

class MidTerm {
  MidTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
  });

  MidTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];

    extraInfo = json['extraInfo'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
  }

  int? amount;
  String? billID;
  String? paymentID;

  String? extraInfo;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
}

















