



import 'package:atba_application/features/feature_main/domain/entities/get_balance_entity.dart';

class GetBalanceModel extends GetBalanceEntity {


  GetBalanceModel({
    bool? isFailed,
    bool? isSuccess,
    List<Reasons>? reasons,
    List<Errors>? errors,
    List<Successes>? successes,
    List<ValueOrDefault>? valueOrDefault,
    List<Value>? value,

  }):super(
    isFailed : isFailed,
    isSuccess: isSuccess,
    reasons: reasons,
    errors: errors,
    successes: successes,
    valueOrDefault: valueOrDefault,
    value: value

  );

  factory GetBalanceModel.fromJson(dynamic json) {
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

    List<ValueOrDefault> valueOrDefault = [];
    if (json['valueOrDefault'] != null) {
      json['valueOrDefault'].forEach((v) {
        valueOrDefault?.add(ValueOrDefault.fromJson(v));
      });
    }

    List<Value> value = [];
    if (json['value'] != null) {
      json['value'].forEach((v) {
        value?.add(Value.fromJson(v));
      });
    }



    return GetBalanceModel(
      isFailed: json['isFailed'],
      isSuccess: json['isSuccess'],
      reasons: reasons,
      errors: errors,
      successes: successes,
      value: value,
      valueOrDefault: valueOrDefault,

    );
  }



}

class Value {
  Value({
    this.store,
    this.depositID,
    this.title,
    this.accountNumberID,
    this.accountKind,
    this.depositInauguration_ID,
    this.accountNumberBranchID,
    this.branchID,
    this.tmpDate,
    this.tenantID,
    this.cardNumber,




  });

  Value.fromJson(dynamic json) {
    store = json['store'];
    depositID = json['depositID'];
    title = json['title'];
    accountNumberID = json['accountNumberID'];
    accountKind = json['accountKind'];
    depositInauguration_ID = json['depositInauguration_ID'];
    accountNumberBranchID = json['accountNumberBranchID'];
    branchID = json['branchID'];
    tmpDate = json['tmpDate'];
    tenantID = json['tenantID'];
    cardNumber = json['cardNumber'];
  }
  num? store;
  num? depositID;
  String? title;
  num? accountNumberID;
  num? accountKind;
  num? depositInauguration_ID;
  num? accountNumberBranchID;
  num? branchID;
  String? tmpDate;
  num? tenantID;
  num? cardNumber;





}

class ValueOrDefault {
  ValueOrDefault({
    this.store,
    this.depositID,
    this.title,
    this.accountNumberID,
    this.accountKind,
    this.depositInauguration_ID,
    this.accountNumberBranchID,
    this.branchID,
    this.tmpDate,
    this.tenantID,
    this.cardNumber,




  });

  ValueOrDefault.fromJson(dynamic json) {
    store = json['store'];
    depositID = json['depositID'];
    title = json['title'];
    accountNumberID = json['accountNumberID'];
    accountKind = json['accountKind'];
    depositInauguration_ID = json['depositInauguration_ID'];
    accountNumberBranchID = json['accountNumberBranchID'];
    branchID = json['branchID'];
    tmpDate = json['tmpDate'];
    tenantID = json['tenantID'];
    cardNumber = json['cardNumber'];
  }
  num? store;
  num? depositID;
  String? title;
  num? accountNumberID;
  num? accountKind;
  num? depositInauguration_ID;
  num? accountNumberBranchID;
  num? branchID;
  String? tmpDate;
  num? tenantID;
  num? cardNumber;




}

// class Value {
//   Value({
//     this.balance,});
//
//   Value.fromJson(dynamic json) {
//     balance = json['balance'];
//   }
//   num? balance;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['balance'] = balance;
//     return map;
//   }
//
// }
//
// class ValueOrDefault {
//   ValueOrDefault({
//     this.balance,});
//
//   ValueOrDefault.fromJson(dynamic json) {
//     balance = json['balance'];
//   }
//   num? balance;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['balance'] = balance;
//     return map;
//   }
//
// }

/// message : "string"
/// metadata : {"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"}

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

/// additionalProp1 : "string"
/// additionalProp2 : "string"
/// additionalProp3 : "string"

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

/// message : "string"
/// metadata : {"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"}
/// reasons : ["string"]

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


/// message : "string"
/// metadata : {"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"}

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


