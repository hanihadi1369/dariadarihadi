


import 'package:atba_application/features/feature_bill/data/data_source/remote/api_provider_bill.dart';
import 'package:atba_application/features/feature_bill/data/repository/bill_repositoryimpl.dart';
import 'package:atba_application/features/feature_bill/domain/repository/bill_repository.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/mci_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/presentation/block/bill_bloc.dart';
import 'package:atba_application/features/feature_charge_internet/data/data_source/remote/api_provider_charge_internet.dart';
import 'package:atba_application/features/feature_charge_internet/data/repository/charge_internet_repositoryimpl.dart';
import 'package:atba_application/features/feature_charge_internet/domain/repository/charge_internet_repository.dart';
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/buy_internet_package_usecase.dart';
import 'package:atba_application/features/feature_charge_internet/domain/use_cases/show_internet_packages_usecase.dart';
import 'package:atba_application/features/feature_charge_internet/presentation/block/charge_internet_bloc.dart';
import 'package:atba_application/features/feature_login/data/data_source/remote/api_provider_login.dart';
import 'package:atba_application/features/feature_login/data/repository/login_repositoryimpl.dart';
import 'package:atba_application/features/feature_login/domain/repository/login_repository.dart';
import 'package:atba_application/features/feature_login/domain/use_cases/send_otp_code_usecase.dart';
import 'package:atba_application/features/feature_login/domain/use_cases/verify_otp_code_usecase.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:atba_application/features/feature_main/data/data_source/remote/api_provider_main.dart';
import 'package:atba_application/features/feature_main/data/repository/main_repositoryimpl.dart';
import 'package:atba_application/features/feature_main/domain/repository/main_repository.dart';
import 'package:atba_application/features/feature_main/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/main_bloc.dart';
import 'package:atba_application/features/feature_profile/data/repository/profile_repositoryimpl.dart';
import 'package:atba_application/features/feature_profile/domain/repository/profile_repository.dart';
import 'package:atba_application/features/feature_profile/domain/use_cases/update_profile_usecase.dart';
import 'package:atba_application/features/feature_wallet/data/data_source/remote/api_provider_wallet.dart';
import 'package:atba_application/features/feature_wallet/data/repository/wallet_repositoryimpl.dart';
import 'package:atba_application/features/feature_wallet/domain/repository/wallet_repository.dart';
import 'package:atba_application/features/feature_wallet/domain/use_cases/charge_wallet_usecase.dart';
import 'package:atba_application/features/feature_wallet/presentation/block/wallet_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/feature_bill/domain/use_cases/bargh_bill_inquiry_usecase.dart';
import 'features/feature_bill/domain/use_cases/create_bill_usecase.dart';
import 'features/feature_bill/domain/use_cases/delete_bill_usecase.dart';
import 'features/feature_bill/domain/use_cases/fixline_bill_inquiry_usecase.dart';
import 'features/feature_bill/domain/use_cases/gas_bill_inquiry_usecase.dart';
import 'features/feature_bill/domain/use_cases/get_bills_usecase.dart';
import 'features/feature_bill/domain/use_cases/mtn_bill_inquiry_usecase.dart';
import 'features/feature_bill/domain/use_cases/payment_from_wallet_bill_usecase.dart';
import 'features/feature_bill/domain/use_cases/rightel_bill_inquiry_usecase.dart';
import 'features/feature_bill/domain/use_cases/update_bill_usecase.dart';
import 'features/feature_bill/domain/use_cases/water_bill_inquiry_usecase.dart';
import 'features/feature_charge_sim/data/data_source/remote/api_provider_charge_sim.dart';
import 'features/feature_charge_sim/data/repository/csim_repositoryimpl.dart';
import 'features/feature_charge_sim/domain/repository/charge_sim_repository.dart';
import 'features/feature_charge_sim/domain/use_cases/charge_sim_usecase.dart';
import 'features/feature_charge_sim/presentation/block/charge_sim_bloc.dart';
import 'features/feature_main/domain/use_cases/get_profile_usecase.dart';
import 'features/feature_main/domain/use_cases/refresh_token_usecase.dart';
import 'features/feature_profile/data/data_source/remote/api_provider_profile.dart';
import 'features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'features/feature_wallet/domain/use_cases/get_balance_usecase.dart' as wallett;
import 'features/feature_bill/domain/use_cases/get_balance_usecase.dart' as bill;
import 'features/feature_charge_internet/domain/use_cases/get_balance_usecase.dart' as ceeee;
import 'features/feature_charge_sim/domain/use_cases/get_balance_usecase.dart' as cssss;
import 'features/feature_wallet/domain/use_cases/transaction_history_usecase.dart';
import 'features/feature_wallet/domain/use_cases/transfer_kifbkif_usecase.dart';


