


import 'package:atba_application/features/feature_main/domain/entities/refresh_token_entity.dart';

import '../../../../core/general/general_response_model.dart';

/// isFailed : true
/// isSuccess : true
/// reasons : [{"message":"string","metadata":{"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"}}]
/// errors : [{"message":"string","metadata":{"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"},"reasons":["string"]}]
/// successes : [{"message":"string","metadata":{"additionalProp1":"string","additionalProp2":"string","additionalProp3":"string"}}]
/// valueOrDefault : {"tokens":{"accesstoken":"string","refreshToken":"string","refreshTokenExpirationDate":"2023-07-29T11:41:53.234Z"},"user":{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","createAt":"2023-07-29T11:41:53.234Z","firstName":"string","lastName":"string","username":"string","phoneNo":"string","businessKey":"3fa85f64-5717-4562-b3fc-2c963f66afa6","parentId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","sex":0,"referrer":"string","image":"string","nationalCode":"string","birthDate":"2023-07-29T11:41:53.234Z","email":"string","city":"3fa85f64-5717-4562-b3fc-2c963f66afa6","iban":"string","status":0,"address":"string","latitude":0,"longitude":0,"isAuthenticated":true,"authenticateDate":"string","userAuthenticated":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nationalCodeSerial":"string"},"roles":[{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","name":"string","pName":"string","priority":0,"description":"string","isAdmin":true}]}
/// value : {"tokens":{"accesstoken":"string","refreshToken":"string","refreshTokenExpirationDate":"2023-07-29T11:41:53.234Z"},"user":{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","createAt":"2023-07-29T11:41:53.234Z","firstName":"string","lastName":"string","username":"string","phoneNo":"string","businessKey":"3fa85f64-5717-4562-b3fc-2c963f66afa6","parentId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","sex":0,"referrer":"string","image":"string","nationalCode":"string","birthDate":"2023-07-29T11:41:53.234Z","email":"string","city":"3fa85f64-5717-4562-b3fc-2c963f66afa6","iban":"string","status":0,"address":"string","latitude":0,"longitude":0,"isAuthenticated":true,"authenticateDate":"string","userAuthenticated":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nationalCodeSerial":"string"},"roles":[{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","name":"string","pName":"string","priority":0,"description":"string","isAdmin":true}]}

class RefreshTokenModel extends RefreshTokenEntity {
  RefreshTokenModel({
    bool? isFailed,
    bool? isSuccess,
    List<Reasons>? reasons,
    List<Errors>? errors,
    List<Successes>? successes,
    ValueOrDefault? valueOrDefault,
    Value? value,
  }):super(
    isFailed: isFailed,
    isSuccess: isSuccess,
    reasons: reasons,
    errors: errors,
    successes: successes,
    valueOrDefault: valueOrDefault,
    value: value
  );

