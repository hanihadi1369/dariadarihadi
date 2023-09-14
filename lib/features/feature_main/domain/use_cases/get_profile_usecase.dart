import 'dart:ffi';


import 'package:atba_application/features/feature_main/domain/entities/get_profile_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/main_repository.dart';


class GetProfileUseCase extends UseCase<DataState<GetProfileEntity>,String> {
  final MainRepository mainRepository;


  GetProfileUseCase(this.mainRepository);

  @override
  Future<DataState<GetProfileEntity>> call(Void) {
    return mainRepository.getProfileOperation();
  }

}
