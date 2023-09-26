



import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/core/usecase/use_case.dart';
import 'package:atba_application/features/feature_main/domain/entities/refresh_token_entity.dart';
import 'package:atba_application/features/feature_main/domain/repository/main_repository.dart';

class RefreshTokenUseCase extends UseCase<DataState<RefreshTokenEntity>,String> {
  final MainRepository mainRepository;


  RefreshTokenUseCase(this.mainRepository);

  @override
  Future<DataState<RefreshTokenEntity>> call(String refreshToken) {
    return mainRepository.refreshTokenOperation(refreshToken);
  }

}
