import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/utils/error_model.dart';
import 'package:atba_application/features/feature_wallet/data/data_source/remote/api_provider_wallet.dart';
import 'package:atba_application/features/feature_wallet/data/models/charge_wallet_model.dart';
import 'package:atba_application/features/feature_wallet/data/models/get_balance_model_wallet.dart';
import 'package:atba_application/features/feature_wallet/data/models/transactions_history_model.dart';
import 'package:atba_application/features/feature_wallet/data/models/transfer_kifbkif_model.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/charge_wallet_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/get_balance_entity_wallet.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transactions_history_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/entities/transfer_kifbkif_entity.dart';
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart';
import 'package:dio/dio.dart';




class WalletRepositoryImpl extends WalletRepository {
  ApiProviderWallet apiProviderWallet;

  WalletRepositoryImpl(this.apiProviderWallet);


  @override
  Future<DataState<ChargeWalletEntity>> doChargeWalletOperation(
      int  amount,String redirectedUrl) async {
    try {
      Response response =
          await apiProviderWallet.callChargeWallet(amount, redirectedUrl);

      if (response.statusCode == 200) {
        ChargeWalletEntity chargeWalletEntity =
        ChargeWalletModel.fromJson(response.data);
        return DataSuccess(chargeWalletEntity);
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
          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }
          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if(dioError.response!.statusCode == 400){
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


  @override
  Future<DataState<GetBalanceEntity>> getBalanceOperation() async {
    try {
      Response response = await apiProviderWallet.callGetBalance();

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

          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
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



  @override
  Future<DataState<TransferKifBKifEntity>> doTransferKifBKifOperation(
      int  amount,String mobileNumber) async {
    try {
      Response response =
      await apiProviderWallet.callDoTransfer(amount, mobileNumber);

      if (response.statusCode == 200) {
        TransferKifBKifEntity transferKifBKifEntity =
        TransferKifBKifModel.fromJson(response.data);
        return DataSuccess(transferKifBKifEntity);
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
          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if(dioError.response!.statusCode == 400){
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

  @override
  Future<DataState<TransactionsHistoryEntity>> getTransactionsHistoryOperation(
      String  dateFrom,String dateTo) async {
    try {
      Response response =
      await apiProviderWallet.callWalletTransactionsHistory(dateFrom, dateTo);

      if (response.statusCode == 200) {
        TransactionsHistoryEntity transactionsHistoryEntity =
        TransactionsHistoryModel.fromJson(response.data);
        return DataSuccess(transactionsHistoryEntity);
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
          if(dioError.response!.statusCode == 404){
            return DataFailed("عدم پاسخگویی سرور : شناسه یافت نشد");
          }

          if (dioError.response!.statusCode == 405) {
            return DataFailed("عدم پاسخگویی سرور : خطای شماره 405");
          }
          // if(dioError.response!.statusCode == 400){
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
