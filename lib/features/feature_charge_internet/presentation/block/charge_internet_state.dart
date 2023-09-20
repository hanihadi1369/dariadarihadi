part of 'charge_internet_bloc.dart';





class ChargeInternetState extends Equatable{
  ShowInternetPackagesStatus showInternetPackagesStatus;
  BuyInternetPackageStatus buyInternetPackageStatus;
  BalanceStatus balanceStatus;

  ChargeInternetState({
    required this.showInternetPackagesStatus,
    required this.buyInternetPackageStatus,
    required this.balanceStatus,

  });
  @override
  List<Object?> get props => [
    showInternetPackagesStatus,
    buyInternetPackageStatus,
    balanceStatus
  ];
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
