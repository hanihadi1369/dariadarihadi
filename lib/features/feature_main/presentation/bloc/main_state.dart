part of 'main_bloc.dart';



class MainState{
  BalanceStatus balanceStatus;
  ProfileStatus profileStatus;



  MainState({required this.balanceStatus , required this.profileStatus});

  MainState copyWith({BalanceStatus? newBalanceStatus,ProfileStatus? newProfileStatus}){

    return MainState(
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        profileStatus: newProfileStatus ?? this.profileStatus

    );
  }


}