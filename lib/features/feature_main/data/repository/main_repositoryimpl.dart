import 'package:atba_application/features/feature_main/data/models/get_profile_model.dart';
import 'package:atba_application/features/feature_main/domain/entities/refresh_token_entity.dart';
import 'package:atba_application/features/feature_main/domain/repository/main_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/error_model.dart';
import '../../domain/entities/get_balance_entity.dart';
import '../../domain/entities/get_profile_entity.dart';
import '../data_source/remote/api_provider_main.dart';
import '../models/get_balance_model.dart';
import '../models/refresh_token_model.dart';

class MainRepositoryImpl extends MainRepository {
  ApiProviderMain apiProviderMain;

  MainRepositoryImpl(this.apiProviderMain);

  @override
  Future<DataState<GetBalanceEntity>> getBalanceOperation() async {
    try {
      Response response = await apiProviderMain.callGetBalance();

      if (response.statusCode == 200) {
        GetBalanceEntity getBalanceEntity =
            GetBalanceModel.fromJson(response.data);
        return DataSuccess(getBalanceEntity);
      } else {
        return DataFailed(
            "خطای ارتباط با سرور - کد خطا : ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        DioError dioError = e as DioError;

        if (dioError.response != null) {
          if (dioError.response!.statusCode == 401) {
            return DataFailed("عدم پاسخگویی سرور : شناسه نامعتبر");
          }

          // if(dioError.response!.statusCode == 500){
          //   return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          // }
          //
          // if(dioError.response!.statusCode == 400){
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          // if (dioError.response!.statusCode == 405) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          // }
          // if(dioError.response!.statusCode == 404){
          //   return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          // }

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
  Future<DataState<GetProfileEntity>> getProfileOperation() async {
    try {
      Response response = await apiProviderMain.callGetMyProfile();

      if (response.statusCode == 200) {
        GetProfileEntity getProfileEntity =
            GetProfileModel.fromJson(response.data);
        return DataSuccess(getProfileEntity);
      } else {
        return DataFailed(
            "خطای ارتباط با سرور - کد خطا : ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        DioError dioError = e as DioError;

        if (dioError.response != null) {
          if (dioError.response!.statusCode == 401) {
            return DataFailed("عدم پاسخگویی سرور : شناسه نامعتبر");
          }

          // if(dioError.response!.statusCode == 500){
          //   return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          // }
          //
          // if(dioError.response!.statusCode == 400){
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          // if (dioError.response!.statusCode == 405) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          // }
          // if(dioError.response!.statusCode == 404){
          //   return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          // }

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
  Future<DataState<RefreshTokenEntity>> refreshTokenOperation(
      String refreshToken) async {
    try {
      Response response = await apiProviderMain.callRefreshToken(refreshToken);

      if (response.statusCode == 200) {
        RefreshTokenEntity refreshTokenEntity =
            RefreshTokenModel.fromJson(response.data);
        return DataSuccess(refreshTokenEntity);
      }
    } catch (e) {}

    return DataFailed("***");
  }
}
