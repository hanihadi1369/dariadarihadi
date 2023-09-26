import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/token_keeper.dart';

class ApiProviderBill {
  Dio? _dio;

  ApiProviderBill() {
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

  Future<dynamic> callGetBills() async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var response = await _dio?.get(Constants.baseUrl + "/walletbill/GetBill");
    return response;
  }

  Future<dynamic> callCreateBill(billType, billCode, billTitle) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {"type": billType, "code": billCode, "title": billTitle};
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/CreateBill",
      data: body,
    );
    return response;
  }

  Future<dynamic> callUpdateBill(billId, billType, billCode, billTitle) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "id": billId,
      "type": billType,
      "code": billCode,
      "title": billTitle
    };
    var body = json.encode(params);
    var response = await _dio?.put(
      Constants.baseUrl + "/walletbill/UpdateBill",
      data: body,
    );
    return response;
  }

  Future<dynamic> callDeleteBill(billId) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";

    var params = {
      "id": billId,
    };
    var body = json.encode(params);
    var response = await _dio?.delete(
        Constants.baseUrl + "/walletbill/DeleteBill",data: body
        );
    return response;
  }

  Future<dynamic> callBarghBillInquiry(electricityBillID, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "electricityBillID": electricityBillID,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/ElectricityBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callGasBillInquiry(
      participateCode, gasBillID, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      // "participateCode": participateCode,
      "gasBillID": gasBillID,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/GasBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callWaterBillInquiry(waterBillID, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "waterBillID": waterBillID,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/WaterBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callFixLineBillInquiry(fixedLineNumber, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "fixedLineNumber": fixedLineNumber,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/vi/FixedLineBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callMCIMobileBillInquiry(mobileNumber, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "mobileNumber": mobileNumber,
      // "traceNumber": traceNumber

    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/MCIMobileBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callMtnMobileBillInquiry(mobileNumber, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "mobileNumber": mobileNumber,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/MtnMobileBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callRightelMobileBillInquiry(
      mobileNumber, traceNumber) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var params = {
      "mobileNumber": mobileNumber,
      // "traceNumber": traceNumber
    };
    var body = json.encode(params);
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/RightelMobileBillInquiry",
      data: body,
    );
    return response;
  }

  Future<dynamic> callBillPaymentFromWallet(myRequestBody) async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var response = await _dio?.post(
      Constants.baseUrl + "/walletbill/api/v1/BillPaymentFromWallet",
      data: myRequestBody,
    );
    return response;
  }

  Future<dynamic> callGetBalance() async {
    _dio?.options.headers['Authorization'] =
        "Bearer ${TokenKeeper.accesstoken}";
    var response =
        await _dio?.get(Constants.baseUrl + "/apiapp/Wallet/GetBalances");
    return response;
  }
}
