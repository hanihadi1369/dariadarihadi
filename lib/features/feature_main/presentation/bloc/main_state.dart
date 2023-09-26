part of 'main_bloc.dart';



class MainState extends Equatable{
  BalanceStatus balanceStatus;
  ProfileStatus profileStatus;
  RefreshTokenStatus refreshTokenStatus;

  @override
  List<Object?> get props => [balanceStatus,profileStatus,refreshTokenStatus];

  MainState({required this.balanceStatus , required this.profileStatus , required this.refreshTokenStatus});

  MainState copyWith({BalanceStatus? newBalanceStatus,ProfileStatus? newProfileStatus , RefreshTokenStatus? newRefreshTokenStatus}){

    return MainState(
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        profileStatus: newProfileStatus ?? this.profileStatus,
        refreshTokenStatus: newRefreshTokenStatus ?? this.refreshTokenStatus

    );
  }


}