import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderChargeSimCard {
  Dio? _dio;

  ApiProviderChargeSimCard() {
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



  Future<dynamic> callChargeSim(totalAmount, cellNumber, operatorType , simCardType) async {
    _dio?.options.headers['Authorization'] =
    "Bearer ${TokenKeeper.accesstoken}";
    var params = {"totalAmount": totalAmount, "cellNumber": cellNumber, "operatorType": operatorType  , "simCardType": simCardType};
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/WalletCharge/api/v1/MultiTopUp",
      data: body,
    );
    return response;
  }

  Future<dynamic> callGetBalance() async {
    _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
    var response = await _dio
        ?.get(Constants.baseUrl + "/apiapp/Wallet/GetBalances");
    return response;
  }

}
