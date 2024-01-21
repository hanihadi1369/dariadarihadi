









import '../../domain/entities/show_internet_packages_entity.dart';

class ShowInternetPackagesModel extends ShowInternetPackagesEntity {


  ShowInternetPackagesModel({
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

  factory ShowInternetPackagesModel.fromJson(dynamic json) {
     List<ValidationError> validationErrors = [];
    if (json['validationErrors'] != null) {
      json['validationErrors'].forEach((v) {
        validationErrors?.add(ValidationError.fromJson(v));
      });
    }









    return ShowInternetPackagesModel(
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
    this.status,
    this.message,
    this.code,
    this.description,
    this.requestId,
    this.mobile,
    this.bundles,});

  Data.fromJson(dynamic json) {
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





















