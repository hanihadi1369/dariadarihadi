import 'package:equatable/equatable.dart';
import 'package:atba_application/core/general/general_response_model.dart';



class GeneralResponseEntity extends Equatable {
  final bool? isFailed;
  final bool? isSuccess;
  final List<Reasons>? reasons;
  final List<Errors>? errors;
  final List<Successes>? successes;


  GeneralResponseEntity(
      {this.isFailed,
      this.isSuccess,
      this.reasons,
      this.errors,
      this.successes,
      });

  @override
  List<Object?> get props => [
        isFailed,
        isSuccess,
        reasons,
        errors,
        successes,
      ];
}
