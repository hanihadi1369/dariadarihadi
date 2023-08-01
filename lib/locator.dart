

import 'package:get_it/get_it.dart';

import 'features/feature_login/data/data_source/remote/api_provider_login.dart';
import 'features/feature_login/data/repository/login_repositoryimpl.dart';
import 'features/feature_login/domain/repository/login_repository.dart';
import 'features/feature_login/domain/use_cases/send_otp_code_usecase.dart';
import 'features/feature_login/domain/use_cases/verify_otp_code_usecase.dart';
import 'features/feature_login/presentation/bloc/login_bloc.dart';
import 'features/feature_main/data/data_source/remote/api_provider_main.dart';
import 'features/feature_main/data/repository/main_repositoryimpl.dart';
import 'features/feature_main/domain/repository/main_repository.dart';
import 'features/feature_main/domain/use_cases/get_balance_usecase.dart';
import 'features/feature_main/presentation/bloc/main_bloc.dart';

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
  locator.registerSingleton<MainBloc>(MainBloc(locator()));




}