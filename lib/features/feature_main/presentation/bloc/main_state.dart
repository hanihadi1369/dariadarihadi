part of 'main_bloc.dart';



class MainState{
  BalanceStatus balanceStatus;



  MainState({required this.balanceStatus});

  MainState copyWith({BalanceStatus? newBalanceStatus}){

    return MainState(
        balanceStatus: newBalanceStatus ?? this.balanceStatus,

    );
  }


}