







import 'package:atba_application/features/feature_profile/domain/entities/update_profile_entity.dart';

class UpdateProfileModel extends UpdateProfileEntity {


  UpdateProfileModel({
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

  factory UpdateProfileModel.fromJson(dynamic json) {
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





    return UpdateProfileModel(
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
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.email,
    this.phoneNo,
    this.image,
    this.imageUrl,
    this.sex,
    this.sexEnum,
    this.referrer,
    this.nationalCode,
    this.birthDate,
    this.longBirthDate,
    this.province,
    this.provinceName,
    this.city,
    this.cityName,
    this.createAt,
    this.strCreateAt,
    this.status,
    this.iban,
    this.latitude,
    this.longitude,
    this.address,
    this.parentId,
    this.businessKey,
    this.customerID,});

  Value.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    username = json['username'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    image = json['image'];
    imageUrl = json['imageUrl'];
    sex = json['sex'];
    sexEnum = json['sexEnum'];
    referrer = json['referrer'];
    nationalCode = json['nationalCode'];
    birthDate = json['birthDate'];
    longBirthDate = json['longBirthDate'];
    province = json['province'];
    provinceName = json['provinceName'];
    city = json['city'];
    cityName = json['cityName'];
    createAt = json['createAt'];
    strCreateAt = json['strCreateAt'];
    status = json['status'];
    iban = json['iban'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    parentId = json['parentId'];
    businessKey = json['businessKey'];
    customerID = json['customerID'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? username;
  String? email;
  String? phoneNo;
  String? image;
  String? imageUrl;
  num? sex;
  String? sexEnum;
  String? referrer;
  String? nationalCode;
  String? birthDate;
  num? longBirthDate;
  String? province;
  String? provinceName;
  String? city;
  String? cityName;
  String? createAt;
  String? strCreateAt;
  num? status;
  String? iban;
  num? latitude;
  num? longitude;
  String? address;
  String? parentId;
  String? businessKey;
  num? customerID;


}



class ValueOrDefault {
  ValueOrDefault({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.email,
    this.phoneNo,
    this.image,
    this.imageUrl,
    this.sex,
    this.sexEnum,
    this.referrer,
    this.nationalCode,
    this.birthDate,
    this.longBirthDate,
    this.province,
    this.provinceName,
    this.city,
    this.cityName,
    this.createAt,
    this.strCreateAt,
    this.status,
    this.iban,
    this.latitude,
    this.longitude,
    this.address,
    this.parentId,
    this.businessKey,
    this.customerID,});

  ValueOrDefault.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    username = json['username'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    image = json['image'];
    imageUrl = json['imageUrl'];
    sex = json['sex'];
    sexEnum = json['sexEnum'];
    referrer = json['referrer'];
    nationalCode = json['nationalCode'];
    birthDate = json['birthDate'];
    longBirthDate = json['longBirthDate'];
    province = json['province'];
    provinceName = json['provinceName'];
    city = json['city'];
    cityName = json['cityName'];
    createAt = json['createAt'];
    strCreateAt = json['strCreateAt'];
    status = json['status'];
    iban = json['iban'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    parentId = json['parentId'];
    businessKey = json['businessKey'];
    customerID = json['customerID'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? username;
  String? email;
  String? phoneNo;
  String? image;
  String? imageUrl;
  num? sex;
  String? sexEnum;
  String? referrer;
  String? nationalCode;
  String? birthDate;
  num? longBirthDate;
  String? province;
  String? provinceName;
  String? city;
  String? cityName;
  String? createAt;
  String? strCreateAt;
  num? status;
  String? iban;
  num? latitude;
  num? longitude;
  String? address;
  String? parentId;
  String? businessKey;
  num? customerID;


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


