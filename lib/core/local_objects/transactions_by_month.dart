import 'package:atba_application/features/feature_wallet/data/models/transactions_history_model.dart';

class TransactionsByMonth{
  int? idOrder; //(1,2,3,...,12)
  String? yearName;
  String? monthName;
  String? monthName2Digit;
  int? monthId;
  List<Statement>? statement;
  bool selected = false;






  double totalVariz = 0;
  double totalBardasht = 0;

  double totalKifKifVariz = 0;
  double totalChargeFromWeb = 0;

  double totalKifKifBardasht = 0;
  double totalInternetPackageBuy = 0;
  double totalChargeSimBuy = 0;
  double totalBillsPay = 0;

  bool inComeSelectedForChart = false;










}