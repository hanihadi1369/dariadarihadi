import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderProfile {


   Dio? _dio;

  ApiProviderProfile() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 30*1000, // 30 seconds
          receiveTimeout: 30*1000 // 30 seconds
      );

      _dio = new Dio(options);
      _dio?.options.headers['BusinessKey'] =
      '1da5ce01-7491-44a2-a823-2f4734ef0aef';
      _dio?.options.headers['Content-Type'] = 'application/json';
      _dio?.options.headers['accept'] = 'text/plain';
      _dio?.interceptors.add(
      DioLoggingInterceptor(
      level: Level.body,
      compact: false,
      ),
      );
    }
  }






   Future<dynamic> callUpdateMyProfile(firstName,lastName,nationalCode,email,iban) async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
     var params = {
       "firstName": firstName,
       "lastName": lastName,

       "nationalCode": (nationalCode == "")?null:nationalCode,
       "email": (email == "")?null:email,
       "iban": (iban == "")?null:iban,
       "sex" : 0

     };
     var body = json.encode(params);
     var response = await _dio
         ?.put(Constants.baseUrl + "/usermanagement/User/MyProfile",data: body);
     return response;
   }






}
