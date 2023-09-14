

import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';

class BarghBillInquiryModel extends BarghBillInquiryEntity {


  BarghBillInquiryModel({
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

  factory BarghBillInquiryModel.fromJson(dynamic json) {
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




    return BarghBillInquiryModel(
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
    this.previousDate,
    this.address,
    this.fullName,
    this.doesPaymentWithGh,
    this.amount,
    this.paymentID,
    this.billID,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.tariffType,
    this.customerType,
    this.saleYear,
    this.cycle,
    this.averageConsumption,
    this.insuranceAmount,
    this.taxAmount,
    this.paytollAmount,
    this.powerPaytollAmount,
    this.totalDays,
  });

  Value.fromJson(dynamic json) {
    previousDate = json['previousDate'];
    address = json['address'];
    fullName = json['fullName'];
    doesPaymentWithGh = json['doesPaymentWithGh'];
    amount = json['amount'];
    paymentID = json['paymentID'];
    billID = json['billID'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
    tariffType = json['tariffType'];
    customerType = json['customerType'];
    saleYear = json['saleYear'];
    cycle = json['cycle'];
    averageConsumption = json['averageConsumption'];
    insuranceAmount = json['insuranceAmount'];
    taxAmount = json['taxAmount'];
    paytollAmount = json['paytollAmount'];
    powerPaytollAmount = json['powerPaytollAmount'];
    totalDays = json['totalDays'];
  }






  String? previousDate;
  String? address;
  String? fullName;
  bool? doesPaymentWithGh;
  num? amount;
  String? paymentID;
  String? billID;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;
  String? tariffType;
  String? customerType;
  String? saleYear;
  String? cycle;
  String? averageConsumption;
  String? insuranceAmount;
  String? taxAmount;
  String? paytollAmount;
  String? powerPaytollAmount;
  String? totalDays;


}



class ValueOrDefault {
  ValueOrDefault({
    this.previousDate,
    this.address,
    this.fullName,
    this.doesPaymentWithGh,
    this.amount,
    this.paymentID,
    this.billID,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,
    this.tariffType,
    this.customerType,
    this.saleYear,
    this.cycle,
    this.averageConsumption,
    this.insuranceAmount,
    this.taxAmount,
    this.paytollAmount,
    this.powerPaytollAmount,
    this.totalDays,});

  ValueOrDefault.fromJson(dynamic json) {
    previousDate = json['previousDate'];
    address = json['address'];
    fullName = json['fullName'];
    doesPaymentWithGh = json['doesPaymentWithGh'];
    amount = json['amount'];
    paymentID = json['paymentID'];
    billID = json['billID'];
    currentDate = json['currentDate'];
    paymentDate = json['paymentDate'];
    billPdfUrl = json['billPdfUrl'];
    extraInfo = json['extraInfo'];
    tariffType = json['tariffType'];
    customerType = json['customerType'];
    saleYear = json['saleYear'];
    cycle = json['cycle'];
    averageConsumption = json['averageConsumption'];
    insuranceAmount = json['insuranceAmount'];
    taxAmount = json['taxAmount'];
    paytollAmount = json['paytollAmount'];
    powerPaytollAmount = json['powerPaytollAmount'];
    totalDays = json['totalDays'];
  }

  String? previousDate;
  String? address;
  String? fullName;
  bool? doesPaymentWithGh;
  num? amount;
  String? paymentID;
  String? billID;
  String? currentDate;
  String? paymentDate;
  String? billPdfUrl;
  String? extraInfo;
  String? tariffType;
  String? customerType;
  String? saleYear;
  String? cycle;
  String? averageConsumption;
  String? insuranceAmount;
  String? taxAmount;
  String? paytollAmount;
  String? powerPaytollAmount;
  String? totalDays;




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


