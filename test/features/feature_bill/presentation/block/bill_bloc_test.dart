import 'package:atba_application/core/general/general_response_entity.dart';
import 'package:atba_application/core/params/bargh_bill_inquiry_param.dart';
import 'package:atba_application/core/params/create_bill_param.dart';
import 'package:atba_application/core/params/fixline_bill_inquiry_param.dart';
import 'package:atba_application/core/params/fixmobile_bill_inquiry_param.dart';
import 'package:atba_application/core/params/gas_bill_inquiry_param.dart';
import 'package:atba_application/core/params/update_bill_param.dart';
import 'package:atba_application/core/params/water_bill_inquiry_param.dart';
import 'package:atba_application/core/resources/data_state.dart';
import 'package:atba_application/features/feature_bill/domain/entities/bargh_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/fixline_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/gas_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_balance_entity_bill.dart';
import 'package:atba_application/features/feature_bill/domain/entities/get_bills_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mci_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/mtn_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/payment_from_wallet_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/rightel_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/entities/water_bill_inquiry_entity.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/bargh_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/create_bill_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/delete_bill_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/fixline_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/gas_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/get_balance_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/get_bills_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/mci_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/mtn_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/payment_from_wallet_bill_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/rightel_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/update_bill_usecase.dart';
import 'package:atba_application/features/feature_bill/domain/use_cases/water_bill_inquiry_usecase.dart';
import 'package:atba_application/features/feature_bill/presentation/block/bill_bloc.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/balance_status_bill.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/bargh_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/bill_page_index_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/bills_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/create_bill_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/delete_bill_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/fixline_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/gas_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mci_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/mtn_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/payment_from_wallet_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/rightel_bill_inquiry_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/update_bill_status.dart';
import 'package:atba_application/features/feature_bill/presentation/block/statuses/water_bill_inquiry_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bill_bloc_test.mocks.dart';

