import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderMain {


   Dio? _dio;

  ApiProviderMain() {
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




  Future<dynamic> callGetBalance() async {
    _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
    var response = await _dio
        ?.get(Constants.baseUrl + "/apiapp/Wallet/Balances");
    return response;
  }


   Future<dynamic> callGetMyProfile() async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
     // var response = await _dio?.get(Constants.baseUrl + "/auth/User/MyProfile");
     var response = await _dio?.get(Constants.baseUrl + "/usermanagement/User/MyProfile");
     return response;
   }


   Future<dynamic> callRefreshToken(refreshToken) async {

     var params = {"refreshToken": refreshToken};
     var body = json.encode(params);
     // var response = await _dio?.post(Constants.baseUrl + "/auth/Auth/Refresh",data: body,);
     var response = await _dio?.post(Constants.baseUrl + "/usermanagement/Auth/Refresh",data: body,);
     return response;
   }



}
