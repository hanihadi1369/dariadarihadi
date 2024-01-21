





import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';

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
     this.balance,
    this.availablebalance,
  });

  Value.fromJson(dynamic json) {
     balance = json['balance'];
    availablebalance = json['availablebalance'];
  }
 num? balance;
  num? availablebalance;








}

class ValueOrDefault {
  ValueOrDefault({
     this.balance,
    this.availablebalance,




  });

  ValueOrDefault.fromJson(dynamic json) {
     balance = json['balance'];
    availablebalance = json['availablebalance'];
  }
 num? balance;
  num? availablebalance;




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


