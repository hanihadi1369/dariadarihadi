import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/send_otp_code_entity.dart';
import '../repository/login_repository.dart';

class SendOtpCodeUseCase extends UseCase<DataState<SendOtpCodeEntity>,String> {
  final LoginRepository loginRepository;


  SendOtpCodeUseCase(this.loginRepository);

  @override
  Future<DataState<SendOtpCodeEntity>> call(String phoneNumber) {
    return loginRepository.doSendOtpCodeOperation(phoneNumber);
  }

}
