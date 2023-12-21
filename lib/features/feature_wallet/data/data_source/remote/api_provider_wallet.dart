import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderWallet {


   Dio? _dio;

   ApiProviderWallet() {
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






  Future<dynamic> callChargeWallet(amount, redirectAppUrl) async {
    _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
    // var params = {"amount": amount, "redirectAppUrl": redirectAppUrl};
    var params = {"amount": amount};
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/apiapp/Transaction/Charge",

      data: body,
    );
    return response;
  }

   Future<dynamic> callGetBalance() async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
     var response = await _dio
         ?.get(Constants.baseUrl + "/apiapp/Wallet/Balances");


     return response;
   }


   Future<dynamic> callDoTransfer(amount, destinationMobileNumber) async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";
     var params = {"amount": amount, "destinationMobileNumber": destinationMobileNumber, "transactionType": 22};
     var body = json.encode(params);
     var response = await _dio?.post(
       Constants.baseUrl + "/apiapp/Transaction/Transfer",

       data: body,
     );
     return response;
   }




   Future<dynamic> callWalletTransactionsHistory(String dateFrom,String dateTo) async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";

     final queryParameters = {
       'pageIndex': 1,
       'itemCount': 200,
       'IsExcel': false,
       'dateA': '${dateFrom}',
       'dateB': '${dateTo}',
     };

     var response = await _dio
         ?.get(Constants.baseUrl + "/apiapp/Transaction/Search/V2",queryParameters: queryParameters);
     return response;
   }



   Future<dynamic> callTransactionStatus(String serial) async {
     _dio?.options.headers['Authorization'] = "Bearer ${TokenKeeper.accesstoken}";

     final queryParameters = {
       'pageIndex': 1,
       'itemCount': 1,
       'serial': '${serial}',
     };

     var response = await _dio
         ?.get(Constants.baseUrl + "/apiapp/Transaction/Search/V2",queryParameters: queryParameters);
     return response;
   }

}
