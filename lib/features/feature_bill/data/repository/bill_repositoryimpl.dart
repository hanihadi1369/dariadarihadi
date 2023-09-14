import 'package:atba_application/features/feature_bill/data/data_source/remote/api_provider_bill.dart';
import 'package:atba_application/features/feature_bill/data/models/get_balance_model_bill.dart';
import 'package:atba_application/features/feature_bill/data/models/get_bills_model.dart';
import 'package:atba_application/features/feature_bill/data/models/mci_bill_inquiry_model.dart';
import 'package:atba_application/features/feature_bill/data/models/mtn_bill_inquiry_model.dart';
import 'package:atba_application/features/feature_bill/data/models/rightel_bill_inquiry_model.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_balance_entity_bill.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/repository/bill_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/general/general_response_entity.dart';
import '../../../../core/general/general_response_model.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/error_model.dart';
import '../../domain/entities/bargh_bill_inquiry_entity.dart';
import '../../domain/entities/fixline_bill_inquiry_entity.dart';
import '../../domain/entities/gas_bill_inquiry_entity.dart';
import '../../domain/entities/get_bills_entity.dart';
import '../../domain/entities/payment_from_wallet_entity.dart';
import '../../domain/entities/water_bill_inquiry_entity.dart';
import '../models/bargh_bill_inquiry_model.dart';
import '../models/fixline_bill_inquiry_model.dart';
import '../models/gas_bill_inquiry_model.dart';
import '../models/payment_from_wallet_model.dart';
import '../models/water_bill_inquiry_model.dart';

class BillRepositoryImpl extends BillRepository {
  ApiProviderBill apiProviderBill;

  BillRepositoryImpl(this.apiProviderBill);

  @override
  Future<DataState<GetBillsEntity>> getBillsOperation() async {
    try {
      Response response = await apiProviderBill.callGetBills();

      if (response.statusCode == 200) {
        GetBillsEntity getBillsEntity = GetBillsModel.fromJson(response.data);
        return DataSuccess(getBillsEntity);
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
  Future<DataState<GeneralResponseEntity>> createBillOperation(
      int billType, String billCode, String billTitle) async {
    try {
      Response response =
          await apiProviderBill.callCreateBill(billType, billCode, billTitle);

      if (response.statusCode == 200) {
        GeneralResponseEntity generalResponseEntity =
            GeneralResponseModel.fromJson(response.data);
        return DataSuccess(generalResponseEntity);
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
  Future<DataState<GeneralResponseEntity>> deleteBillOperation(
      String billId) async {
    try {
      Response response = await apiProviderBill.callDeleteBill(billId);

      if (response.statusCode == 200) {
        GeneralResponseEntity generalResponseEntity =
            GeneralResponseModel.fromJson(response.data);
        return DataSuccess(generalResponseEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<GeneralResponseEntity>> updateBillOperation(
      String billId, int billType, String billCode, String billTitle) async {
    try {
      Response response = await apiProviderBill.callUpdateBill(
          billId, billType, billCode, billTitle);

      if (response.statusCode == 200) {
        GeneralResponseEntity generalResponseEntity =
            GeneralResponseModel.fromJson(response.data);
        return DataSuccess(generalResponseEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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

  //*************************************************************************************
  //*************************************************************************************
  //*************************************************************************************

  @override
  Future<DataState<BarghBillInquiryEntity>> barghBillInquiryOperation(
      String electricityBillID, String traceNumber) async {
    try {
      Response response = await apiProviderBill.callBarghBillInquiry(
          electricityBillID, traceNumber);

      if (response.statusCode == 200) {
        BarghBillInquiryEntity barghBillInquiryEntity =
            BarghBillInquiryModel.fromJson(response.data);
        return DataSuccess(barghBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<FixLineBillInquiryEntity>> fixLineBillInquiryOperation(
      String fixedLineNumber, String traceNumber) async {
    try {
      Response response = await apiProviderBill.callFixLineBillInquiry(
          fixedLineNumber, traceNumber);

      if (response.statusCode == 200) {
        FixLineBillInquiryEntity fixLineBillInquiryEntity =
            FixLineBillInquiryModel.fromJson(response.data);
        return DataSuccess(fixLineBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<GasBillInquiryEntity>> gasBillInquiryOperation(
      String participateCode, String gasBillID, String traceNumber) async {
    try {
      Response response = await apiProviderBill.callGasBillInquiry(
          participateCode, gasBillID, traceNumber);

      if (response.statusCode == 200) {
        GasBillInquiryEntity gasBillInquiryEntity =
            GasBillInquiryModel.fromJson(response.data);
        return DataSuccess(gasBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<PaymentFromWalletEntity>> paymentFromWalletOperation(
      String myRequestBody) async {
    try {
      Response response =
          await apiProviderBill.callBillPaymentFromWallet(myRequestBody);

      if (response.statusCode == 200) {
        PaymentFromWalletEntity paymentFromWalletEntity =
            PaymentFromWalletModel.fromJson(response.data);
        return DataSuccess(paymentFromWalletEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<WaterBillInquiryEntity>> waterBillInquiryOperation(
      String waterBillID, String traceNumber) async {
    try {
      Response response =
          await apiProviderBill.callWaterBillInquiry(waterBillID, traceNumber);

      if (response.statusCode == 200) {
        WaterBillInquiryEntity waterBillInquiryEntity =
            WaterBillInquiryModel.fromJson(response.data);
        return DataSuccess(waterBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<MciBillInquiryEntity>> mciBillInquiryOperation(
      String mobileNumber, String traceNumber) async {
    try {
      Response response =
      await apiProviderBill.callMCIMobileBillInquiry(mobileNumber, traceNumber);

      if (response.statusCode == 200) {
        MciBillInquiryEntity mciBillInquiryEntity =
        MciBillInquiryModel.fromJson(response.data);
        return DataSuccess(mciBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<MtnBillInquiryEntity>> mtnBillInquiryOperation(
      String mobileNumber, String traceNumber) async {
    try {
      Response response =
      await apiProviderBill.callMtnMobileBillInquiry(mobileNumber, traceNumber);

      if (response.statusCode == 200) {
        MtnBillInquiryEntity mtnBillInquiryEntity =
        MtnBillInquiryModel.fromJson(response.data);
        return DataSuccess(mtnBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
  Future<DataState<RightelBillInquiryEntity>> rightelBillInquiryOperation(
      String mobileNumber, String traceNumber) async {
    try {
      Response response =
      await apiProviderBill.callRightelMobileBillInquiry(mobileNumber, traceNumber);

      if (response.statusCode == 200) {
        RightelBillInquiryEntity rightelBillInquiryEntity =
        RightelBillInquiryModel.fromJson(response.data);
        return DataSuccess(rightelBillInquiryEntity);
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

          //if (dioError.response!.statusCode == 500) {
          //           return DataFailed("عدم پاسخگویی سرور : خطای داخلی");
          //      }

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
      Response response = await apiProviderBill.callGetBalance();

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
