part of 'main_bloc.dart';



class MainState extends Equatable{
  BalanceStatus balanceStatus;
  ProfileStatus profileStatus;

  @override
  List<Object?> get props => [balanceStatus,profileStatus];

  MainState({required this.balanceStatus , required this.profileStatus});

  MainState copyWith({BalanceStatus? newBalanceStatus,ProfileStatus? newProfileStatus}){

    return MainState(
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        profileStatus: newProfileStatus ?? this.profileStatus

    );
  }


}