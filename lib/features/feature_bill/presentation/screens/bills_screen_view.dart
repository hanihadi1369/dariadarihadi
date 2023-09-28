import 'dart:convert';

import 'package:atba_application/core/params/BillPaymentFromWalletParam.dart';
import 'package:atba_application/core/params/Bills.dart';
import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/core/utils/colors.dart';
import 'package:atba_application/core/utils/token_keeper.dart';
import 'package:atba_application/core/widgets/loading.dart';
import 'package:atba_application/features/feature_bill/presentation/block/bill_bloc.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mci_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mtn_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/rightel_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/update_bill_status.dart';
import 'package:atba_application/features/feature_bill/presentation/widgets/check_box.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/params/bargh_bill_inquiry_param.dart';
import '../../../../core/params/create_bill_param.dart';
import '../../../../core/params/fixline_bill_inquiry_param.dart';
import '../../../../core/params/gas_bill_inquiry_param.dart';
import '../../../../core/params/update_bill_param.dart';
import '../../../../core/params/water_bill_inquiry_param.dart';

import '../../data/models/get_bills_model.dart';
import '../block/statuses/balance_status_bill.dart';
import '../block/statuses/bargh_bill_inquiry_status.dart';
import '../block/statuses/bills_status.dart';
import '../block/statuses/create_bill_status.dart';
import '../block/statuses/delete_bill_status.dart';
import '../block/statuses/fixline_bill_inquiry_status.dart';
import '../block/statuses/gas_bill_inquiry_status.dart';
import '../block/statuses/payment_from_wallet_status.dart';
import '../block/statuses/water_bill_inquiry_status.dart';

import 'package:atba_application/features/feature_bill/data/models/bargh_bill_inquiry_model.dart'
    as barghIM; //(IM >>> Inquiry Model)
import 'package:atba_application/features/feature_bill/data/models/water_bill_inquiry_model.dart'
    as waterIM;
import 'package:atba_application/features/feature_bill/data/models/gas_bill_inquiry_model.dart'
    as gasIM;
import 'package:atba_application/features/feature_bill/data/models/fixline_bill_inquiry_model.dart'
    as fixLineIM;

import 'package:atba_application/features/feature_bill/data/models/mci_bill_inquiry_model.dart'
    as mciIM;

import 'package:atba_application/features/feature_bill/data/models/mtn_bill_inquiry_model.dart'
    as mtnIM;

import 'package:atba_application/features/feature_bill/data/models/rightel_bill_inquiry_model.dart'
    as rightelIM;

import 'package:atba_application/features/feature_bill/data/models/payment_from_wallet_model.dart'
    as paymentFromWalletIM;

class BillsScreenView extends StatefulWidget {
  @override
  _BillsScreenViewState createState() => _BillsScreenViewState();
}

class _BillsScreenViewState extends State<BillsScreenView> {
  List<Value> myBillsList = [];
  List<Value> waterBillsList = [];
  List<Value> barghBillsList = [];
  List<Value> gasBillsList = [];
  List<Value> phoneBillsList = [];
  List<Value> mciBillsList = [];
  List<Value> mtnBillsList = [];
  List<Value> rightelBillsList = [];

  String balance = "***";
  String phoneNumber = "***";
  int payTypeSelected = 1;

  Value selectedBillForUpdate = Value();
  bool isSimpleInquiry = true;

  barghIM.Value barghInquiryResult = barghIM.Value();
  waterIM.Value waterInquiryResult = waterIM.Value();
  gasIM.Value gasInquiryResult = gasIM.Value();
  fixLineIM.Value fixLineInquiryResult = fixLineIM.Value();

  mciIM.Value mciInquiryResult = mciIM.Value();
  mtnIM.Value mtnInquiryResult = mtnIM.Value();
  rightelIM.Value rightelInquiryResult = rightelIM.Value();

  paymentFromWalletIM.Value paymentFromWalletResult =
      paymentFromWalletIM.Value();

  int pageIndex = 1;

  bool _isButtonNextDisabled_water_1 = true;
  bool _isButtonNextDisabled_water_2 = true;
  bool _isButtonNextDisabled_bargh_1 = true;
  bool _isButtonNextDisabled_bargh_2 = true;
  bool _isButtonNextDisabled_gas_1 = true;
  bool _isButtonNextDisabled_gas_2 = true;
  bool _isButtonNextDisabled_phone_1 = true;
  bool _isButtonNextDisabled_phone_2 = true;

  bool _isButtonNextDisabled_mci_1 = true;
  bool _isButtonNextDisabled_mci_2 = true;

  bool _isButtonNextDisabled_mtn_1 = true;
  bool _isButtonNextDisabled_mtn_2 = true;

  bool _isButtonNextDisabled_rightel_1 = true;
  bool _isButtonNextDisabled_rightel_2 = true;

  bool _isButtonNextDisabled_edit = true;

  bool _addToMyBillsList = false;
  bool midTermSelected = false;

  //***************************************************************************

  TextEditingController _editBillController = TextEditingController();
  final _formKey_edit_bill = GlobalKey<FormState>();

  TextEditingController _waterBillController1 = TextEditingController();
  final _formKey_water_bill1 = GlobalKey<FormState>();
  TextEditingController _waterBillController2 = TextEditingController();
  final _formKey_water_bill2 = GlobalKey<FormState>();

  TextEditingController _barghBillController1 = TextEditingController();
  final _formKey_bargh_bill1 = GlobalKey<FormState>();
  TextEditingController _barghBillController2 = TextEditingController();
  final _formKey_bargh_bill2 = GlobalKey<FormState>();

  TextEditingController _gazBillController1 = TextEditingController();
  final _formKey_gaz_bill1 = GlobalKey<FormState>();
  TextEditingController _gazBillController2 = TextEditingController();
  final _formKey_gaz_bill2 = GlobalKey<FormState>();

  TextEditingController _phoneBillController1 = TextEditingController();
  final _formKey_phone_bill1 = GlobalKey<FormState>();
  TextEditingController _phoneBillController2 = TextEditingController();
  final _formKey_phone_bill2 = GlobalKey<FormState>();

  final _formKey_mci_bill1 = GlobalKey<FormState>();
  TextEditingController _mciBillController1 = TextEditingController();
  final _formKey_mci_bill2 = GlobalKey<FormState>();
  TextEditingController _mciBillController2 = TextEditingController();

  final _formKey_mtn_bill1 = GlobalKey<FormState>();
  TextEditingController _mtnBillController1 = TextEditingController();
  final _formKey_mtn_bill2 = GlobalKey<FormState>();
  TextEditingController _mtnBillController2 = TextEditingController();

  final _formKey_rightel_bill1 = GlobalKey<FormState>();
  TextEditingController _rightelBillController1 = TextEditingController();
  final _formKey_rightel_bill2 = GlobalKey<FormState>();
  TextEditingController _rightelBillController2 = TextEditingController();

  int selectedNewBillToAdd =
      0; // >>  0 nothing ,  1 water  ,2   bargh,3   gas , 4  phone ,5 mci ,6 mtn ,7 rightel

  double heightOfModalBottomSheet = 50;

  String orderId = "";

  String getTicketName(int index) {
    if (index == 1) {
      return "تک سفره مشترک مترو و بی آر تی";
    }
    if (index == 2) {
      return "تک سفره کرج";
    }
    if (index == 3) {
      return "تک سفره هشتگرد";
    }
    if (index == 4) {
      return "فرودگاه امام خمینی";
    }

    return "";
  }

  String getTicketLogo(int index) {
    if (index == 1) {
      return "assets/image_icon/metro_icon.png";
    }
    if (index == 2) {
      return "assets/image_icon/train_icon.png";
    }
    if (index == 3) {
      return "assets/image_icon/train_icon.png";
    }
    if (index == 4) {
      return "assets/image_icon/airplane_icon.png";
    }

    return "";
  }

