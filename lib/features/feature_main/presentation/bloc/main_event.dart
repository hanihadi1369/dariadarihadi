part of 'main_bloc.dart';



@immutable
abstract class MainEvent {}



class GetBalanceEvent extends MainEvent{
  GetBalanceEvent();
}



class GetProfileEvent extends MainEvent{
  GetProfileEvent();
}