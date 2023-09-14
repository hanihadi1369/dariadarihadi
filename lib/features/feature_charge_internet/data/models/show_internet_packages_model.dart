









import '../../domain/entities/show_internet_packages_entity.dart';

class ShowInternetPackagesModel extends ShowInternetPackagesEntity {


  ShowInternetPackagesModel({
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

  factory ShowInternetPackagesModel.fromJson(dynamic json) {
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





    return ShowInternetPackagesModel(
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
    this.status,
    this.message,
    this.code,
    this.description,
    this.requestId,
    this.mobile,
    this.bundles,});

  Value.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    description = json['description'];
    requestId = json['requestId'];
    mobile = json['mobile'];
    bundles = json['bundles'] != null ? Bundles.fromJson(json['bundles']) : null;
  }
  String? status;
  String? message;
  String? code;
  String? description;
  String? requestId;
  String? mobile;
  Bundles? bundles;



}

class ValueOrDefault {
  ValueOrDefault({
    this.status,
    this.message,
    this.code,
    this.description,
    this.requestId,
    this.mobile,
    this.bundles,
  });

  ValueOrDefault.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    description = json['description'];
    requestId = json['requestId'];
    mobile = json['mobile'];
    bundles =
    json['bundles'] != null ? Bundles.fromJson(json['bundles']) : null;
  }

  String? status;
  String? message;
  String? code;
  String? description;
  String? requestId;
  String? mobile;
  Bundles? bundles;


}

class Bundles {
  Bundles({
    this.monthly,
    this.weekly,
    this.daily,
    this.other,
    this.trimester,
    this.semiannual,
    this.annual,
  });

  Bundles.fromJson(dynamic json) {
    if (json['monthly'] != null) {
      monthly = [];
      json['monthly'].forEach((v) {
        monthly?.add(Monthly.fromJson(v));
      });
    }
    if (json['weekly'] != null) {
      weekly = [];
      json['weekly'].forEach((v) {
        weekly?.add(Weekly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(Daily.fromJson(v));
      });
    }
    if (json['other'] != null) {
      other = [];
      json['other'].forEach((v) {
        other?.add(Other.fromJson(v));
      });
    }
    if (json['trimester'] != null) {
      trimester = [];
      json['trimester'].forEach((v) {
        trimester?.add(Trimester.fromJson(v));
      });
    }
    if (json['semiannual'] != null) {
      semiannual = [];
      json['semiannual'].forEach((v) {
        semiannual?.add(Semiannual.fromJson(v));
      });
    }
    if (json['annual'] != null) {
      annual = [];
      json['annual'].forEach((v) {
        annual?.add(Annual.fromJson(v));
      });
    }
  }

  List<Monthly>? monthly;
  List<Weekly>? weekly;
  List<Daily>? daily;
  List<Other>? other;
  List<Trimester>? trimester; // 3month
  List<Semiannual>? semiannual; // 6mahe
  List<Annual>? annual;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (monthly != null) {
      map['monthly'] = monthly?.map((v) => v.toJson()).toList();
    }
    if (weekly != null) {
      map['weekly'] = weekly?.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      map['daily'] = daily?.map((v) => v.toJson()).toList();
    }
    if (other != null) {
      map['other'] = other?.map((v) => v.toJson()).toList();
    }
    if (trimester != null) {
      map['trimester'] = trimester?.map((v) => v.toJson()).toList();
    }
    if (semiannual != null) {
      map['semiannual'] = semiannual?.map((v) => v.toJson()).toList();
    }
    if (annual != null) {
      map['annual'] = annual?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



class Annual {
  Annual({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Annual.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}


class Semiannual {
  Semiannual({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Semiannual.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}



class Trimester {
  Trimester({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Trimester.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}



class Other {
  Other({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Other.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}



class Daily {
  Daily({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Daily.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}



class Weekly {
  Weekly({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Weekly.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
}



class Monthly {
  Monthly({
    this.id,
    this.title,
    this.amount,
    this.billAmount,
    this.type,
  });

  Monthly.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    billAmount = json['billAmount'];
    type = json['type'];
  }

  String? id;
  String? title;
  String? amount;
  String? billAmount;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['billAmount'] = billAmount;
    map['type'] = type;
    return map;
  }
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