  factory RefreshTokenModel.fromJson(dynamic json) {
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



    return RefreshTokenModel(
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

/// tokens : {"accesstoken":"string","refreshToken":"string","refreshTokenExpirationDate":"2023-07-29T11:41:53.234Z"}
/// user : {"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","createAt":"2023-07-29T11:41:53.234Z","firstName":"string","lastName":"string","username":"string","phoneNo":"string","businessKey":"3fa85f64-5717-4562-b3fc-2c963f66afa6","parentId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","sex":0,"referrer":"string","image":"string","nationalCode":"string","birthDate":"2023-07-29T11:41:53.234Z","email":"string","city":"3fa85f64-5717-4562-b3fc-2c963f66afa6","iban":"string","status":0,"address":"string","latitude":0,"longitude":0,"isAuthenticated":true,"authenticateDate":"string","userAuthenticated":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nationalCodeSerial":"string"}
/// roles : [{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","name":"string","pName":"string","priority":0,"description":"string","isAdmin":true}]

class Value {
  Value({
    this.tokens,
    this.user,
    this.roles,
  });

  Value.fromJson(dynamic json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((v) {
        roles?.add(Roles.fromJson(v));
      });
    }
  }

  Tokens? tokens;
  User? user;
  List<Roles>? roles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (roles != null) {
      map['roles'] = roles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// name : "string"
/// pName : "string"
/// priority : 0
/// description : "string"
/// isAdmin : true

class Roles {
  Roles({
    this.id,
    this.name,
    this.pName,
    this.priority,
    this.description,
    this.isAdmin,
  });

  Roles.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    pName = json['pName'];
    priority = json['priority'];
    description = json['description'];
    isAdmin = json['isAdmin'];
  }

  String? id;
  String? name;
  String? pName;
  num? priority;
  String? description;
  bool? isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['pName'] = pName;
    map['priority'] = priority;
    map['description'] = description;
    map['isAdmin'] = isAdmin;
    return map;
  }
}

/// id : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// createAt : "2023-07-29T11:41:53.234Z"
/// firstName : "string"
/// lastName : "string"
/// username : "string"
/// phoneNo : "string"
/// businessKey : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// parentId : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// sex : 0
/// referrer : "string"
/// image : "string"
/// nationalCode : "string"
/// birthDate : "2023-07-29T11:41:53.234Z"
/// email : "string"
/// city : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// iban : "string"
/// status : 0
/// address : "string"
/// latitude : 0
/// longitude : 0
/// isAuthenticated : true
/// authenticateDate : "string"
/// userAuthenticated : "3fa85f64-5717-4562-b3fc-2c963f66afa6"
/// nationalCodeSerial : "string"

class User {
  User({
    this.id,
    this.createAt,
    this.firstName,
    this.lastName,
    this.username,
    this.phoneNo,
    this.businessKey,
    this.parentId,
    this.sex,
    this.referrer,
    this.image,
    this.nationalCode,
    this.birthDate,
    this.email,
    this.city,
    this.iban,
    this.status,
    this.address,
    this.latitude,
    this.longitude,
    this.isAuthenticated,
    this.authenticateDate,
    this.userAuthenticated,
    this.nationalCodeSerial,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    createAt = json['createAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    phoneNo = json['phoneNo'];
    businessKey = json['businessKey'];
    parentId = json['parentId'];
    sex = json['sex'];
    referrer = json['referrer'];
    image = json['image'];
    nationalCode = json['nationalCode'];
    birthDate = json['birthDate'];
    email = json['email'];
    city = json['city'];
    iban = json['iban'];
    status = json['status'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isAuthenticated = json['isAuthenticated'];
    authenticateDate = json['authenticateDate'];
    userAuthenticated = json['userAuthenticated'];
    nationalCodeSerial = json['nationalCodeSerial'];
  }

  String? id;
  String? createAt;
  String? firstName;
  String? lastName;
  String? username;
  String? phoneNo;
  String? businessKey;
  String? parentId;
  num? sex;
  String? referrer;
  String? image;
  String? nationalCode;
  String? birthDate;
  String? email;
  String? city;
  String? iban;
  num? status;
  String? address;
  num? latitude;
  num? longitude;
  bool? isAuthenticated;
  String? authenticateDate;
  String? userAuthenticated;
  String? nationalCodeSerial;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['createAt'] = createAt;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['username'] = username;
    map['phoneNo'] = phoneNo;
    map['businessKey'] = businessKey;
    map['parentId'] = parentId;
    map['sex'] = sex;
    map['referrer'] = referrer;
    map['image'] = image;
    map['nationalCode'] = nationalCode;
    map['birthDate'] = birthDate;
    map['email'] = email;
    map['city'] = city;
    map['iban'] = iban;
    map['status'] = status;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['isAuthenticated'] = isAuthenticated;
    map['authenticateDate'] = authenticateDate;
    map['userAuthenticated'] = userAuthenticated;
    map['nationalCodeSerial'] = nationalCodeSerial;
    return map;
  }
}

/// accesstoken : "string"
/// refreshToken : "string"
/// refreshTokenExpirationDate : "2023-07-29T11:41:53.234Z"

class Tokens {
  Tokens({
    this.accesstoken,
    this.refreshToken,
    this.refreshTokenExpirationDate,
  });

  Tokens.fromJson(dynamic json) {
    accesstoken = json['accesstoken'];
    refreshToken = json['refreshToken'];
    refreshTokenExpirationDate = json['refreshTokenExpirationDate'];
  }

  String? accesstoken;
  String? refreshToken;
  String? refreshTokenExpirationDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accesstoken'] = accesstoken;
    map['refreshToken'] = refreshToken;
    map['refreshTokenExpirationDate'] = refreshTokenExpirationDate;
    return map;
  }
}

/// tokens : {"accesstoken":"string","refreshToken":"string","refreshTokenExpirationDate":"2023-07-29T11:41:53.234Z"}
/// user : {"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","createAt":"2023-07-29T11:41:53.234Z","firstName":"string","lastName":"string","username":"string","phoneNo":"string","businessKey":"3fa85f64-5717-4562-b3fc-2c963f66afa6","parentId":"3fa85f64-5717-4562-b3fc-2c963f66afa6","sex":0,"referrer":"string","image":"string","nationalCode":"string","birthDate":"2023-07-29T11:41:53.234Z","email":"string","city":"3fa85f64-5717-4562-b3fc-2c963f66afa6","iban":"string","status":0,"address":"string","latitude":0,"longitude":0,"isAuthenticated":true,"authenticateDate":"string","userAuthenticated":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nationalCodeSerial":"string"}
/// roles : [{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","name":"string","pName":"string","priority":0,"description":"string","isAdmin":true}]

class ValueOrDefault {
  ValueOrDefault({
    this.tokens,
    this.user,
    this.roles,
  });

  ValueOrDefault.fromJson(dynamic json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((v) {
        roles?.add(Roles.fromJson(v));
      });
    }
  }

  Tokens? tokens;
  User? user;
  List<Roles>? roles;


}
