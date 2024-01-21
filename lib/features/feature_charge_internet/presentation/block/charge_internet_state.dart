part of 'charge_internet_bloc.dart';

class ChargeInternetState extends Equatable {
  ShowInternetPackagesStatus showInternetPackagesStatus;
  BuyInternetPackageStatus buyInternetPackageStatus;
  BalanceStatus balanceStatus;
  GetWageApprotionsStatus getWageApprotionsStatus;

  ChargeInternetState(
      {required this.showInternetPackagesStatus,
      required this.buyInternetPackageStatus,
      required this.balanceStatus,
      required this.getWageApprotionsStatus});

  @override
  List<Object?> get props => [
        showInternetPackagesStatus,
        buyInternetPackageStatus,
        balanceStatus,
        getWageApprotionsStatus
      ];

  ChargeInternetState copyWith(
      {ShowInternetPackagesStatus? newShowInternetPackagesStatus,
      BuyInternetPackageStatus? newBuyInternetPackageStatus,
      BalanceStatus? newBalanceStatus,
      GetWageApprotionsStatus? newGetWageApprotionsStatus}) {
    return ChargeInternetState(
        showInternetPackagesStatus:
            newShowInternetPackagesStatus ?? this.showInternetPackagesStatus,
        buyInternetPackageStatus:
            newBuyInternetPackageStatus ?? this.buyInternetPackageStatus,
        balanceStatus: newBalanceStatus ?? this.balanceStatus,
        getWageApprotionsStatus:
            newGetWageApprotionsStatus ?? this.getWageApprotionsStatus);
  }
}
