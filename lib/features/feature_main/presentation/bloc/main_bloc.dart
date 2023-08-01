import 'dart:async';

import 'package:atba_application/features/feature_login/presentation/bloc/page_index_status.dart';
import 'package:atba_application/features/feature_login/presentation/bloc/send_otp_status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/params/verify_otp_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/get_balance_usecase.dart';
import 'balance_status.dart';


part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetBalanceUseCase getBalanceUseCase;


  MainBloc(this.getBalanceUseCase) : super(MainState(balanceStatus: BalanceInit())) {

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











  }
}
