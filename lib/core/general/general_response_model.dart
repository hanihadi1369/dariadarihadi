


import 'package:atba_application/core/general/general_response_entity.dart';

class GeneralResponseModel extends GeneralResponseEntity {


  GeneralResponseModel({
    int? statusCode,
    bool? isSuccess,
    String? message,
    String? messageEn,
    Data? data,
    List<ValidationError>? validationErrors,
    int? errorCode


  }):super(
      statusCode: statusCode,
      isSuccess: isSuccess,
      message: message,
      messageEn: messageEn,
      data: data,
      validationErrors: validationErrors,
      errorCode: errorCode


  );

  factory GeneralResponseModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }









    return GeneralResponseModel(
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
    this.isNewUser,
  });

  Data.fromJson(dynamic json) {
    isNewUser = json['isNewUser'];
  }

  bool? isNewUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isNewUser'] = isNewUser;
    return map;
  }
}

















