part of 'profile_bloc.dart';

class ProfileState extends Equatable {

  UpdateProfileStatus updateProfileStatus;


  ProfileState({

    required this.updateProfileStatus,

  });


  @override
  List<Object?> get props => [

   updateProfileStatus,

  ];

  ProfileState copyWith({

    UpdateProfileStatus? newUpdateProfileStatus,

  }) {
    return ProfileState(

      updateProfileStatus: newUpdateProfileStatus ?? this.updateProfileStatus,

    );
  }
}
