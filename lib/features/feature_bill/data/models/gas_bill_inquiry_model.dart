





import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';

class GasBillInquiryModel extends GasBillInquiryEntity {


  GasBillInquiryModel({
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

  factory GasBillInquiryModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }









    return GasBillInquiryModel(
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
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.consumptionType,
    this.previousCounterDigit,
    this.currentCounterDigit,
    this.abonman,
    this.tax,
    this.insurance,});

  Data.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];
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
    consumptionType = json['consumptionType'];
    previousCounterDigit = json['previousCounterDigit'];
    currentCounterDigit = json['currentCounterDigit'];
    abonman = json['abonman'];
    tax = json['tax'];
    insurance = json['insurance'];
  }
  bool? doesPaymentWithGh;
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
  String? consumptionType;
  String? previousCounterDigit;
  String? currentCounterDigit;
  String? abonman;
  String? tax;
  String? insurance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doesPaymentWithGh'] = doesPaymentWithGh;
    map['fullName'] = fullName;
    map['address'] = address;
    map['amount'] = amount;
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['previousDate'] = previousDate;
    map['currentDate'] = currentDate;
    map['paymentDate'] = paymentDate;
    map['billPdfUrl'] = billPdfUrl;
    map['extraInfo'] = extraInfo;
    map['consumptionType'] = consumptionType;
    map['previousCounterDigit'] = previousCounterDigit;
    map['currentCounterDigit'] = currentCounterDigit;
    map['abonman'] = abonman;
    map['tax'] = tax;
    map['insurance'] = insurance;
    return map;
  }

}




















