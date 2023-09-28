

import 'package:atba_application/core/params/update_profile_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_profile/domain/use_cases/update_profile_usecase.dart';
import 'package:atba_application/features/feature_profile/presentation/bloc/update_profile_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final UpdateProfileUseCase updateProfileUseCase;


  ProfileBloc(

      this.updateProfileUseCase,

      ) : super(
      ProfileState(

          updateProfileStatus: UpdateProfileInit(),

      )) {

















    on<UpdateProfileEvent>((event, emit) async {

      emit(state.copyWith(newUpdateProfileStatus: UpdateProfileLoading()));

      DataState dataState = await updateProfileUseCase(event.updateProfileParam);

      if(dataState is DataSuccess){
        emit(state.copyWith(newUpdateProfileStatus: UpdateProfileCompleted(dataState.data)));
      }

      if(dataState is DataFailed){
        emit(state.copyWith(newUpdateProfileStatus: UpdateProfileError(dataState.error!)));
      }
    });




























































  }
}
