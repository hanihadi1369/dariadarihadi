
import '../../../../core/resources/data_state.dart';
import '../entities/send_otp_code_entity.dart';
import '../entities/verify_otp_code_entity.dart';

abstract class LoginRepository{

  Future<DataState<SendOtpCodeEntity>> doSendOtpCodeOperation(String phoneNumber);

  Future<DataState<VerifyOtpCodeEntity>> doVerifyOtpCodeOperation(String phoneNumber,int otpCode);


}