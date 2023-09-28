import 'dart:ffi';

import 'package:atba_application/core/params/update_profile_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_profile/domain/repository/profile_repository.dart';

import '../entities/update_profile_entity.dart';






class UpdateProfileUseCase extends UseCase<DataState<UpdateProfileEntity>,UpdateProfileParam> {
  final ProfileRepository profileRepository;


  UpdateProfileUseCase(this.profileRepository);

  @override
  Future<DataState<UpdateProfileEntity>> call(UpdateProfileParam updateProfileParam) {
    return profileRepository.updateProfileOperation(
      updateProfileParam.firstName,
      updateProfileParam.lastName,
      updateProfileParam.nationalCode,
      updateProfileParam.email,
      updateProfileParam.shaba,


    );
  }

}
