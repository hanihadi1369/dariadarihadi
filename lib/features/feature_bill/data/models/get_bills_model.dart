import 'package:atba_application/features/feature_bill/domain/entities/get_bills_entity.dart';

class GetBillsModel extends GetBillsEntity {
  GetBillsModel({
    int? statusCode,
    bool? isSuccess,
    String? message,
    String? messageEn,
    List<ValidationError>? validationErrors,
    int? errorCode,
    List<Data>? data,
  }) : super(
            statusCode: statusCode,
            isSuccess: isSuccess,
            message: message,
            messageEn: messageEn,
            data: data,
            validationErrors: validationErrors,
            errorCode: errorCode);

  factory GetBillsModel.fromJson(dynamic json) {
    List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }


    List<Data> datas = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        datas?.add(Data.fromJson(v));
      });
    }

    return GetBillsModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      message: json['message'],
      messageEn: json['messageEn'],
      data: datas,
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
    this.type,
    this.code,
    this.title,
    this.mobile,
    this.id,
  });

  Data.fromJson(dynamic json) {
    type = json['type'];
    code = json['code'];
    title = json['title'];
    mobile = json['mobile'];
    id = json['id'];
  }

  num? type;
  String? code;
  String? title;
  String? mobile;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['code'] = code;
    map['title'] = title;
    map['mobile'] = mobile;
    map['id'] = id;
    return map;
  }
}
