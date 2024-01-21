class MainErrorModel {
  final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final List<ValidationError>? validationErrors;
  final int? errorCode;

  MainErrorModel(
      {this.statusCode,
        this.isSuccess,
        this.message,
        this.messageEn,
        this.validationErrors,
        this.errorCode});

  factory MainErrorModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }





    return MainErrorModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      message: json['message'],
      messageEn: json['messageEn'],
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


