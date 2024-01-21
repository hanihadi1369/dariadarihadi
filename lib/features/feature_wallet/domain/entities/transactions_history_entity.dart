import 'package:equatable/equatable.dart';

import 'package:atba_application/features/feature_wallet/data/models/transactions_history_model.dart';


class TransactionsHistoryEntity extends Equatable {
      final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? messageEn;
  final Data? data;
  final List<ValidationError>? validationErrors;
  final int? errorCode;

  TransactionsHistoryEntity(
      {this.statusCode,
      this.isSuccess,
      this.message,
      this.messageEn,
      this.data,
      this.validationErrors,
      this.errorCode});

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
