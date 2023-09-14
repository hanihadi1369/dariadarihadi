part of 'charge_internet_bloc.dart';





class ChargeInternetState {
  ShowInternetPackagesStatus showInternetPackagesStatus;
  BuyInternetPackageStatus buyInternetPackageStatus;
  BalanceStatus balanceStatus;

  ChargeInternetState({
    required this.showInternetPackagesStatus,
    required this.buyInternetPackageStatus,
    required this.balanceStatus,

  });

  ChargeInternetState copyWith({
    ShowInternetPackagesStatus? newShowInternetPackagesStatus,
    BuyInternetPackageStatus? newBuyInternetPackageStatus,
    BalanceStatus? newBalanceStatus,
  }) {
    return ChargeInternetState(
      showInternetPackagesStatus: newShowInternetPackagesStatus ?? this.showInternetPackagesStatus,
      buyInternetPackageStatus: newBuyInternetPackageStatus ?? this.buyInternetPackageStatus,
      balanceStatus: newBalanceStatus ?? this.balanceStatus,

    );
  }
}
