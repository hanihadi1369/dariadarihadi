







import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';

class TransactionsHistoryModel extends TransactionsHistoryEntity {


  TransactionsHistoryModel({
    bool? isFailed,
    bool? isSuccess,
    List<Reasons>? reasons,
    List<Errors>? errors,
    List<Successes>? successes,
    ValueOrDefault? valueOrDefault,
    Value? value,

  }):super(
    isFailed : isFailed,
    isSuccess: isSuccess,
    reasons: reasons,
    errors: errors,
    successes: successes,
    valueOrDefault: valueOrDefault,
    value: value

  );

  factory TransactionsHistoryModel.fromJson(dynamic json) {
    List<Reasons> reasons = [];
    if (json['reasons'] != null) {
      json['reasons'].forEach((v) {
        reasons?.add(Reasons.fromJson(v));
      });
    }

    List<Errors> errors = [];
    if (json['errors'] != null) {
      json['errors'].forEach((v) {
        errors?.add(Errors.fromJson(v));
      });
    }

    List<Successes> successes = [];
    if (json['successes'] != null) {
      json['successes'].forEach((v) {
        successes?.add(Successes.fromJson(v));
      });
    }



    return TransactionsHistoryModel(
      isFailed: json['isFailed'],
      isSuccess: json['isSuccess'],
      reasons: reasons,
      errors: errors,
      successes: successes,
      value: json['value'] != null ? Value.fromJson(json['value']) : null,
      valueOrDefault: json['valueOrDefault'] != null ? ValueOrDefault.fromJson(json['valueOrDefault']): null,

    );
  }



}



class Value {
  Value({
    this.statement,
    this.transactionCount,});

  Value.fromJson(dynamic json) {
    if (json['statement'] != null) {
      statement = [];
      json['statement'].forEach((v) {
        statement!.add(Statement.fromJson(v));
      });
    }
    transactionCount = json['transactionCount'];
  }
  List<Statement>? statement;
  int? transactionCount;


}


class ValueOrDefault {
  ValueOrDefault({
    this.statement,
    this.transactionCount,});

  ValueOrDefault.fromJson(dynamic json) {
    if (json['statement'] != null) {
      statement = [];
      json['statement'].forEach((v) {
        statement!.add(Statement.fromJson(v));
      });
    }
    transactionCount = json['transactionCount'];
  }
  List<Statement>? statement;
  int? transactionCount;



}


class Statement {
  Statement({
    this.id,
    this.date,
    this.clock,
    this.bedeAmount,
    this.besAmount,
    this.description,
    this.operationName,
    this.operationCode,
    this.serialNumber,
    this.oprationIcon,
    this.mobile,
    this.transferStatus,
    this.depositID,
    this.depositTitle,
    this.currencyTitle,
    this.campainTitle,});

  Statement.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    clock = json['clock'];
    bedeAmount = json['bedeAmount'];
    besAmount = json['besAmount'];
    description = json['description'];
    operationName = json['operationName'];
    operationCode = json['operationCode'];
    serialNumber = json['serialNumber'];
    oprationIcon = json['oprationIcon'];
    mobile = json['mobile'];
    transferStatus = json['transferStatus'];
    depositID = json['depositID'];
    depositTitle = json['depositTitle'];
    currencyTitle = json['currencyTitle'];
    campainTitle = json['campainTitle'];
  }
  String? id;
  String? date;
  String? clock;
  String? bedeAmount;
  String? besAmount;
  String? description;
  String? operationName;
  String? operationCode;
  int? serialNumber;
  String? oprationIcon;
  String? mobile;
  int? transferStatus;
  int? depositID;
  String? depositTitle;
  String? currencyTitle;
  String? campainTitle;

}


class Successes {
  Successes({
    this.message,
    this.metadata,
  });

  Successes.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  String? message;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }
}



class Metadata {
  Metadata({
    this.additionalProp1,
    this.additionalProp2,
    this.additionalProp3,
  });

  Metadata.fromJson(dynamic json) {
    additionalProp1 = json['additionalProp1'];
    additionalProp2 = json['additionalProp2'];
    additionalProp3 = json['additionalProp3'];
  }

  String? additionalProp1;
  String? additionalProp2;
  String? additionalProp3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalProp1'] = additionalProp1;
    map['additionalProp2'] = additionalProp2;
    map['additionalProp3'] = additionalProp3;
    return map;
  }
}



class Errors {
  Errors({
    this.message,
    this.metadata,
    this.reasons,
  });

  Errors.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    reasons = json['reasons'] != null ? json['reasons'].cast<String>() : [];
  }

  String? message;
  Metadata? metadata;
  List<String>? reasons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    map['reasons'] = reasons;
    return map;
  }
}



class Reasons {
  Reasons({
    this.message,
    this.metadata,
  });

  Reasons.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  String? message;
  Metadata? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }
}


