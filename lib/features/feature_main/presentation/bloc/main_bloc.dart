import 'dart:async';

import 'package:atba_application/features/feature_login/presentation/bloc/login_page_index_status.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/send_otp_status.dart';
import 'package:atba_application/features/feature_main/presentation/bloc/refresh_token_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/params/verify_otp_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/get_balance_usecase.dart';
import '../../domain/use_cases/get_profile_usecase.dart';
import '../../domain/use_cases/refresh_token_usecase.dart';
import 'balance_status.dart';
import 'profile_status.dart';


part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetBalanceUseCase getBalanceUseCase;
  final GetProfileUseCase getProfileUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;


  MainBloc(this.getBalanceUseCase ,  this.getProfileUseCase , this.refreshTokenUseCase) : super(MainState(balanceStatus: BalanceInit() , profileStatus: ProfileInit(),refreshTokenStatus: RefreshTokenInit())) {

    on<GetBalanceEvent>((event, emit) async {

      emit(state.copyWith(newBalanceStatus: BalanceLoading()));

      DataState dataState = await getBalanceUseCase("");

      if(dataState is DataSuccess){
        emit(state.copyWith(newBalanceStatus: BalanceCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newBalanceStatus: BalanceError(dataState.error!)));
      }
    });


    on<GetProfileEvent>((event, emit) async {

      emit(state.copyWith(newProfileStatus: ProfileLoading()));

      DataState dataState = await getProfileUseCase("");

      if(dataState is DataSuccess){
        emit(state.copyWith(newProfileStatus: ProfileCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newProfileStatus: ProfileError(dataState.error!)));
      }
    });




    on<RefreshTokenEvent>((event, emit) async {

      emit(state.copyWith(newRefreshTokenStatus: RefreshTokenLoading()));

      DataState dataState = await refreshTokenUseCase(event.refreshToken);

      if(dataState is DataSuccess){
        emit(state.copyWith(newRefreshTokenStatus: RefreshTokenCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newRefreshTokenStatus: RefreshTokenError(dataState.error!)));
      }
    });





  }
}
