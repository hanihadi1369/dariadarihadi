import '../../../../core/params/verify_otp_param.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/verify_otp_code_entity.dart';
import '../repository/login_repository.dart';

class VerifyOtpCodeUseCase extends UseCase<DataState<VerifyOtpCodeEntity>,VerifyOtpParam> {
  final LoginRepository loginRepository;


  VerifyOtpCodeUseCase(this.loginRepository);

  @override
  Future<DataState<VerifyOtpCodeEntity>> call (VerifyOtpParam verifyOtpParam) {
    return loginRepository.doVerifyOtpCodeOperation(verifyOtpParam.phoneNumber,verifyOtpParam.otpCode);
  }

}
