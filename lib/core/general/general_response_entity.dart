import 'package:equatable/equatable.dart';
import 'package:atba_application/core/general/general_response_model.dart';



class GeneralResponseEntity extends Equatable {
  final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final Data? data;
  final List<ValidationError>? validationErrors;
  final int? errorCode;


  GeneralResponseEntity(
      {this.statusCode,
        this.isSuccess,
        this.message,
        this.messageEn,
        this.data,
        this.validationErrors,
        this.errorCode
      });

  @override
  List<Object?> get props => [
    statusCode,
    isSuccess,
    message,
    messageEn,
    data,
    validationErrors,
    errorCode,
      ];
}
