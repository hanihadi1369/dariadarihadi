



import 'package:atba_application/core/resources/data_state.dart';

import '../entities/update_profile_entity.dart';

abstract class ProfileRepository{


  Future<DataState<UpdateProfileEntity>> updateProfileOperation(
      String firstName,
      String lastName,

      String nationalCode,
      String email,
      String shaba



      );



}