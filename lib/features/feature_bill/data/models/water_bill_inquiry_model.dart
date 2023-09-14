



import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';

class WaterBillInquiryModel extends WaterBillInquiryEntity {


  WaterBillInquiryModel({
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

  factory WaterBillInquiryModel.fromJson(dynamic json) {
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



    return WaterBillInquiryModel(
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
    this.doesPayMentWithGh,
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,});

  Value.fromJson(dynamic json) {
    doesPayMentWithGh = json['doesPayMentWithGh'];
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
  }
  bool? doesPayMentWithGh;
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



}

class ValueOrDefault {
  ValueOrDefault({
    this.doesPayMentWithGh,
    this.fullName,
    this.address,
    this.amount,
    this.billID,
    this.paymentID,
    this.previousDate,
    this.currentDate,
    this.paymentDate,
    this.billPdfUrl,
    this.extraInfo,});

  ValueOrDefault.fromJson(dynamic json) {
    doesPayMentWithGh = json['doesPayMentWithGh'];
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
  }
  bool? doesPayMentWithGh;
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


