part of 'charge_internet_bloc.dart';




@immutable
abstract class ChargeInternetEvent {}




class ShowInternetPackagesEvent extends ChargeInternetEvent{
 final ShowInternetPackagesParam showInternetPackagesParam;
 ShowInternetPackagesEvent(this.showInternetPackagesParam);
}



class BuyInternetPackagesEvent extends ChargeInternetEvent{
 final BuyInternetPackageParam buyInternetPackageParam;
 BuyInternetPackagesEvent(this.buyInternetPackageParam);
}




class GetBalanceEvent extends ChargeInternetEvent{
 GetBalanceEvent();
}


class GetWageApprotionsEvent extends ChargeInternetEvent{
 final GetWageApprotionsParam getWageApprotionsParam;
 GetWageApprotionsEvent(this.getWageApprotionsParam);
}

