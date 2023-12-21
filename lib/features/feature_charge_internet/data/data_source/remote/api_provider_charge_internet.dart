import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderChargeInternet {
  Dio? _dio;

  ApiProviderChargeInternet() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 30 * 1000, // 30 seconds
          receiveTimeout: 30 * 1000 // 30 seconds
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

  Future<dynamic> callShowInternetPackage(operatorType, mobile) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {"operatorType": operatorType, "mobile": mobile};

    final queryParameters = {
      'operatorType': operatorType,
      'mobile': mobile,
    };



    // https://uat-atba.saminray.com/walletintpackage/api/v1/ShowInternetPackage?OperatorType=0&Mobile=09363593154

    var response = await _dio?.get(
        // Constants.baseUrl + "/internet/api/v1/ShowInternetPackage",
        Constants.baseUrl + "/walletintpackage/api/v1/ShowInternetPackage",
        queryParameters: queryParameters);
    return response;
  }

  Future<dynamic> callBuyInternetPackage(bundleId, amount, cellNumber,
      requestId, operatorType, operationCode, type) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "bundleId": bundleId,
      // "amount": amount,
      "cellNumber": cellNumber,
      // "requestId": requestId,
      "requestId": "undefined",
      "operatorType": operatorType,
      // "operationCode": operationCode,
      // "type": type,
    };

    var body = json.encode(params);
    var response = await _dio?.post(
      // Constants.baseUrl + "/internet/api/v1/BuyInternetPackage",
      Constants.baseUrl + "/walletintpackage/api/v1/BuyInternetPackage",
      data: body,
    );
    return response;
  }

  Future<dynamic> callGetBalance() async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var response =
        await _dio?.get(Constants.baseUrl + "/apiapp/Wallet/Balances");
    return response;
  }
}