@GenerateMocks([
  GetBillsUseCase,
  CreateBillUseCase,
  UpdateBillUseCase,
  DeleteBillUseCase,
  BarghBillInquiryUseCase,
  WaterBillInquiryUseCase,
  GasBillInquiryUseCase,
  FixLineBillInquiryUseCase,
  MciBillInquiryUseCase,
  MtnBillInquiryUseCase,
  RightelBillInquiryUseCase,
  PaymentFromWalletBillUseCase,
  GetBalanceUseCase
])
void main() {
  MockGetBillsUseCase mockGetBillsUseCase = MockGetBillsUseCase();
  MockCreateBillUseCase mockCreateBillUseCase = MockCreateBillUseCase();
  MockUpdateBillUseCase mockUpdateBillUseCase = MockUpdateBillUseCase();
  MockDeleteBillUseCase mockDeleteBillUseCase = MockDeleteBillUseCase();
  MockBarghBillInquiryUseCase mockBarghBillInquiryUseCase =
      MockBarghBillInquiryUseCase();
  MockWaterBillInquiryUseCase mockWaterBillInquiryUseCase =
      MockWaterBillInquiryUseCase();
  MockGasBillInquiryUseCase mockGasBillInquiryUseCase =
      MockGasBillInquiryUseCase();
  MockFixLineBillInquiryUseCase mockFixLineBillInquiryUseCase =
      MockFixLineBillInquiryUseCase();
  MockMciBillInquiryUseCase mockMciBillInquiryUseCase =
      MockMciBillInquiryUseCase();
  MockMtnBillInquiryUseCase mockMtnBillInquiryUseCase =
      MockMtnBillInquiryUseCase();
  MockRightelBillInquiryUseCase mockRightelBillInquiryUseCase =
      MockRightelBillInquiryUseCase();
  MockPaymentFromWalletBillUseCase mockPaymentFromWalletBillUseCase =
      MockPaymentFromWalletBillUseCase();
  MockGetBalanceUseCase mockGetBalanceUseCase = MockGetBalanceUseCase();

  group('all Events test', () {
    test('getBills Success', () {
      when(mockGetBillsUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataSuccess(GetBillsEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(GetBillsEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsLoading(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsCompleted(GetBillsEntity()),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('getBills Error', () {
      when(mockGetBillsUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(GetBillsEvent());

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsLoading(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsError("error"),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('createBill Success', () {
      when(mockCreateBillUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(GeneralResponseEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      CreateBillParam createBillParam =
          CreateBillParam(billType: 1, billCode: "2", billTitle: "3");
      bloc.add(CreateBillEvent(createBillParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillLoading(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillCompleted(GeneralResponseEntity()),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('createBill Error', () {
      when(mockCreateBillUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      CreateBillParam createBillParam =
          CreateBillParam(billType: 1, billCode: "2", billTitle: "3");
      bloc.add(CreateBillEvent(createBillParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillLoading(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillError("error"),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('updateBill Success', () {
      when(mockUpdateBillUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(GeneralResponseEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      UpdateBillParam updateBillParam = UpdateBillParam(
          billId: "1", billType: 2, billCode: "3", billTitle: "4");
      bloc.add(UpdateBillEvent(updateBillParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillLoading(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillCompleted(GeneralResponseEntity()),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('updateBill Error', () {
      when(mockUpdateBillUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      UpdateBillParam updateBillParam = UpdateBillParam(
          billId: "1", billType: 2, billCode: "3", billTitle: "4");
      bloc.add(UpdateBillEvent(updateBillParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillLoading(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillError("error"),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('deleteBill Success', () {
      when(mockDeleteBillUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(GeneralResponseEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(DeleteBillEvent("1"));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillLoading(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillCompleted(GeneralResponseEntity()),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('deleteBill Error', () {
      when(mockDeleteBillUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(DeleteBillEvent("1"));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillLoading(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillError("error"),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('bargh inq Success', () {
      when(mockBarghBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(BarghBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      BarghBillInquiryParam barghBillInquiryParam =
          BarghBillInquiryParam(electricityBillID: "1", traceNumber: "2");
      bloc.add(BarghBillInquiryEvent(barghBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryLoading(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus:
                  BarghBillInquiryCompleted(BarghBillInquiryEntity()),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('bargh inq Error', () {
      when(mockBarghBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      BarghBillInquiryParam barghBillInquiryParam =
          BarghBillInquiryParam(electricityBillID: "1", traceNumber: "2");
      bloc.add(BarghBillInquiryEvent(barghBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryLoading(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryError("error"),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('water inq Success', () {
      when(mockWaterBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(WaterBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      WaterBillInquiryParam waterBillInquiryParam =
          WaterBillInquiryParam(waterBillID: "1", traceNumber: "2");
      bloc.add(WaterBillInquiryEvent(waterBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryLoading(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus:
                  WaterBillInquiryCompleted(WaterBillInquiryEntity()),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('water inq Error', () {
      when(mockWaterBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );

      WaterBillInquiryParam waterBillInquiryParam =
          WaterBillInquiryParam(waterBillID: "1", traceNumber: "2");
      bloc.add(WaterBillInquiryEvent(waterBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryLoading(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryError("error"),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('gas inq Success', () {
      when(mockGasBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(GasBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      GasBillInquiryParam gasBillInquiryParam = GasBillInquiryParam(
          participateCode: "1", gasBillID: "2", traceNumber: "3");
      bloc.add(GasBillInquiryEvent(gasBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryLoading(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus:
                  GasBillInquiryCompleted(GasBillInquiryEntity()),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('gas inq Error', () {
      when(mockGasBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      GasBillInquiryParam gasBillInquiryParam = GasBillInquiryParam(
          participateCode: "1", gasBillID: "2", traceNumber: "3");
      bloc.add(GasBillInquiryEvent(gasBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryLoading(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryError("error"),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('fixline inq Success', () {
      when(mockFixLineBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(FixLineBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixLineBillInquiryParam fixLineBillInquiryParam =
          FixLineBillInquiryParam(fixedLineNumber: "1", traceNumber: "2");
      bloc.add(FixLineBillInquiryEvent(fixLineBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryLoading(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus:
                  FixLineBillInquiryCompleted(FixLineBillInquiryEntity()),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('fixline inq Error', () {
      when(mockFixLineBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixLineBillInquiryParam fixLineBillInquiryParam =
          FixLineBillInquiryParam(fixedLineNumber: "1", traceNumber: "2");
      bloc.add(FixLineBillInquiryEvent(fixLineBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryLoading(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryError("error"),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('mci inq Success', () {
      when(mockMciBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(MciBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );

      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(MciBillInquiryEvent(fixMobileBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryLoading(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus:
                  MciBillInquiryCompleted(MciBillInquiryEntity()),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('mci inq  Error', () {
      when(mockMciBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(MciBillInquiryEvent(fixMobileBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryLoading(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryError("error"),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('mtn inq Success', () {
      when(mockMtnBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(MtnBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );

      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(MtnBillInquiryEvent(fixMobileBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryLoading(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus:
                  MtnBillInquiryCompleted(MtnBillInquiryEntity()),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('mtn inq Error', () {
      when(mockMtnBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(MtnBillInquiryEvent(fixMobileBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryLoading(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryError("error"),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('rightel inq  Success', () {
      when(mockRightelBillInquiryUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(RightelBillInquiryEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(RightelBillInquiryEvent(fixMobileBillInquiryParam));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryLoading(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus:
                  RightelBillInquiryCompleted(RightelBillInquiryEntity()),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('rightel inq Error', () {
      when(mockRightelBillInquiryUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      FixMobileBillInquiryParam fixMobileBillInquiryParam =
          FixMobileBillInquiryParam(mobileNumber: "1", traceNumber: "2");
      bloc.add(RightelBillInquiryEvent(fixMobileBillInquiryParam));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryLoading(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryError("error"),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('payment from wallet Success', () {
      when(mockPaymentFromWalletBillUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(PaymentFromWalletEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(PaymentFromWalletBillEvent("test"));
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletLoading(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus:
                  PaymentFromWalletCompleted(PaymentFromWalletEntity()),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    test('payment from wallet Error', () {
      when(mockPaymentFromWalletBillUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(PaymentFromWalletBillEvent("test"));

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletLoading(),
              balanceStatus: BalanceInit(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletError("error"),
              balanceStatus: BalanceInit(),
            ),
          ]));
    });
    //************************************************************************************************************
    test('get balance Success', () {
      when(mockGetBalanceUseCase.call(any)).thenAnswer(
          (_) async => Future.value(DataSuccess(GetBalanceEntity())));
      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(GetBalanceEvent());
      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceLoading(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceCompleted(GetBalanceEntity()),
            ),
          ]));
    });
    test('get balance Error', () {
      when(mockGetBalanceUseCase.call(any))
          .thenAnswer((_) async => Future.value(DataFailed("error")));

      final bloc = BillBloc(
        mockGetBillsUseCase,
        mockCreateBillUseCase,
        mockUpdateBillUseCase,
        mockDeleteBillUseCase,
        mockBarghBillInquiryUseCase,
        mockWaterBillInquiryUseCase,
        mockGasBillInquiryUseCase,
        mockFixLineBillInquiryUseCase,
        mockMciBillInquiryUseCase,
        mockMtnBillInquiryUseCase,
        mockRightelBillInquiryUseCase,
        mockPaymentFromWalletBillUseCase,
        mockGetBalanceUseCase,
      );
      bloc.add(GetBalanceEvent());

      expectLater(
          bloc.stream,
          emitsInOrder([
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceLoading(),
            ),
            BillState(
              pageBillIndexStatus: PageBillIndexStatus1(),
              billsStatus: BillsInit(),
              createBillStatus: CreateBillInit(),
              updateBillStatus: UpdateBillInit(),
              deleteBillStatus: DeleteBillInit(),
              barghBillInquiryStatus: BarghBillInquiryInit(),
              waterBillInquiryStatus: WaterBillInquiryInit(),
              gasBillInquiryStatus: GasBillInquiryInit(),
              fixLineBillInquiryStatus: FixLineBillInquiryInit(),
              mciBillInquiryStatus: MciBillInquiryInit(),
              mtnBillInquiryStatus: MtnBillInquiryInit(),
              rightelBillInquiryStatus: RightelBillInquiryInit(),
              paymentFromWalletStatus: PaymentFromWalletInit(),
              balanceStatus: BalanceError("error"),
            ),
          ]));
    });
    //************************************************************************************************************
  });
}
