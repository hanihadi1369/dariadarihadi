part of 'profile_bloc.dart';





@immutable
abstract class ProfileEvent {}




class UpdateProfileEvent extends ProfileEvent{
 final UpdateProfileParam updateProfileParam;
 UpdateProfileEvent(this.updateProfileParam);
}


