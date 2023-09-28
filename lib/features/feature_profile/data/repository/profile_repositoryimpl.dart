import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/utils/error_model.dart';
import 'package:atba_application/features/feature_profile/data/data_source/remote/api_provider_profile.dart';
import 'package:atba_application/features/feature_profile/domain/entities/update_profile_entity.dart';
import 'package:atba_application/features/feature_profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

import '../models/update_profile_model.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ApiProviderProfile apiProviderProfile;

  ProfileRepositoryImpl(this.apiProviderProfile);

  @override
  Future<DataState<UpdateProfileEntity>> updateProfileOperation(
       String firstName,
      String lastName,
      String nationalCode,
      String email,
      String shaba,




      ) async {
    try {
      Response response = await apiProviderProfile.callUpdateMyProfile(firstName,lastName,nationalCode,email,shaba);

      if (response.statusCode == 200) {
        UpdateProfileEntity updateProfileEntity =
        UpdateProfileModel.fromJson(response.data);
        return DataSuccess(updateProfileEntity);
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

          if (dioError.response!.statusCode == 500 || dioError.response!.statusCode == 501 || dioError.response!.statusCode == 502) {
                    return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
               }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          if (dioError.response!.statusCode == 404) {
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }

          // if (dioError.response!.statusCode == 400) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
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

}