  @override
  void initState() {
    super.initState();

    _getPhoneNumber();
    BlocProvider.of<BillBloc>(context).add(GetBillsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if ((pageIndex == 1) ||
            (pageIndex == 11) ||
            (pageIndex == 12) ||
            (pageIndex == 13) ||
            (pageIndex == 14) ||
            (pageIndex == 15) ||
            (pageIndex == 16) ||
            (pageIndex == 17)) {
          Navigator.of(context).pop();
        }

        if (pageIndex == 30 || pageIndex == 2) {
          setState(() {
            pageIndex = 1;
          });
        }

        if ((pageIndex == 31) ||
            (pageIndex == 32) ||
            (pageIndex == 35) ||
            (pageIndex == 36) ||
            (pageIndex == 37) ||
            (pageIndex == 33) ||
            (pageIndex == 34)) {
          setState(() {
            pageIndex = 1;
          });
        }

        if (pageIndex == 311) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 31;
          });
        }
        if (pageIndex == 322) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 32;
          });
        }
        if (pageIndex == 333) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 33;
          });
        }
        if (pageIndex == 344) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 34;
          });
        }
        if (pageIndex == 355) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 35;
          });
        }
        if (pageIndex == 366) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 36;
          });
        }
        if (pageIndex == 377) {
          setState(() {
            _addToMyBillsList = false;
            pageIndex = 37;
          });
        }

        if (pageIndex == 3111 || pageIndex == 301) {
          setState(() {
            _addToMyBillsList = false;
            _waterBillController1.text = "";
            _waterBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3222 || pageIndex == 302) {
          setState(() {
            _addToMyBillsList = false;
            _barghBillController1.text = "";
            _barghBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3333 || pageIndex == 303) {
          setState(() {
            _addToMyBillsList = false;
            _gazBillController1.text = "";
            _gazBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3444 || pageIndex == 304) {
          setState(() {
            _addToMyBillsList = false;
            _phoneBillController1.text = "";
            _phoneBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3555 || pageIndex == 305) {
          setState(() {
            _addToMyBillsList = false;
            _mciBillController1.text = "";
            _mciBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3666 || pageIndex == 306) {
          setState(() {
            _addToMyBillsList = false;
            _mtnBillController1.text = "";
            _mtnBillController2.text = "";
            pageIndex = 1;
          });
        }
        if (pageIndex == 3777 || pageIndex == 307) {
          setState(() {
            _addToMyBillsList = false;
            _rightelBillController1.text = "";
            _rightelBillController2.text = "";
            pageIndex = 1;
          });
        }

        if (pageIndex == 31111) {
          setState(() {
            pageIndex = 3111;
          });
        }
        if (pageIndex == 32222) {
          setState(() {
            pageIndex = 3222;
          });
        }
        if (pageIndex == 33333) {
          setState(() {
            pageIndex = 3333;
          });
        }
        if (pageIndex == 34444) {
          setState(() {
            pageIndex = 3444;
          });
        }
        if (pageIndex == 35555) {
          setState(() {
            pageIndex = 3555;
          });
        }
        if (pageIndex == 36666) {
          setState(() {
            pageIndex = 3666;
          });
        }
        if (pageIndex == 37777) {
          setState(() {
            pageIndex = 3777;
          });
        }

        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocConsumer<BillBloc, BillState>(
            listener: (context, state) {
              if (state.billsStatus is BillsError) {
                BillsError error = state.billsStatus as BillsError;
                _showSnackBar(error.message);
                state.billsStatus = BillsInit();
              }

              if (state.createBillStatus is CreateBillError) {
                CreateBillError error =
                    state.createBillStatus as CreateBillError;
                _showSnackBar(error.message);
                state.createBillStatus = CreateBillInit();
              }
              if (state.updateBillStatus is UpdateBillError) {
                UpdateBillError error =
                    state.updateBillStatus as UpdateBillError;
                _showSnackBar(error.message);
                state.updateBillStatus = UpdateBillInit();
              }
              if (state.deleteBillStatus is DeleteBillError) {
                DeleteBillError error =
                    state.deleteBillStatus as DeleteBillError;
                _showSnackBar(error.message);
                state.deleteBillStatus = DeleteBillInit();
              }
              if (state.barghBillInquiryStatus is BarghBillInquiryError) {
                BarghBillInquiryError error =
                    state.barghBillInquiryStatus as BarghBillInquiryError;
                _showSnackBar(error.message);
                state.barghBillInquiryStatus = BarghBillInquiryInit();
              }
              if (state.waterBillInquiryStatus is WaterBillInquiryError) {
                WaterBillInquiryError error =
                    state.waterBillInquiryStatus as WaterBillInquiryError;
                _showSnackBar(error.message);
                state.waterBillInquiryStatus = WaterBillInquiryInit();
              }
              if (state.gasBillInquiryStatus is GasBillInquiryError) {
                GasBillInquiryError error =
                    state.gasBillInquiryStatus as GasBillInquiryError;
                _showSnackBar(error.message);
                state.gasBillInquiryStatus = GasBillInquiryInit();
              }
              if (state.fixLineBillInquiryStatus is FixLineBillInquiryError) {
                FixLineBillInquiryError error =
                    state.fixLineBillInquiryStatus as FixLineBillInquiryError;
                _showSnackBar(error.message);
                state.fixLineBillInquiryStatus = FixLineBillInquiryInit();
              }
              if (state.mciBillInquiryStatus is MciBillInquiryError) {
                MciBillInquiryError error =
                    state.mciBillInquiryStatus as MciBillInquiryError;
                _showSnackBar(error.message);
                state.mciBillInquiryStatus = MciBillInquiryInit();
              }
              if (state.mtnBillInquiryStatus is MtnBillInquiryError) {
                MtnBillInquiryError error =
                    state.mtnBillInquiryStatus as MtnBillInquiryError;
                _showSnackBar(error.message);
                state.mtnBillInquiryStatus = MtnBillInquiryInit();
              }
              if (state.rightelBillInquiryStatus is RightelBillInquiryError) {
                RightelBillInquiryError error =
                    state.rightelBillInquiryStatus as RightelBillInquiryError;
                _showSnackBar(error.message);
                state.rightelBillInquiryStatus = RightelBillInquiryInit();
              }
              if (state.paymentFromWalletStatus is PaymentFromWalletError) {
                PaymentFromWalletError error =
                    state.paymentFromWalletStatus as PaymentFromWalletError;
                _showSnackBar(error.message);
                state.paymentFromWalletStatus = PaymentFromWalletInit();
              }
              if (state.balanceStatus is BalanceError) {
                BalanceError error = state.balanceStatus as BalanceError;
                _showSnackBar(error.message);
                state.balanceStatus = BalanceInit();
              }
            },
            builder: (context, state) {
              if (state.billsStatus is BillsLoading ||
                  state.createBillStatus is CreateBillLoading ||
                  state.deleteBillStatus is DeleteBillLoading ||
                  state.updateBillStatus is UpdateBillLoading ||
                  state.barghBillInquiryStatus is BarghBillInquiryLoading ||
                  state.waterBillInquiryStatus is WaterBillInquiryLoading ||
                  state.gasBillInquiryStatus is GasBillInquiryLoading ||
                  state.fixLineBillInquiryStatus is FixLineBillInquiryLoading ||
                  state.mciBillInquiryStatus is MciBillInquiryLoading ||
                  state.mtnBillInquiryStatus is MtnBillInquiryLoading ||
                  state.rightelBillInquiryStatus is RightelBillInquiryLoading ||
                  state.paymentFromWalletStatus is PaymentFromWalletLoading ||
                  state.balanceStatus is BalanceLoading) {
                return LoadingPage();
              }

              if (state.billsStatus is BillsCompleted) {
                BillsCompleted billsCompleted =
                    state.billsStatus as BillsCompleted;
                if (billsCompleted.getBillsEntity.isFailed == false) {
                  myBillsList = billsCompleted.getBillsEntity.value!;
                  waterBillsList = [];
                  barghBillsList = [];
                  gasBillsList = [];
                  phoneBillsList = [];
                  mciBillsList = [];
                  mtnBillsList = [];
                  rightelBillsList = [];
                  for (var i = 0; i < myBillsList.length; i++) {
                    if (myBillsList[i].type!.toInt() == 300) {
                      waterBillsList.add(myBillsList[i]);
                    }
                    if (myBillsList[i].type!.toInt() == 301) {
                      barghBillsList.add(myBillsList[i]);
                    }
                    if (myBillsList[i].type!.toInt() == 302) {
                      phoneBillsList.add(myBillsList[i]);
                    }
                    if (myBillsList[i].type!.toInt() == 306) {
                      gasBillsList.add(myBillsList[i]);
                    }

                    if (myBillsList[i].type!.toInt() == 310) {
                      mciBillsList.add(myBillsList[i]);
                    }
                    if (myBillsList[i].type!.toInt() == 311) {
                      mtnBillsList.add(myBillsList[i]);
                    }
                    if (myBillsList[i].type!.toInt() == 312) {
                      rightelBillsList.add(myBillsList[i]);
                    }
                  }
                }
                state.billsStatus = BillsInit();
              }

              if (state.createBillStatus is CreateBillCompleted) {
                CreateBillCompleted createBillCompleted =
                    state.createBillStatus as CreateBillCompleted;
                if (createBillCompleted.generalResponseEntity.isFailed ==
                    false) {
                  _showSnackBarPost("قبض با موفقیت اضافه شد");
                  state.createBillStatus = CreateBillInit();
                  if (!_addToMyBillsList) {
                    pageIndex = 1;
                  }

                  BlocProvider.of<BillBloc>(context).add(GetBillsEvent());
                }
              }

              if (state.deleteBillStatus is DeleteBillCompleted) {
                DeleteBillCompleted deleteBillCompleted =
                    state.deleteBillStatus as DeleteBillCompleted;
                if (deleteBillCompleted.generalResponseEntity.isFailed ==
                    false) {
                  _showSnackBarPost("قبض با موفقیت حذف شد");
                  state.deleteBillStatus = DeleteBillInit();
                  BlocProvider.of<BillBloc>(context).add(GetBillsEvent());
                }
              }

              if (state.updateBillStatus is UpdateBillCompleted) {
                UpdateBillCompleted updateBillCompleted =
                    state.updateBillStatus as UpdateBillCompleted;
                if (updateBillCompleted.generalResponseEntity.isFailed ==
                    false) {
                  _showSnackBarPost("قبض با موفقیت ویرایش شد");
                  state.updateBillStatus = UpdateBillInit();
                  pageIndex = 1;
                  BlocProvider.of<BillBloc>(context).add(GetBillsEvent());
                }
              }

              if (state.barghBillInquiryStatus is BarghBillInquiryCompleted) {
                BarghBillInquiryCompleted barghBillInquiryCompleted =
                    state.barghBillInquiryStatus as BarghBillInquiryCompleted;
                if (barghBillInquiryCompleted.barghBillInquiryEntity.isFailed ==
                    false) {
                  barghInquiryResult =
                      barghBillInquiryCompleted.barghBillInquiryEntity.value!;
                  pageIndex = 322;
                }
                state.barghBillInquiryStatus = BarghBillInquiryInit();
              }

              if (state.waterBillInquiryStatus is WaterBillInquiryCompleted) {
                WaterBillInquiryCompleted waterBillInquiryCompleted =
                    state.waterBillInquiryStatus as WaterBillInquiryCompleted;
                if (waterBillInquiryCompleted.waterBillInquiryEntity.isFailed ==
                    false) {
                  waterInquiryResult =
                      waterBillInquiryCompleted.waterBillInquiryEntity.value!;
                  pageIndex = 311;
                }
                state.waterBillInquiryStatus = WaterBillInquiryInit();
              }

              if (state.gasBillInquiryStatus is GasBillInquiryCompleted) {
                GasBillInquiryCompleted gasBillInquiryCompleted =
                    state.gasBillInquiryStatus as GasBillInquiryCompleted;
                if (gasBillInquiryCompleted.gasBillInquiryEntity.isFailed ==
                    false) {
                  gasInquiryResult =
                      gasBillInquiryCompleted.gasBillInquiryEntity.value!;
                  pageIndex = 333;
                }
                state.gasBillInquiryStatus = GasBillInquiryInit();
              }

              if (state.fixLineBillInquiryStatus
                  is FixLineBillInquiryCompleted) {
                FixLineBillInquiryCompleted fixLineBillInquiryCompleted = state
                    .fixLineBillInquiryStatus as FixLineBillInquiryCompleted;
                if (fixLineBillInquiryCompleted
                        .fixLineBillInquiryEntity.isFailed ==
                    false) {
                  fixLineInquiryResult = fixLineBillInquiryCompleted
                      .fixLineBillInquiryEntity.value!;
                  pageIndex = 344;
                }
                state.fixLineBillInquiryStatus = FixLineBillInquiryInit();
              }

              if (state.mciBillInquiryStatus is MciBillInquiryCompleted) {
                MciBillInquiryCompleted mciBillInquiryCompleted =
                    state.mciBillInquiryStatus as MciBillInquiryCompleted;
                if (mciBillInquiryCompleted.mciBillInquiryEntity.isFailed ==
                    false) {
                  mciInquiryResult =
                      mciBillInquiryCompleted.mciBillInquiryEntity.value!;
                  pageIndex = 355;
                }
                state.mciBillInquiryStatus = MciBillInquiryInit();
              }

              if (state.mtnBillInquiryStatus is MtnBillInquiryCompleted) {
                MtnBillInquiryCompleted mtnBillInquiryCompleted =
                    state.mtnBillInquiryStatus as MtnBillInquiryCompleted;
                if (mtnBillInquiryCompleted.mtnBillInquiryEntity.isFailed ==
                    false) {
                  mtnInquiryResult =
                      mtnBillInquiryCompleted.mtnBillInquiryEntity.value!;
                  pageIndex = 366;
                }
                state.mtnBillInquiryStatus = MtnBillInquiryInit();
              }

              if (state.rightelBillInquiryStatus
                  is RightelBillInquiryCompleted) {
                RightelBillInquiryCompleted rightelBillInquiryCompleted = state
                    .rightelBillInquiryStatus as RightelBillInquiryCompleted;
                if (rightelBillInquiryCompleted
                        .rightelBillInquiryEntity.isFailed ==
                    false) {
                  rightelInquiryResult = rightelBillInquiryCompleted
                      .rightelBillInquiryEntity.value!;
                  pageIndex = 377;
                }
                state.rightelBillInquiryStatus = RightelBillInquiryInit();
              }

              if (state.paymentFromWalletStatus is PaymentFromWalletCompleted) {
                PaymentFromWalletCompleted paymentFromWalletCompleted =
                    state.paymentFromWalletStatus as PaymentFromWalletCompleted;
                if (paymentFromWalletCompleted
                        .paymentFromWalletEntity.isFailed ==
                    false) {
                  orderId = paymentFromWalletCompleted
                      .paymentFromWalletEntity.value!.orderId!
                      .toInt()
                      .toString();
                  if (pageIndex == 3111) {
                    pageIndex = 301;
                  }
                  if (pageIndex == 3222) {
                    pageIndex = 302;
                  }
                  if (pageIndex == 3333) {
                    pageIndex = 303;
                  }
                  if (pageIndex == 3444) {
                    pageIndex = 304;
                  }
                  if (pageIndex == 3555) {
                    pageIndex = 305;
                  }
                  if (pageIndex == 3666) {
                    pageIndex = 306;
                  }
                  if (pageIndex == 3777) {
                    pageIndex = 307;
                  }
                }
                state.paymentFromWalletStatus = PaymentFromWalletInit();
              }

              if (state.balanceStatus is BalanceCompleted) {
                BalanceCompleted balanceCompleted =
                    state.balanceStatus as BalanceCompleted;
                if (balanceCompleted.getBalanceEntity.isFailed == false) {
                  balance = balanceCompleted.getBalanceEntity.value![0].store!
                      .toString();
                }
                state.balanceStatus = BalanceInit();
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: preparePageIndex(),
              );
            },
          ),
        ),
      ),
    );
  }

  preparePageIndex() {
    // index 1 > main bills page

    // index 11 > watter bills page
    // index 12 > electricity bills page
    // index 13 > gas bills page
    // index 14 > phone bills page
    // index 15 > mci bills page
    // index 16 > mtn bills page
    // index 17 > rightel bills page

    // index 30 >  select bill type to add page
    // index 31 > add watter bills page
    // index 32 > add electricity bills page
    // index 33 > add gas bills page
    // index 34 > add phone bills page

    // index 2  > edit bills page

    if (pageIndex == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (myBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child:
                            Column(children: createMyBillsItems(myBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pageIndex = 30;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 11) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (waterBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                            children: createMyBillsItems(waterBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 31 > add watter bills page

                        setState(() {
                          selectedNewBillToAdd = 1;
                          pageIndex = 31;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 12) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (barghBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                            children: createMyBillsItems(barghBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 32 > add electricity bills page

                        setState(() {
                          selectedNewBillToAdd = 2;
                          pageIndex = 32;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 13) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (gasBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child:
                            Column(children: createMyBillsItems(gasBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 33 > add gas bills page

                        setState(() {
                          selectedNewBillToAdd = 3;
                          pageIndex = 33;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 14) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (phoneBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                            children: createMyBillsItems(phoneBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 34 > add phone bills page

                        setState(() {
                          selectedNewBillToAdd = 4;
                          pageIndex = 34;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 15) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (mciBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child:
                            Column(children: createMyBillsItems(mciBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 35 > add mci bills page

                        setState(() {
                          selectedNewBillToAdd = 5;
                          pageIndex = 35;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 16) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (mtnBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child:
                            Column(children: createMyBillsItems(mtnBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 36 > add mtn bills page

                        setState(() {
                          selectedNewBillToAdd = 6;
                          pageIndex = 36;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 17) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("قبض های من")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Scrollbar(
                      thickness: 3,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      isAlwaysShown: true,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        children: [
                          InkWell(
                            onTap: () {
                              if (pageIndex != 1) {
                                setState(() {
                                  pageIndex = 1;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/all_bills_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همه قبوض",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 11) {
                                setState(() {
                                  pageIndex = 11;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 11)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 11)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 12) {
                                setState(() {
                                  pageIndex = 12;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 12)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 12)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 13) {
                                setState(() {
                                  pageIndex = 13;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 13)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 13)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 14) {
                                setState(() {
                                  pageIndex = 14;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 14)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 14)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 15) {
                                setState(() {
                                  pageIndex = 15;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 15)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 15)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 16) {
                                setState(() {
                                  pageIndex = 16;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 16)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 16)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (pageIndex != 17) {
                                setState(() {
                                  pageIndex = 17;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (pageIndex == 17)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (pageIndex == 17)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )),
          Expanded(
              flex: 13,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: (rightelBillsList.isEmpty)
                    ? Center(
                        child: Text("قبضی برای نمایش وجود ندارد"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                            children: createMyBillsItems(rightelBillsList)),
                      ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // index 37 > add rightel bills page

                        setState(() {
                          selectedNewBillToAdd = 7;
                          pageIndex = 37;
                        });
                      },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 30) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                            selectedNewBillToAdd = 0;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض جدید")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 1,
              child: Container(
                child: Center(child: Text("نوع قبض خود را انتخاب نمایید")),
              )),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 4;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 4)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/phone_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض تلفن",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 4)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 3;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 3)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/gas_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض گاز",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 3)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 2;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 2)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/bargh_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض برق",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 2)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 1;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 1)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/water_bill_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "قبض آب",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 1)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 5;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 5)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/hamrah_aval_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "همراه اول",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 5)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 6;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 6)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/irancell_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "ایرانسل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 6)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedNewBillToAdd = 7;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: (selectedNewBillToAdd == 7)
                                          ? Colors.transparent
                                          : Color(0xa39c9c9c),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      'assets/image_icon/rightel_icon.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "رایتل",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (selectedNewBillToAdd == 7)
                                          ? Colors.black
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(flex: 8, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (selectedNewBillToAdd == 0)
                          ? null
                          : () {
                              // index 31 > add watter bills page
                              // index 32 > add electricity bills page
                              // index 33 > add gas bills page
                              // index 34 > add phone bills page
                              // index 35 > add mci bills page
                              // index 36 > add mtn bills page
                              // index 37 > add rightel bills page
                              if (selectedNewBillToAdd == 1) {
                                setState(() {
                                  pageIndex = 31;
                                });
                              }
                              if (selectedNewBillToAdd == 2) {
                                setState(() {
                                  pageIndex = 32;
                                });
                              }
                              if (selectedNewBillToAdd == 3) {
                                setState(() {
                                  pageIndex = 33;
                                });
                              }
                              if (selectedNewBillToAdd == 4) {
                                setState(() {
                                  pageIndex = 34;
                                });
                              }
                              if (selectedNewBillToAdd == 5) {
                                setState(() {
                                  pageIndex = 35;
                                });
                              }
                              if (selectedNewBillToAdd == 6) {
                                setState(() {
                                  pageIndex = 36;
                                });
                              }
                              if (selectedNewBillToAdd == 7) {
                                setState(() {
                                  pageIndex = 37;
                                });
                              }
                            },
                      child: Text('افزودن قبض جدید'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 31) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض آب")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/water_bill_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "قبض آب",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شناسه قبض خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_water_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _waterBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_water_1 =
                                        !_formKey_water_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شناسه قبض",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_water_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _waterBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_water_2 =
                                        !_formKey_water_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_water_1 == true ||
                              _isButtonNextDisabled_water_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              WaterBillInquiryParam waterBillInquiryParam =
                                  WaterBillInquiryParam(
                                      waterBillID:
                                          _waterBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  WaterBillInquiryEvent(waterBillInquiryParam));
                              // CreateBillParam createBillParam = CreateBillParam(
                              //     billType: 300,
                              //     billCode:
                              //         _waterBillController1.text.toString(),
                              //     billTitle:
                              //         _waterBillController2.text.toString());
                              // BlocProvider.of<BillBloc>(context)
                              //     .add(CreateBillEvent(createBillParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 311) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 31;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/water_bill_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض آب")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(waterInquiryResult.fullName!),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نام مشترک",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text("${waterInquiryResult.address}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "آدرس",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text("${waterInquiryResult.billID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه قبض",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text(((waterInquiryResult.paymentID!) == "")
                                ? "پرداخت شده"
                                : "${waterInquiryResult.paymentID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه پرداخت",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  waterInquiryResult.amount!.trim().seRagham() +
                                      " ریال",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.green),
                                ))),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "مبلغ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 300,
                                billCode: _waterBillController1.text.toString(),
                                billTitle:
                                    _waterBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (waterInquiryResult.paymentID!.trim() == "")
                            ? null
                            : () {
                                BlocProvider.of<BillBloc>(context)
                                    .add(GetBalanceEvent());
                                if (_addToMyBillsList) {
                                  CreateBillParam createBillParam =
                                      CreateBillParam(
                                          billType: 300,
                                          billCode: _waterBillController1
                                              .text
                                              .toString(),
                                          billTitle: _waterBillController2.text
                                              .toString());
                                  BlocProvider.of<BillBloc>(context)
                                      .add(CreateBillEvent(createBillParam));
                                }

                                setState(() {
                                  pageIndex = 3111;
                                });
                              },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3111) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _waterBillController1.text = "";
                            _waterBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض آب"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${waterInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  ((waterInquiryResult.paymentID!) == "")
                                      ? "پرداخت شده"
                                      : "${waterInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    waterInquiryResult.amount!
                                            .trim()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          bill.billID = waterInquiryResult.billID;
                          // bill.paymentID = waterInquiryResult.paymentID;
                          // bill.phoneNumber = phoneNumber;
                          bill.operationCode = "300";
                          // bill.gatewayID ="";
                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 31111;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 31111) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3111;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض آب"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${waterInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  ((waterInquiryResult.paymentID!) == "")
                                      ? "پرداخت شده"
                                      : "${waterInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    waterInquiryResult.amount!
                                            .trim()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 301) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض آب")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _waterBillController1.text = "";
                            _waterBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text("${waterInquiryResult.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(((waterInquiryResult.paymentID!) == "")
                                  ? "پرداخت شده"
                                  : "${waterInquiryResult.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                waterInquiryResult.amount!.trim().seRagham() +
                                    " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 32) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض برق")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/bargh_bill_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "قبض برق",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شناسه قبض خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_bargh_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _barghBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_bargh_1 =
                                        !_formKey_bargh_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شناسه قبض",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_bargh_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _barghBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_bargh_2 =
                                        !_formKey_bargh_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_bargh_1 == true ||
                              _isButtonNextDisabled_bargh_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              BarghBillInquiryParam barghBillInquiryParam =
                                  BarghBillInquiryParam(
                                      electricityBillID:
                                          _barghBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  BarghBillInquiryEvent(barghBillInquiryParam));

                              // CreateBillParam createBillParam = CreateBillParam(
                              //     billType: 301,
                              //     billCode:
                              //         _barghBillController1.text.toString(),
                              //     billTitle:
                              //         _barghBillController2.text.toString());
                              // BlocProvider.of<BillBloc>(context)
                              //     .add(CreateBillEvent(createBillParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 322) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 32;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/bargh_bill_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "قبض برق دوره ${barghInquiryResult.cycle} سال ${barghInquiryResult.saleYear}")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(barghInquiryResult.fullName!),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نام مشترک",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text("${barghInquiryResult.address}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "آدرس",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text("${barghInquiryResult.billID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه قبض",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text(((barghInquiryResult.paymentID!) == "")
                                ? "پرداخت شده"
                                : "${barghInquiryResult.paymentID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه پرداخت",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  barghInquiryResult.amount!
                                          .toString()
                                          .seRagham() +
                                      " ریال",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.green),
                                ))),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "مبلغ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 301,
                                billCode: _barghBillController1.text.toString(),
                                billTitle:
                                    _barghBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (barghInquiryResult.paymentID!.trim() == "")
                            ? null
                            : () {
                                BlocProvider.of<BillBloc>(context)
                                    .add(GetBalanceEvent());

                                if (_addToMyBillsList) {
                                  CreateBillParam createBillParam =
                                      CreateBillParam(
                                          billType: 301,
                                          billCode: _barghBillController1
                                              .text
                                              .toString(),
                                          billTitle: _barghBillController2.text
                                              .toString());
                                  BlocProvider.of<BillBloc>(context)
                                      .add(CreateBillEvent(createBillParam));
                                }
                                setState(() {
                                  pageIndex = 3222;
                                });
                              },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3222) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _barghBillController1.text = "";
                            _barghBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض برق"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${barghInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  ((barghInquiryResult.paymentID!) == "")
                                      ? "پرداخت شده"
                                      : "${barghInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    barghInquiryResult.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          bill.billID = barghInquiryResult.billID;
                          // bill.paymentID = barghInquiryResult.paymentID;
                          // bill.phoneNumber = phoneNumber;
                          bill.operationCode = "301";
                          // bill.gatewayID ="";
                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 32222;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 32222) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3222;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض برق"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${barghInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  ((barghInquiryResult.paymentID!) == "")
                                      ? "پرداخت شده"
                                      : "${barghInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    barghInquiryResult.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 302) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض برق")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _barghBillController1.text = "";
                            _barghBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text("${barghInquiryResult.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(((barghInquiryResult.paymentID!) == "")
                                  ? "پرداخت شده"
                                  : "${barghInquiryResult.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                barghInquiryResult.amount!
                                        .toInt()
                                        .toString()
                                        .trim()
                                        .seRagham() +
                                    " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 33) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض گاز")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/gas_bill_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "قبض گاز",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شناسه قبض خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_gaz_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _gazBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_gas_1 =
                                        !_formKey_gaz_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شناسه قبض",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_gaz_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _gazBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_gas_2 =
                                        !_formKey_gaz_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض گاز مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_gas_1 == true ||
                              _isButtonNextDisabled_gas_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              GasBillInquiryParam gasBillInquiryParam =
                                  GasBillInquiryParam(
                                      participateCode: "",
                                      gasBillID:
                                          _gazBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  GasBillInquiryEvent(gasBillInquiryParam));

                              // CreateBillParam createBillParam = CreateBillParam(
                              //     billType: 306,
                              //     billCode: _gazBillController1.text.toString(),
                              //     billTitle:
                              //         _gazBillController2.text.toString());
                              // BlocProvider.of<BillBloc>(context)
                              //     .add(CreateBillEvent(createBillParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 333) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 33;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/gas_bill_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض گاز")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(gasInquiryResult.fullName!),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نام مشترک",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text("${gasInquiryResult.address}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "آدرس",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8, child: Text("${gasInquiryResult.billID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه قبض",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Text(((gasInquiryResult.paymentID!) == "")
                                ? "پرداخت شده"
                                : "${gasInquiryResult.paymentID}")),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "شناسه پرداخت",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  gasInquiryResult.amount!
                                          .toString()
                                          .seRagham() +
                                      " ریال",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.green),
                                ))),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "مبلغ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 306,
                                billCode: _gazBillController1.text.toString(),
                                billTitle: _gazBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (gasInquiryResult.paymentID!.trim() == "")
                            ? null
                            : () {
                                BlocProvider.of<BillBloc>(context)
                                    .add(GetBalanceEvent());
                                if (_addToMyBillsList) {
                                  CreateBillParam createBillParam =
                                      CreateBillParam(
                                          billType: 306,
                                          billCode: _gazBillController1
                                              .text
                                              .toString(),
                                          billTitle: _gazBillController2.text
                                              .toString());
                                  BlocProvider.of<BillBloc>(context)
                                      .add(CreateBillEvent(createBillParam));
                                }
                                setState(() {
                                  pageIndex = 3333;
                                });
                              },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3333) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _gazBillController1.text = "";
                            _gazBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض گاز"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${gasInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(((gasInquiryResult.paymentID!) == "")
                                  ? "پرداخت شده"
                                  : "${gasInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gasInquiryResult.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          bill.billID = gasInquiryResult.billID;
                          // bill.paymentID = gasInquiryResult.paymentID;
                          // bill.phoneNumber = phoneNumber;
                          bill.operationCode = "306";
                          // bill.gatewayID ="";
                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 33333;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 33333) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3333;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض گاز"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text("${gasInquiryResult.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(((gasInquiryResult.paymentID!) == "")
                                  ? "پرداخت شده"
                                  : "${gasInquiryResult.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gasInquiryResult.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 303) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض گاز")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _gazBillController1.text = "";
                            _gazBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text("${gasInquiryResult.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(((gasInquiryResult.paymentID!) == "")
                                  ? "پرداخت شده"
                                  : "${gasInquiryResult.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                gasInquiryResult.amount!.trim().seRagham() +
                                    " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 34) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض تلفن")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/phone_bill_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "قبض تلفن",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره تلفن ثابت خود را همراه با عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_phone_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _phoneBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_phone_1 =
                                        !_formKey_phone_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره ثابت",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_phone_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _phoneBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_phone_2 =
                                        !_formKey_phone_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض تلفن مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_phone_1 == true ||
                              _isButtonNextDisabled_phone_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              FixLineBillInquiryParam fixLineBillInquiryParam =
                                  FixLineBillInquiryParam(
                                      fixedLineNumber:
                                          _phoneBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  FixLineBillInquiryEvent(
                                      fixLineBillInquiryParam));

                              // CreateBillParam createBillParam = CreateBillParam(
                              //     billType: 302,
                              //     billCode:
                              //         _phoneBillController1.text.toString(),
                              //     billTitle:
                              //         _phoneBillController2.text.toString());
                              // BlocProvider.of<BillBloc>(context)
                              //     .add(CreateBillEvent(createBillParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 344) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 34;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/phone_bill_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض تلفن ثابت")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(_phoneBillController1.text.trim()),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شماره تلفن",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            midTermSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: (midTermSelected)
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        fixLineInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: (midTermSelected)
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ))),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "میان دوره",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          midTermSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            color: (midTermSelected)
                                ? Colors.grey
                                : Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      fixLineInquiryResult.finalTerm!.amount!
                                              .toString()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: (midTermSelected)
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                    ))),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "پایان دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 302,
                                billCode: _phoneBillController1.text.toString(),
                                billTitle:
                                    _phoneBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (midTermSelected)
                            ? (fixLineInquiryResult.midTerm!.paymentID ==
                                        null ||
                                    fixLineInquiryResult.midTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 302,
                                              billCode: _phoneBillController1
                                                  .text
                                                  .toString(),
                                              billTitle: _phoneBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }

                                    setState(() {
                                      pageIndex = 3444;
                                    });
                                  }
                            : (fixLineInquiryResult.finalTerm!.paymentID ==
                                        null ||
                                    fixLineInquiryResult.finalTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 302,
                                              billCode: _phoneBillController1
                                                  .text
                                                  .toString(),
                                              billTitle: _phoneBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }
                                    setState(() {
                                      pageIndex = 3444;
                                    });
                                  },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3444) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _phoneBillController1.text = "";
                            _phoneBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض تلفن ثابت"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? fixLineInquiryResult.midTerm!.billID : fixLineInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((fixLineInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.midTerm!.paymentID}"
                                  : ((fixLineInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? fixLineInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : fixLineInquiryResult
                                                .finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          // bill.billID = (midTermSelected)
                          //     ? fixLineInquiryResult.midTerm!.billID
                          //     : fixLineInquiryResult.finalTerm!.billID;

                          bill.isMidTerm = (midTermSelected) ? true : false;

                          bill.billID = _phoneBillController1.text.trim();
                          bill.operationCode = "302";

                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 34444;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 34444) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3444;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض تلفن ثابت"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? fixLineInquiryResult.midTerm!.billID : fixLineInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((fixLineInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.midTerm!.paymentID}"
                                  : ((fixLineInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? fixLineInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : fixLineInquiryResult
                                                .finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 304) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض تلفن")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _phoneBillController1.text = "";
                            _phoneBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                  "${(midTermSelected) ? fixLineInquiryResult.midTerm!.billID : fixLineInquiryResult.finalTerm!.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text((midTermSelected)
                                  ? ((fixLineInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.midTerm!.paymentID}"
                                  : ((fixLineInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${fixLineInquiryResult.finalTerm!.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                (midTermSelected)
                                    ? fixLineInquiryResult.midTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال"
                                    : fixLineInquiryResult.finalTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 35) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض تلفن همراه")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/hamrah_aval_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "همراه اول",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره تلفن همراه خود و عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_mci_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _mciBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_mci_1 =
                                        !_formKey_mci_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره تلفن همراه اول",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_mci_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _mciBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_mci_2 =
                                        !_formKey_mci_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض تلفن مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_mci_1 == true ||
                              _isButtonNextDisabled_mci_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              FixMobileBillInquiryParam
                                  fixMobileBillInquiryParam =
                                  FixMobileBillInquiryParam(
                                      mobileNumber:
                                          _mciBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  MciBillInquiryEvent(
                                      fixMobileBillInquiryParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 355) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 35;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/hamrah_aval_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض همراه اول")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(_mciBillController1.text.trim()),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شماره تلفن همراه",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            midTermSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: (midTermSelected)
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        mciInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: (midTermSelected)
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ))),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "میان دوره",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          midTermSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            color: (midTermSelected)
                                ? Colors.grey
                                : Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mciInquiryResult.finalTerm!.amount!
                                              .toString()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: (midTermSelected)
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                    ))),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "پایان دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 310,
                                billCode: _mciBillController1.text.toString(),
                                billTitle: _mciBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (midTermSelected)
                            ? (mciInquiryResult.midTerm!.paymentID == null ||
                                    mciInquiryResult.midTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 310,
                                              billCode: _mciBillController1.text
                                                  .toString(),
                                              billTitle: _mciBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }

                                    setState(() {
                                      pageIndex = 3555;
                                    });
                                  }
                            : (mciInquiryResult.finalTerm!.paymentID == null ||
                                    mciInquiryResult.finalTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 310,
                                              billCode: _mciBillController1.text
                                                  .toString(),
                                              billTitle: _mciBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }
                                    setState(() {
                                      pageIndex = 3555;
                                    });
                                  },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3555) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _mciBillController1.text = "";
                            _mciBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض همراه اول"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? mciInquiryResult.midTerm!.billID : mciInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((mciInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.midTerm!.paymentID}"
                                  : ((mciInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? mciInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : mciInquiryResult.finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          // bill.billID = (midTermSelected)
                          //     ? mciInquiryResult.midTerm!.billID
                          //     : mciInquiryResult.finalTerm!.billID;

                          bill.isMidTerm = (midTermSelected) ? true : false;

                          bill.billID = _mciBillController1.text.trim();
                          bill.operationCode = "310";

                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 35555;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 35555) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3555;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض همراه اول"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? mciInquiryResult.midTerm!.billID : mciInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((mciInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.midTerm!.paymentID}"
                                  : ((mciInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? mciInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : mciInquiryResult.finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 305) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض همراه اول")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _mciBillController1.text = "";
                            _mciBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                  "${(midTermSelected) ? mciInquiryResult.midTerm!.billID : mciInquiryResult.finalTerm!.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text((midTermSelected)
                                  ? ((mciInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.midTerm!.paymentID}"
                                  : ((mciInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mciInquiryResult.finalTerm!.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                (midTermSelected)
                                    ? mciInquiryResult.midTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال"
                                    : mciInquiryResult.finalTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 36) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض تلفن همراه")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/irancell_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "ایرانسل",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره تلفن همراه خود و عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_mtn_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _mtnBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_mtn_1 =
                                        !_formKey_mtn_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره تلفن ایرانسل",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_mtn_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _mtnBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_mtn_2 =
                                        !_formKey_mtn_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض تلفن مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_mtn_1 == true ||
                              _isButtonNextDisabled_mtn_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              FixMobileBillInquiryParam
                                  fixMobileBillInquiryParam =
                                  FixMobileBillInquiryParam(
                                      mobileNumber:
                                          _mtnBillController1.text.toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  MtnBillInquiryEvent(
                                      fixMobileBillInquiryParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 366) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 36;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/irancell_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض ایرانسل")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(_mtnBillController1.text.trim()),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شماره تلفن همراه",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            midTermSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: (midTermSelected)
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        mtnInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: (midTermSelected)
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ))),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "میان دوره",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          midTermSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            color: (midTermSelected)
                                ? Colors.grey
                                : Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mtnInquiryResult.finalTerm!.amount!
                                              .toString()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: (midTermSelected)
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                    ))),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "پایان دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 311,
                                billCode: _mtnBillController1.text.toString(),
                                billTitle: _mtnBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (midTermSelected)
                            ? (mtnInquiryResult.midTerm!.paymentID == null ||
                                    mtnInquiryResult.midTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 311,
                                              billCode: _mtnBillController1.text
                                                  .toString(),
                                              billTitle: _mtnBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }

                                    setState(() {
                                      pageIndex = 3666;
                                    });
                                  }
                            : (mtnInquiryResult.finalTerm!.paymentID == null ||
                                    mtnInquiryResult.finalTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 311,
                                              billCode: _mtnBillController1.text
                                                  .toString(),
                                              billTitle: _mtnBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }
                                    setState(() {
                                      pageIndex = 3666;
                                    });
                                  },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3666) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _mtnBillController1.text = "";
                            _mtnBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض ایرانسل"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? mtnInquiryResult.midTerm!.billID : mtnInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((mtnInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.midTerm!.paymentID}"
                                  : ((mtnInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? mtnInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : mtnInquiryResult.finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          // bill.billID = (midTermSelected)
                          //     ? mtnInquiryResult.midTerm!.billID
                          //     : mtnInquiryResult.finalTerm!.billID;

                          bill.isMidTerm = (midTermSelected) ? true : false;

                          bill.billID = _mtnBillController1.text.trim();
                          bill.operationCode = "311";

                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 36666;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 36666) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3666;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض ایرانسل"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? mtnInquiryResult.midTerm!.billID : mtnInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((mtnInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.midTerm!.paymentID}"
                                  : ((mtnInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? mtnInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : mtnInquiryResult.finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 306) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض ایرانسل")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _mtnBillController1.text = "";
                            _mtnBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                  "${(midTermSelected) ? mtnInquiryResult.midTerm!.billID : mtnInquiryResult.finalTerm!.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text((midTermSelected)
                                  ? ((mtnInquiryResult.midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.midTerm!.paymentID}"
                                  : ((mtnInquiryResult.finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${mtnInquiryResult.finalTerm!.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                (midTermSelected)
                                    ? mtnInquiryResult.midTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال"
                                    : mtnInquiryResult.finalTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 37) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("افزودن قبض تلفن همراه")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Container(
                                  child: Image.asset(
                                    'assets/image_icon/rightel_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "رایتل",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.grey,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "شماره تلفن همراه خود و عنوان قبض مورد نظر وارد نمایید ",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                  ),
                ],
              )),
          Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_rightel_bill1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _rightelBillController1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.contains(".") ||
                                      value.contains("-") ||
                                      value.contains(",") ||
                                      value.contains(" ")) {
                                    return 'مقدار وارد شده معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_rightel_1 =
                                        !_formKey_rightel_bill1.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "شماره تلفن رایتل",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey_rightel_bill2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 11,
                                controller: _rightelBillController2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_rightel_2 =
                                        !_formKey_rightel_bill2.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض تلفن مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (_isButtonNextDisabled_rightel_1 == true ||
                              _isButtonNextDisabled_rightel_2 == true)
                          ? null
                          : () {
                              setState(() {
                                isSimpleInquiry = false;
                              });
                              FixMobileBillInquiryParam
                                  fixMobileBillInquiryParam =
                                  FixMobileBillInquiryParam(
                                      mobileNumber: _rightelBillController1.text
                                          .toString(),
                                      traceNumber: "");
                              BlocProvider.of<BillBloc>(context).add(
                                  RightelBillInquiryEvent(
                                      fixMobileBillInquiryParam));
                            },
                      child: Text('استعلام'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 377) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("اطلاعات قبض")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            pageIndex = 37;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 10),
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          child: Image.asset(
                            'assets/image_icon/rightel_icon.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("قبض رایتل")
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: MyColors.otp_underline,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ))),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(_rightelBillController1.text.trim()),
                        ),
                        Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شماره تلفن همراه",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            midTermSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: (midTermSelected)
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        rightelInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: (midTermSelected)
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ))),
                              Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "میان دوره",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          midTermSelected = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            color: (midTermSelected)
                                ? Colors.grey
                                : Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      rightelInquiryResult.finalTerm!.amount!
                                              .toString()
                                              .seRagham() +
                                          " ریال",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: (midTermSelected)
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                    ))),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "پایان دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CheckboxWidget(callback: (value) {
                      setState(() {
                        _addToMyBillsList = value;
                      });
                    }),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Visibility(
                        visible: !_addToMyBillsList,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: MyColors.otp_underline),
                              ),
                            ),
                          ),
                          onPressed: () {
                            CreateBillParam createBillParam = CreateBillParam(
                                billType: 312,
                                billCode:
                                    _rightelBillController1.text.toString(),
                                billTitle:
                                    _rightelBillController2.text.toString());
                            BlocProvider.of<BillBloc>(context)
                                .add(CreateBillEvent(createBillParam));
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'افزودن به قبض های من',
                                style: TextStyle(color: MyColors.otp_underline),
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (midTermSelected)
                            ? (rightelInquiryResult.midTerm!.paymentID ==
                                        null ||
                                    rightelInquiryResult.midTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 312,
                                              billCode: _rightelBillController1
                                                  .text
                                                  .toString(),
                                              billTitle: _rightelBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }

                                    setState(() {
                                      pageIndex = 3777;
                                    });
                                  }
                            : (rightelInquiryResult.finalTerm!.paymentID ==
                                        null ||
                                    rightelInquiryResult.finalTerm!.paymentID!
                                            .trim() ==
                                        "")
                                ? null
                                : () {
                                    BlocProvider.of<BillBloc>(context)
                                        .add(GetBalanceEvent());

                                    if (_addToMyBillsList) {
                                      CreateBillParam createBillParam =
                                          CreateBillParam(
                                              billType: 312,
                                              billCode: _rightelBillController1
                                                  .text
                                                  .toString(),
                                              billTitle: _rightelBillController2
                                                  .text
                                                  .toString());
                                      BlocProvider.of<BillBloc>(context).add(
                                          CreateBillEvent(createBillParam));
                                    }
                                    setState(() {
                                      pageIndex = 3777;
                                    });
                                  },
                        child: Text('پرداخت'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 3777) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _rightelBillController1.text = "";
                            _rightelBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض رایتل"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? rightelInquiryResult.midTerm!.billID : rightelInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((rightelInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.midTerm!.paymentID}"
                                  : ((rightelInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? rightelInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : rightelInquiryResult
                                                .finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Text("پرداخت از")),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 1)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کیف پول"),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        (balance == "***")
                                            ? "موجودی کیف پول : نامشخص"
                                            : "موجودی کیف پول : ${balance.seRagham()} ریال",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: (payTypeSelected == 1)
                                                ? MyColors.otp_underline
                                                : Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 1)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/wallet_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          payTypeSelected = 2;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: (payTypeSelected == 2)
                                ? MyColors.otp_underline
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        ("کارت بانکی"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  foregroundDecoration: BoxDecoration(
                                    color: (payTypeSelected == 2)
                                        ? Colors.transparent
                                        : Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                                  child: Image.asset(
                                    'assets/image_icon/bank_shahr_icon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (payTypeSelected == 1) {
                          Bills bill = Bills();
                          // bill.billID = (midTermSelected)
                          //     ? rightelInquiryResult.midTerm!.billID
                          //     : rightelInquiryResult.finalTerm!.billID;

                          bill.isMidTerm = (midTermSelected) ? true : false;

                          bill.billID = _rightelBillController1.text.trim();
                          bill.operationCode = "312";

                          List<Bills> bills = [];
                          bills.add(bill);
                          BillPaymentFromWalletParam param =
                              BillPaymentFromWalletParam(bills: bills);
                          BlocProvider.of<BillBloc>(context).add(
                              PaymentFromWalletBillEvent(
                                  json.encode(param.toJson())));
                        } else {
                          setState(() {
                            pageIndex = 37777;
                          });
                        }
                      },
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 37777) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 4,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت اینترنتی")))),
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 3777;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.light_grey,
                      border: Border.all(
                        color: MyColors.light_grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text("قبض رایتل"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "عنوان",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                                (midTermSelected) ? "میان دوره" : "پایان دوره"),
                          ),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "دوره",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ))
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                  "${(midTermSelected) ? rightelInquiryResult.midTerm!.billID : rightelInquiryResult.finalTerm!.billID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text((midTermSelected)
                                  ? ((rightelInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.midTerm!.paymentID}"
                                  : ((rightelInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.finalTerm!.paymentID}")),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (midTermSelected)
                                        ? rightelInquiryResult.midTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال"
                                        : rightelInquiryResult
                                                .finalTerm!.amount!
                                                .toString()
                                                .seRagham() +
                                            " ریال",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "مبلغ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "اطلاعات کارت بانکی عضو شتاب خود را وارد نمایید",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        // key: _formKey_kart_number,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                // controller: _kartNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  } else if (value.isValidBankCardNumber()) {
                                    return 'شماره کارت معتبر نیست';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    // _isButtonNextDisabled_page21_condition3 =
                                    // !_formKey_kart_number.currentState!
                                    //     .validate();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x32E1E3E0),
                                  hintText: "شماره کارت",
                                  hintStyle: TextStyle(fontSize: 12),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // Jalali? picked = await showPersianDatePicker(
                              //   context: context,
                              //   initialDate: Jalali.now(),
                              //   firstDate: Jalali(1402, 1),
                              //   lastDate: Jalali(1410, 12),
                              // );
                              // setState(() {
                              //   selectedDate = picked!;
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("تاریخ انقضاء",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x32E1E3E0),
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                            // (myLateVariableInitialized())
                                            //     ? ((selectedDate
                                            //     .formatter.yyyy) +
                                            //     " " +
                                            //     (selectedDate.formatter.mN))
                                            //     : "**/**",

                                            "**/**",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      )),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("CVV2",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_cvv2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _cvv2Controller,
                                          maxLength: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition2 =
                                            //   !_formKey_cvv2.currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    "درخواست رمز پویا",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blueAccent),
                                  ),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text("رمز دوم",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                ),
                                Form(
                                  // key: _formKey_secondPassword,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          // controller: _secondPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'مقدار وارد شده خالی است';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            // setState(() {
                                            //   _isButtonNextDisabled_page21_condition1 =
                                            //   !_formKey_secondPassword
                                            //       .currentState!
                                            //       .validate();
                                            // });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x32E1E3E0),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('پرداخت'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    if (pageIndex == 307) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                        flex: 10,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("پرداخت قبض رایتل")))),
                    Expanded(flex: 2, child: Container()),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addToMyBillsList = false;
                            _rightelBillController1.text = "";
                            _rightelBillController2.text = "";
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/close_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 16,
            // child: Screenshot(
            //   controller: screenshotController,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 10),
                      color: Colors.transparent,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    'assets/image_icon/success_payment.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: MyColors.otp_underline,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ))),
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(DateTime.now().toPersianDate(
                                  twoDigits: true,
                                  showTime: true,
                                  timeSeprator: ' - ')),
                              //۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

                              Spacer(),
                              Text(
                                "تاریخ و ساعت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                  "${(midTermSelected) ? rightelInquiryResult.midTerm!.billID : rightelInquiryResult.finalTerm!.billID}"),
                              Spacer(),
                              Text(
                                "شناسه قبض",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text((midTermSelected)
                                  ? ((rightelInquiryResult
                                              .midTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.midTerm!.paymentID}"
                                  : ((rightelInquiryResult
                                              .finalTerm!.paymentID!) ==
                                          "")
                                      ? "پرداخت شده"
                                      : "${rightelInquiryResult.finalTerm!.paymentID}"),
                              Spacer(),
                              Text(
                                "شناسه پرداخت",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                (midTermSelected)
                                    ? rightelInquiryResult.midTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال"
                                    : rightelInquiryResult.finalTerm!.amount!
                                            .toString()
                                            .seRagham() +
                                        " ریال",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                "مبلغ پرداختی",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(orderId),
                              Spacer(),
                              Text(
                                "شماره پیگیری",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: Container()),
              ],
            ),
            // ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 45,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              // screenshotController.capture().then((Uint8List? image) {
                              //   //Capture Done
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/image_icon/save_in_gallery.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              // screenshotController.capture().then((Uint8List? image) async {
                              //   //Capture Done
                              //
                              //   if (image != null) {
                              //     final directory = await getApplicationDocumentsDirectory();
                              //     final imagePath = await File('${directory.path}/image.png').create();
                              //     await imagePath.writeAsBytes(image);
                              //
                              //     /// Share Plugin
                              //     await Share.shareFiles([imagePath.path]);
                              //   }
                              //
                              // }).catchError((onError) {
                              //   print(onError);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/image_icon/share.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }

    if (pageIndex == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Image.asset(
                          'assets/image_icon/back_icon.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("ویرایش قبض")))),
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_icon/hint_green_icon.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Text(
                    "شما می توانید جهت تمایز با سایر قبوض برای قبض خود یک عنوان دلخواه انتخاب نمایید",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ))),
          Expanded(
              flex: 14,
              child: Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Form(
                        key: _formKey_edit_bill,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                maxLength: 16,
                                controller: _editBillController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مقدار وارد شده خالی است';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonNextDisabled_edit =
                                        !_formKey_edit_bill.currentState!
                                            .validate();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  suffixStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  hintText: "عنوان (مثال قبض آب مهر ماه)",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0x32E1E3E0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (_isButtonNextDisabled_edit)
                            ? null
                            : () {
                                UpdateBillParam updateBillParam =
                                    UpdateBillParam(
                                        billId: selectedBillForUpdate.id!,
                                        billType:
                                            selectedBillForUpdate.type!.toInt(),
                                        billCode: selectedBillForUpdate.code!,
                                        billTitle: _editBillController.text
                                            .toString());

                                BlocProvider.of<BillBloc>(context)
                                    .add(UpdateBillEvent(updateBillParam));
                              },
                        child: Text('ثبت'),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 35, right: 35, top: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          )
        ],
      );
    }
  }

  createMyBillsItems(List<Value> bills) {
    List<Widget> items = [];

    for (var i = 0; i < bills.length; i++) {
      items.add(Container(
        height: 85,
        width: double.infinity,
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (bills[i].type == 300) {
                        //water inquiry
                        WaterBillInquiryParam waterBillInquiryParam =
                            WaterBillInquiryParam(
                                waterBillID: bills[i].code!, traceNumber: "");
                        _waterBillController1.text = bills[i].code!.trim();
                        _waterBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_water_1 = false;
                        _isButtonNextDisabled_water_2 = false;

                        BlocProvider.of<BillBloc>(context)
                            .add(WaterBillInquiryEvent(waterBillInquiryParam));
                      }
                      if (bills[i].type == 301) {
                        //bargh inquiry
                        BarghBillInquiryParam barghBillInquiryParam =
                            BarghBillInquiryParam(
                                electricityBillID: bills[i].code!,
                                traceNumber: "");
                        _barghBillController1.text = bills[i].code!.trim();
                        _barghBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_bargh_1 = false;
                        _isButtonNextDisabled_bargh_2 = false;

                        BlocProvider.of<BillBloc>(context)
                            .add(BarghBillInquiryEvent(barghBillInquiryParam));
                      }
                      if (bills[i].type == 302) {
                        //fixline inquiry
                        FixLineBillInquiryParam fixLineBillInquiryParam =
                            FixLineBillInquiryParam(
                                fixedLineNumber: bills[i].code!,
                                traceNumber: "");
                        _phoneBillController1.text = bills[i].code!.trim();
                        _phoneBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_phone_1 = false;
                        _isButtonNextDisabled_phone_2 = false;

                        BlocProvider.of<BillBloc>(context).add(
                            FixLineBillInquiryEvent(fixLineBillInquiryParam));
                      }
                      if (bills[i].type == 306) {
                        //gas inquiry
                        GasBillInquiryParam gasBillInquiryParam =
                            GasBillInquiryParam(
                                participateCode: "",
                                gasBillID: bills[i].code!,
                                traceNumber: "");
                        _gazBillController1.text = bills[i].code!.trim();
                        _gazBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_gas_1 = false;
                        _isButtonNextDisabled_gas_2 = false;

                        BlocProvider.of<BillBloc>(context)
                            .add(GasBillInquiryEvent(gasBillInquiryParam));
                      }
                      if (bills[i].type == 310) {
                        //mci inquiry
                        FixMobileBillInquiryParam fixMobileBillInquiryParam =
                            FixMobileBillInquiryParam(
                                mobileNumber: bills[i].code!, traceNumber: "");
                        _mciBillController1.text = bills[i].code!.trim();
                        _mciBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_mci_1 = false;
                        _isButtonNextDisabled_mci_2 = false;
                        BlocProvider.of<BillBloc>(context).add(
                            MciBillInquiryEvent(fixMobileBillInquiryParam));
                      }
                      if (bills[i].type == 311) {
                        //mtn inquiry
                        FixMobileBillInquiryParam fixMobileBillInquiryParam =
                            FixMobileBillInquiryParam(
                                mobileNumber: bills[i].code!, traceNumber: "");
                        _mtnBillController1.text = bills[i].code!.trim();
                        _mtnBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_mtn_1 = false;
                        _isButtonNextDisabled_mtn_2 = false;
                        BlocProvider.of<BillBloc>(context).add(
                            MtnBillInquiryEvent(fixMobileBillInquiryParam));
                      }
                      if (bills[i].type == 312) {
                        //rightel inquiry
                        FixMobileBillInquiryParam fixMobileBillInquiryParam =
                            FixMobileBillInquiryParam(
                                mobileNumber: bills[i].code!, traceNumber: "");
                        _rightelBillController1.text = bills[i].code!.trim();
                        _rightelBillController2.text = bills[i].title!.trim();
                        _isButtonNextDisabled_rightel_1 = false;
                        _isButtonNextDisabled_rightel_2 = false;
                        BlocProvider.of<BillBloc>(context).add(
                            RightelBillInquiryEvent(fixMobileBillInquiryParam));
                      }

                      setState(() {
                        isSimpleInquiry = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(
                          color: MyColors.button_bg_enabled,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        "استعلام",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.button_bg_enabled, fontSize: 12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext _context) {
                                return BlocProvider.value(
                                  value: context.read<BillBloc>(),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      width: 300.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 40.0,
                                          ),
                                          Text(
                                            "آیا از حذف قبض مورد نظر اطمینان دارید؟",
                                            style: TextStyle(fontSize: 12.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    child: Text(
                                                      "خیر",
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.red),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                thickness: 10,
                                                color: Colors.black54,
                                                width: 2,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<BillBloc>(
                                                            context)
                                                        .add(DeleteBillEvent(
                                                            bills[i].id!));
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    child: Text(
                                                      "بله",
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: MyColors
                                                              .button_bg_enabled),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Container(
                            child: Image.asset(
                              'assets/image_icon/delete_bill_icon.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedBillForUpdate = bills[i];
                            _editBillController.text = bills[i].title!;
                            pageIndex = 2;
                          });
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Container(
                            child: Image.asset(
                              'assets/image_icon/edit_bill_icon.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${bills[i].title}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "شناسه قبض : ${bills[i].code}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    prepareBillIcon(bills[i].type!.toInt()),
                    fit: BoxFit.scaleDown,
                  ),
                ))
          ],
        ),
      ));
      items.add(SizedBox(
        height: 20,
      ));
    }

    return items;
  }

  prepareBillIcon(int codeType) {
    if (codeType == 300) {
      return 'assets/image_icon/water_bill_icon.png';
    }
    if (codeType == 301) {
      return 'assets/image_icon/bargh_bill_icon.png';
    }
    if (codeType == 302) {
      return 'assets/image_icon/phone_bill_icon.png';
    }
    if (codeType == 306) {
      return 'assets/image_icon/gas_bill_icon.png';
    }

    if (codeType == 310) {
      return 'assets/image_icon/hamrah_aval_icon.png';
    }
    if (codeType == 311) {
      return 'assets/image_icon/irancell_icon.png';
    }
    if (codeType == 312) {
      return 'assets/image_icon/gas_bill_icon.png';
    }
    return 'assets/image_icon/rightel_icon.png';
  }

  _isFixLinePaymentEnabled() {
    if (midTermSelected) {
      if ((fixLineInquiryResult.midTerm!.paymentID!.trim() == "")) {
        null;
      } else {
        () {
          BlocProvider.of<BillBloc>(context).add(GetBalanceEvent());

          if (_addToMyBillsList) {
            CreateBillParam createBillParam = CreateBillParam(
                billType: 302,
                billCode: _phoneBillController1.text.toString(),
                billTitle: _phoneBillController2.text.toString());
            BlocProvider.of<BillBloc>(context)
                .add(CreateBillEvent(createBillParam));
          }

          setState(() {
            pageIndex = 3444;
          });
        };
      }
    } else {
      if ((fixLineInquiryResult.finalTerm!.paymentID!.trim() == "")) {
        null;
      } else {
        () {
          BlocProvider.of<BillBloc>(context).add(GetBalanceEvent());

          if (_addToMyBillsList) {
            CreateBillParam createBillParam = CreateBillParam(
                billType: 302,
                billCode: _phoneBillController1.text.toString(),
                billTitle: _phoneBillController2.text.toString());
            BlocProvider.of<BillBloc>(context)
                .add(CreateBillEvent(createBillParam));
          }
          setState(() {
            pageIndex = 3444;
          });
        };
      }
    }
  }

  _getPhoneNumber() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TokenKeeper.getPhoneNumber().then((value) {
        setState(() {
          if (value == "") {
            phoneNumber = "***";
          } else {
            phoneNumber = value;
          }
        });
      });
    });
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        content: Align(
            alignment: Alignment.centerRight,
            child: Text(
              message,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "shabnam_bold"),
            ))));
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       duration: Duration(seconds: 4),
    //       content: Align(
    //           alignment: Alignment.centerRight,
    //           child: Text(
    //             message,
    //             style: TextStyle(fontFamily: "shabnam_bold"),
    //           ))));
    // });
  }

  _showSnackBarPost(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          content: Align(
              alignment: Alignment.centerRight,
              child: Text(
                message,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: "shabnam_bold"),
              ))));
    });
  }
}
