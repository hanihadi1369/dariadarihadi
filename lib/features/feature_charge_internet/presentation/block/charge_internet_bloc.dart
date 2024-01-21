import 'dart:async';



import 'package:atba_application/core/params/charge_sim_param.dart';
import 'package:atba_application/core/params/get_wage_approtions_param.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import '../../../../core/params/buy_internet_package_param.dart';
import '../../../../core/params/show_internet_packages_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/buy_internet_package_usecase.dart';
import '../../domain/use_cases/get_balance_usecase.dart';
import '../../domain/use_cases/get_wage_approtions_usecase.dart';
import '../../domain/use_cases/show_internet_packages_usecase.dart';
import 'balance_status_cinternet.dart';
import 'buy_internet_package_status.dart';
import 'get_wage_approtions_cinternet_status.dart';
import 'show_internet_packages_status.dart';




part 'charge_internet_state.dart';
part 'charge_internet_event.dart';


class ChargeInternetBloc extends Bloc<ChargeInternetEvent, ChargeInternetState> {
  final ShowInternetPackagesUseCase showInternetPackagesUseCase;
  final BuyInternetPackageUseCase buyInternetPackageUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetWageApprotionsUseCase getWageApprotionsUseCase;




  ChargeInternetBloc(
      this.showInternetPackagesUseCase,
      this.buyInternetPackageUseCase,
      this.getBalanceUseCase,
      this.getWageApprotionsUseCase
      ) : super(
      ChargeInternetState(
          showInternetPackagesStatus: ShowInternetPackagesInit(),
          buyInternetPackageStatus: BuyInternetPackageInit(),
          balanceStatus: BalanceInit(),
          getWageApprotionsStatus: GetWageApprotionsInit()
      )) {



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














    on<ShowInternetPackagesEvent>((event, emit) async {

      emit(state.copyWith(newShowInternetPackagesStatus: ShowInternetPackagesLoading()));

      DataState dataState = await showInternetPackagesUseCase(event.showInternetPackagesParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newShowInternetPackagesStatus: ShowInternetPackagesCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newShowInternetPackagesStatus: ShowInternetPackagesError(dataState.error!)));
      }
    });



    on<BuyInternetPackagesEvent>((event, emit) async {

      emit(state.copyWith(newBuyInternetPackageStatus: BuyInternetPackageLoading()));

      DataState dataState = await buyInternetPackageUseCase(event.buyInternetPackageParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newBuyInternetPackageStatus: BuyInternetPackageCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newBuyInternetPackageStatus: BuyInternetPackageError(dataState.error!)));
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




  }
}
