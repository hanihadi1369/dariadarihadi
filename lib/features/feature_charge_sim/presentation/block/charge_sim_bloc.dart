import 'dart:async';



import 'package:atba_application/core/params/charge_sim_param.dart';
import 'package:atba_application/core/params/get_wage_approtions_param.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/charge_sim_usecase.dart';

import '../../domain/use_cases/get_balance_usecase.dart';
import '../../domain/use_cases/get_wage_approtions_usecase.dart';
import 'balance_status_csim.dart';
import 'charge_sim_status.dart';
import 'get_wage_approtions_csim_status.dart';



part 'charge_sim_state.dart';
part 'charge_sim_event.dart';


class ChargeSimBloc extends Bloc<ChargeSimEvent, ChargeSimState> {
  final ChargeSimUseCase chargeSimUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetWageApprotionsUseCase getWageApprotionsUseCase;




  ChargeSimBloc(
      this.chargeSimUseCase,
      this.getBalanceUseCase,
      this.getWageApprotionsUseCase
      ) : super(
      ChargeSimState(
          chargeSimStatus: ChargeSimInit(),
        balanceStatus: BalanceInit(),
          getWageApprotionsStatus: GetWageApprotionsInit()
      )) {

    on<ChargeEvent>((event, emit) async {

      emit(state.copyWith(newChargeSimStatus: ChargeSimLoading()));

      DataState dataState = await chargeSimUseCase(event.chargeSimParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newChargeSimStatus: ChargeSimCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newChargeSimStatus: ChargeSimError(dataState.error!)));
      }
    });


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








    on<GetWageApprotionsEvent>((event, emit) async {

      emit(state.copyWith(newGetWageApprotionsStatus: GetWageApprotionsLoading()));

      DataState dataState = await getWageApprotionsUseCase(event.getWageApprotionsParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newGetWageApprotionsStatus:
        GetWageApprotionsCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newGetWageApprotionsStatus: GetWageApprotionsError(dataState.error!)));
      }
    });






  }
}
