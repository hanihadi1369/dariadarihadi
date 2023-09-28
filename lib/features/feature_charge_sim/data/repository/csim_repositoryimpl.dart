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
import '../../domain/entities/get_balance_entity_csim.dart';
import '../models/charge_sim_model.dart';
import '../models/get_balance_model_csim.dart';

class ChargeSimRepositoryImpl extends ChargeSimRepository {
  ApiProviderChargeSimCard apiProviderChargeSimCard;

  ChargeSimRepositoryImpl(this.apiProviderChargeSimCard);

  @override
  Future<DataState<ChargeSimEntity>> chargeSimOperation(int totalAmount,
      String cellNumber, int operatorType, int simCardType) async {
    try {
      Response response = await apiProviderChargeSimCard.callChargeSim(
          totalAmount, cellNumber, operatorType, simCardType);

      if (response.statusCode == 200) {
        ChargeSimEntity chargeSimEntity =
            ChargeSimModel.fromJson(response.data);
        return DataSuccess(chargeSimEntity);
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
      Response response = await apiProviderChargeSimCard.callGetBalance();

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

          if(dioError.response!.statusCode == 500 || dioError.response!.statusCode == 501 || dioError.response!.statusCode == 502){
            return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          }
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
