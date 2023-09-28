import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/error_model.dart';
import '../../domain/entities/send_otp_code_entity.dart';
import '../../domain/entities/verify_otp_code_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../data_source/remote/api_provider_login.dart';
import '../models/send_otp_code_model.dart';
import '../models/verify_otp_code_model.dart';

class LoginRepositoryImpl extends LoginRepository {
  ApiProviderLogin apiProviderLogin;

  LoginRepositoryImpl(this.apiProviderLogin);

  @override
  Future<DataState<SendOtpCodeEntity>> doSendOtpCodeOperation(
      String phoneNumber) async {
    try {
      Response response = await apiProviderLogin.callSendOtpCode(phoneNumber);

      if (response.statusCode == 200) {
        SendOtpCodeEntity sendOtpCodeEntity =
            SendOtpCodeModel.fromJson(response.data);
        return DataSuccess(sendOtpCodeEntity);
      } else {
        return DataFailed(
            "خطای ارتباط با سرور - کد خطا : ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        DioError dioError = e as DioError;
        if (dioError.response != null) {


          if(dioError.response!.statusCode == 401){
            return DataFailed("عدم پاسخگویی سرور : شناسه نامعتبر");
          }

          if(dioError.response!.statusCode == 500 || dioError.response!.statusCode == 501 || dioError.response!.statusCode == 502){
            return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          }
          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if(dioError.response!.statusCode == 400){
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }




          MainErrorModel mainErrorModel =
              MainErrorModel.fromJson(dioError.response!.data);
          if (mainErrorModel.errors != null &&
              mainErrorModel.errors?.length != 0)
            return DataFailed(mainErrorModel.errors![0].message.toString());
          else
            return DataFailed("خطای ناشناخته ، لطفاً دوباره تلاش کنید");
        } else {
          return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
        }
      }

      return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
    }
  }

  @override
  Future<DataState<VerifyOtpCodeEntity>> doVerifyOtpCodeOperation(
      String phoneNumber, int otpCode) async {
    try {
      Response response =
          await apiProviderLogin.callVerifyOtpCode(phoneNumber, otpCode);

      if (response.statusCode == 200) {
        VerifyOtpCodeEntity verifyOtpCodeEntity =
            VerifyOtpCodeModel.fromJson(response.data);
        return DataSuccess(verifyOtpCodeEntity);
      } else {
        return DataFailed(
            "خطای ارتباط با سرور - کد خطا : ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        DioError dioError = e as DioError;
        if (dioError.response != null) {


          if(dioError.response!.statusCode == 401){
            return DataFailed("عدم پاسخگویی سرور : شناسه نامعتبر");
          }

          if(dioError.response!.statusCode == 500|| dioError.response!.statusCode == 501 || dioError.response!.statusCode == 502){
            return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if(dioError.response!.statusCode == 400){
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }



          MainErrorModel mainErrorModel =
              MainErrorModel.fromJson(dioError.response!.data);
          if (mainErrorModel.errors != null &&
              mainErrorModel.errors?.length != 0)
            return DataFailed(mainErrorModel.errors![0].message.toString());
          else
            return DataFailed("خطای ناشناخته ، لطفاً دوباره تلاش کنید");
        } else {
          return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
        }
      }

      return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
    }
  }
}
