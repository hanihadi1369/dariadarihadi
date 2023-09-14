import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';

class RightelBillInquiryModel extends RightelBillInquiryEntity {
  RightelBillInquiryModel({
    bool? isFailed,
    bool? isSuccess,
    List<Reasons>? reasons,
    List<Errors>? errors,
    List<Successes>? successes,
    ValueOrDefault? valueOrDefault,
    Value? value,
  }) : super(
            isFailed: isFailed,
            isSuccess: isSuccess,
            reasons: reasons,
            errors: errors,
            successes: successes,
            valueOrDefault: valueOrDefault,
            value: value);

  factory RightelBillInquiryModel.fromJson(dynamic json) {
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

    return RightelBillInquiryModel(
      isFailed: json['isFailed'],
      isSuccess: json['isSuccess'],
      reasons: reasons,
      errors: errors,
      successes: successes,
      value: json['value'] != null ? Value.fromJson(json['value']) : null,
      valueOrDefault: json['valueOrDefault'] != null
          ? ValueOrDefault.fromJson(json['valueOrDefault'])
          : null,
    );
  }
}

class Value {
  Value({
    this.doesPaymentWithGh,
    this.address,
    this.mobileNumber,
    this.fullName,
    this.midTerm,
    this.finalTerm,
  });

  Value.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];

    address = json['address'];
    mobileNumber = json['mobileNumber'];
    fullName = json['fullName'];

    midTerm =
        json['midTerm'] != null ? MidTerm.fromJson(json['midTerm']) : null;
    finalTerm = json['finalTerm'] != null
        ? FinalTerm.fromJson(json['finalTerm'])
        : null;
  }

  bool? doesPaymentWithGh;

  String? address;
  String? mobileNumber;
  String? fullName;

  MidTerm? midTerm;
  FinalTerm? finalTerm;
}

class ValueOrDefault {
  ValueOrDefault({
    this.doesPaymentWithGh,
    this.address,
    this.mobileNumber,
    this.fullName,
    this.midTerm,
    this.finalTerm,
  });

  ValueOrDefault.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];

    address = json['address'];
    mobileNumber = json['mobileNumber'];
    fullName = json['fullName'];

    midTerm =
        json['midTerm'] != null ? MidTerm.fromJson(json['midTerm']) : null;
    finalTerm = json['finalTerm'] != null
        ? FinalTerm.fromJson(json['finalTerm'])
        : null;
  }

  bool? doesPaymentWithGh;

  String? address;
  String? mobileNumber;
  String? fullName;

  MidTerm? midTerm;
  FinalTerm? finalTerm;
}

class FinalTerm {
  FinalTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
  });

  FinalTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];

    extraInfo = json['extraInfo'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
  }

  int? amount;
  String? billID;
  String? paymentID;

  String? extraInfo;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
}

class MidTerm {
  MidTerm({
    this.amount,
    this.billID,
    this.paymentID,
    this.extraInfo,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
  });

  MidTerm.fromJson(dynamic json) {
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];

    extraInfo = json['extraInfo'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
  }

  int? amount;
  String? billID;
  String? paymentID;

  String? extraInfo;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
}

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
