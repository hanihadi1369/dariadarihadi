import 'package:atba_application/features/feature_wallet/data/models/transactions_history_model.dart';

class TransactionsByMonth{
  int? idOrder; //(1,2,3,...,12)
  String? yearName;
  String? monthName;
  String? monthName2Digit;
  int? monthId;
  List<Statement>? statement;
  bool selected = false;
}