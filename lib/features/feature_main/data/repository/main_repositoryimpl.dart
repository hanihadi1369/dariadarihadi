import 'package:atba_application/features/feature_main/domain/repository/main_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/error_model.dart';
import '../../domain/entities/get_balance_entity.dart';
import '../data_source/remote/api_provider_main.dart';
import '../models/get_balance_model.dart';


class MainRepositoryImpl extends MainRepository{

  ApiProviderMain apiProviderMain;


  MainRepositoryImpl(this.apiProviderMain);



  @override
  Future<DataState<GetBalanceEntity>> getBalanceOperation() async {
    try {
      Response response = await apiProviderMain.callGetBalance();

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

          if(dioError.response!.statusCode == 500){
            return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          }




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