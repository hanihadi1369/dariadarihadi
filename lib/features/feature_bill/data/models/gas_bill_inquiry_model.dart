





import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';

class GasBillInquiryModel extends GasBillInquiryEntity {


  GasBillInquiryModel({
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

  factory GasBillInquiryModel.fromJson(dynamic json) {
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





    return GasBillInquiryModel(
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
    this.doesPaymentWithGh,
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.consumptionType,
    this.previousCounterDigit,
    this.currentCounterDigit,
    this.abonman,
    this.tax,
    this.insurance,});

  Value.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];
    fullName = json['fullName'];
    address = json['address'];
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
    consumptionType = json['consumptionType'];
    previousCounterDigit = json['previousCounterDigit'];
    currentCounterDigit = json['currentCounterDigit'];
    abonman = json['abonman'];
    tax = json['tax'];
    insurance = json['insurance'];
  }
  bool? doesPaymentWithGh;
  String? fullName;
  String? address;
  String? amount;
  String? billID;
  String? paymentID;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;
  String? consumptionType;
  String? previousCounterDigit;
  String? currentCounterDigit;
  String? abonman;
  String? tax;
  String? insurance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doesPaymentWithGh'] = doesPaymentWithGh;
    map['fullName'] = fullName;
    map['address'] = address;
    map['amount'] = amount;
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['previousDate'] = previousDate;
    map['currentDate'] = currentDate;
    map['paymentDate'] = paymentDate;
    map['billPdfUrl'] = billPdfUrl;
    map['extraInfo'] = extraInfo;
    map['consumptionType'] = consumptionType;
    map['previousCounterDigit'] = previousCounterDigit;
    map['currentCounterDigit'] = currentCounterDigit;
    map['abonman'] = abonman;
    map['tax'] = tax;
    map['insurance'] = insurance;
    return map;
  }

}
class ValueOrDefault {
  ValueOrDefault({
    this.doesPaymentWithGh,
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.consumptionType,
    this.previousCounterDigit,
    this.currentCounterDigit,
    this.abonman,
    this.tax,
    this.insurance,});

  ValueOrDefault.fromJson(dynamic json) {
    doesPaymentWithGh = json['doesPaymentWithGh'];
    fullName = json['fullName'];
    address = json['address'];
    amount = json['amount'];
    billID = json['billID'];
    paymentID = json['paymentID'];
    previousDate = json['previousDate'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
    consumptionType = json['consumptionType'];
    previousCounterDigit = json['previousCounterDigit'];
    currentCounterDigit = json['currentCounterDigit'];
    abonman = json['abonman'];
    tax = json['tax'];
    insurance = json['insurance'];
  }
  bool? doesPaymentWithGh;
  String? fullName;
  String? address;
  String? amount;
  String? billID;
  String? paymentID;
  String? previousDate;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;
  String? consumptionType;
  String? previousCounterDigit;
  String? currentCounterDigit;
  String? abonman;
  String? tax;
  String? insurance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doesPaymentWithGh'] = doesPaymentWithGh;
    map['fullName'] = fullName;
    map['address'] = address;
    map['amount'] = amount;
    map['billID'] = billID;
    map['paymentID'] = paymentID;
    map['previousDate'] = previousDate;
    map['currentDate'] = currentDate;
    map['paymentDate'] = paymentDate;
    map['billPdfUrl'] = billPdfUrl;
    map['extraInfo'] = extraInfo;
    map['consumptionType'] = consumptionType;
    map['previousCounterDigit'] = previousCounterDigit;
    map['currentCounterDigit'] = currentCounterDigit;
    map['abonman'] = abonman;
    map['tax'] = tax;
    map['insurance'] = insurance;
    return map;
  }

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


