import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';

class ApiProviderLogin {


   Dio? _dio;

  ApiProviderLogin() {
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




  Future<dynamic> callSendOtpCode(phoneNumber) async {

    var params = {"phoneNo": phoneNumber};
    var body = json.encode(params);

    var response = await _dio
        ?.post(Constants.baseUrl + "/usermanagement/Auth/SendCode", data: body);

    return response;
  }

  Future<dynamic> callVerifyOtpCode(phoneNumber, otpCode) async {
   
    var params = {"phoneNo": phoneNumber, "loginCode": otpCode};
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/usermanagement/Auth/Login",
      data: body,
    );
    return response;
  }
}
