import 'package:atba_application/features/feature_bill/data/data_source/remote/api_provider_bill.dart';
import 'package:atba_application/features/feature_bill/domain/repository/bill_repository.dart';
import 'package:atba_application/features/feature_charge_sim/data/data_source/remote/api_provider_charge_sim.dart';
import 'package:atba_application/features/feature_charge_sim/domain/entities/charge_sim_entity.dart';
import 'package:atba_application/features/feature_charge_sim/domain/repository/charge_sim_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/general/general_response_entity.dart';
import '../../../../core/general/general_response_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/error_model.dart';
import '../../domain/entities/buy_internet_package_entity.dart';
import '../../domain/entities/get_balance_entity_cinternet.dart';
import '../../domain/entities/show_internet_packages_entity.dart';
import '../../domain/repository/charge_internet_repository.dart';
import '../data_source/remote/api_provider_charge_internet.dart';
import '../models/buy_internet_package_model.dart';
import '../models/get_balance_model_cinternet.dart';
import '../models/show_internet_packages_model.dart';

class ChargeInternetRepositoryImpl extends ChargeInternetRepository {
  ApiProviderChargeInternet apiProviderChargeInternet;

  ChargeInternetRepositoryImpl(this.apiProviderChargeInternet);

  @override
  Future<DataState<ShowInternetPackagesEntity>> showInternetPackagesOperation(
      int operatorType, String mobile) async {
    try {
      Response response = await apiProviderChargeInternet
          .callShowInternetPackage(operatorType, mobile);

      if (response.statusCode == 200) {
        ShowInternetPackagesEntity showInternetPackagesEntity =
            ShowInternetPackagesModel.fromJson(response.data);
        return DataSuccess(showInternetPackagesEntity);
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

          // if (dioError.response!.statusCode == 500) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          // }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if (dioError.response!.statusCode == 400) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          if (dioError.response!.statusCode == 404) {
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
  Future<DataState<BuyInternetPackageEntity>> buyInternetPackageOperation(
    String bundleId,
    String amount,
    String cellNumber,
    String requestId,
    int operatorType,
    int operationCode,
    int type,
  ) async {
    try {
      Response response =
          await apiProviderChargeInternet.callBuyInternetPackage(bundleId,
              amount, cellNumber, requestId, operatorType, operationCode, type);

      if (response.statusCode == 200) {
        BuyInternetPackageEntity buyInternetPackageEntity =
            BuyInternetPackageModel.fromJson(response.data);
        return DataSuccess(buyInternetPackageEntity);
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

          // if (dioError.response!.statusCode == 500) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          // }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if (dioError.response!.statusCode == 400) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }
          if (dioError.response!.statusCode == 404) {
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
  Future<DataState<GetBalanceEntity>> getBalanceOperation() async {
    try {
      Response response = await apiProviderChargeInternet.callGetBalance();

      if (response.statusCode == 200) {
        GetBalanceEntity getBalanceEntity = GetBalanceModel.fromJson(
            response.data);
        return DataSuccess(getBalanceEntity);
      } else {
        return DataFailed("خطای ارتباط با سرور - کد خطا : ${response.statusCode}");
      }
    } catch (e) {
      if(e is DioError ){
        DioError dioError = e as DioError;




        if(dioError.response!=null){

          if(dioError.response!.statusCode == 401){
            return DataFailed("عدم پاسخگویی سرور : شناسه نامعتبر");
          }

          // if(dioError.response!.statusCode == 500){
          //   return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          // }
          //
          // if(dioError.response!.statusCode == 404){
          //   return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          // }
          //
          // if (dioError.response!.statusCode == 405) {
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          // }
          // if(dioError.response!.statusCode == 400){
          //   return DataFailed("عدم پاسخگویی سرور : خطای شماره 400");
          // }



          MainErrorModel mainErrorModel = MainErrorModel.fromJson(dioError.response!.data);
          if(mainErrorModel.errors!=null  && mainErrorModel.errors?.length!=0)
            return DataFailed(mainErrorModel.errors![0].message.toString());
          else
            return DataFailed("خطای ناشناخته ، لطفاً دوباره تلاش کنید");
        }else{
          return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
        }

      }



      return DataFailed("لطفاً اتصال اینترنت خود را بررسی نمایید");
    }
  }
}