GetIt locator = GetIt.instance;
setup(){
  locator.registerSingleton<ApiProviderLogin>(ApiProviderLogin());
  locator.registerSingleton<LoginRepository>(LoginRepositoryImpl(locator()));
  locator.registerSingleton<SendOtpCodeUseCase>(SendOtpCodeUseCase(locator()));
  locator.registerSingleton<VerifyOtpCodeUseCase>(VerifyOtpCodeUseCase(locator()));
  locator.registerSingleton<LoginBloc>(LoginBloc(locator(),locator()));




  locator.registerSingleton<ApiProviderMain>(ApiProviderMain());
  locator.registerSingleton<MainRepository>(MainRepositoryImpl(locator()));
  locator.registerSingleton<GetBalanceUseCase>(GetBalanceUseCase(locator()));
  locator.registerSingleton<GetProfileUseCase>(GetProfileUseCase(locator()));
  locator.registerSingleton<RefreshTokenUseCase>(RefreshTokenUseCase(locator()));
  locator.registerSingleton<MainBloc>(MainBloc(locator(),locator(),locator()));

  locator.registerSingleton<ApiProviderProfile>(ApiProviderProfile());
  locator.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(locator()));
  locator.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase(locator()));
  locator.registerSingleton<ProfileBloc>(ProfileBloc(locator()));




  locator.registerSingleton<ApiProviderWallet>(ApiProviderWallet());
  locator.registerSingleton<WalletRepository>(WalletRepositoryImpl(locator()));
  locator.registerSingleton<ChargeWalletUseCase>(ChargeWalletUseCase(locator()));
  locator.registerSingleton<TransferKifBKifUseCase>(TransferKifBKifUseCase(locator()));
  locator.registerSingleton<TransactionHistoryUseCase>(TransactionHistoryUseCase(locator()));
  locator.registerSingleton<wallett.GetBalanceUseCase>(wallett.GetBalanceUseCase(locator()));
  locator.registerSingleton<WalletBloc>(WalletBloc(locator(),locator(),locator(),locator()));



  locator.registerSingleton<ApiProviderBill>(ApiProviderBill());
  locator.registerSingleton<BillRepository>(BillRepositoryImpl(locator()));
  locator.registerSingleton<GetBillsUseCase>(GetBillsUseCase(locator()));
  locator.registerSingleton<CreateBillUseCase>(CreateBillUseCase(locator()));
  locator.registerSingleton<UpdateBillUseCase>(UpdateBillUseCase(locator()));
  locator.registerSingleton<DeleteBillUseCase>(DeleteBillUseCase(locator()));
  locator.registerSingleton<BarghBillInquiryUseCase>(BarghBillInquiryUseCase(locator()));
  locator.registerSingleton<WaterBillInquiryUseCase>(WaterBillInquiryUseCase(locator()));
  locator.registerSingleton<GasBillInquiryUseCase>(GasBillInquiryUseCase(locator()));
  locator.registerSingleton<FixLineBillInquiryUseCase>(FixLineBillInquiryUseCase(locator()));
  locator.registerSingleton<MciBillInquiryUseCase>(MciBillInquiryUseCase(locator()));
  locator.registerSingleton<MtnBillInquiryUseCase>(MtnBillInquiryUseCase(locator()));
  locator.registerSingleton<RightelBillInquiryUseCase>(RightelBillInquiryUseCase(locator()));
  locator.registerSingleton<PaymentFromWalletBillUseCase>(PaymentFromWalletBillUseCase(locator()));
  locator.registerSingleton<bill.GetBalanceUseCase>(bill.GetBalanceUseCase(locator()));
  locator.registerSingleton<BillBloc>(BillBloc(locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator(),locator()));


  locator.registerSingleton<ApiProviderChargeInternet>(ApiProviderChargeInternet());
  locator.registerSingleton<ChargeInternetRepository>(ChargeInternetRepositoryImpl(locator()));
  locator.registerSingleton<ShowInternetPackagesUseCase>(ShowInternetPackagesUseCase(locator()));
  locator.registerSingleton<BuyInternetPackageUseCase>(BuyInternetPackageUseCase(locator()));
  locator.registerSingleton<ceeee.GetBalanceUseCase>(ceeee.GetBalanceUseCase(locator()));
  locator.registerSingleton<ChargeInternetBloc>(ChargeInternetBloc(locator(),locator(),locator()));


  locator.registerSingleton<ApiProviderChargeSimCard>(ApiProviderChargeSimCard());
  locator.registerSingleton<ChargeSimRepository>(ChargeSimRepositoryImpl(locator()));
  locator.registerSingleton<ChargeSimUseCase>(ChargeSimUseCase(locator()));
  locator.registerSingleton<cssss.GetBalanceUseCase>(cssss.GetBalanceUseCase(locator()));
  locator.registerSingleton<ChargeSimBloc>(ChargeSimBloc(locator(),locator()));





}