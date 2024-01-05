import 'package:get_it/get_it.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/export_history_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/import_history_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/info_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/goods_issue_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/goods_receipt_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/inventory_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/item_lot_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/item_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/location_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/login_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/other/lot_adjustment_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/department_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/export_history_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/goods_issue_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/goods_receipt_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/import_history_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/inventory_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/item_lot_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/item_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/list_purchaseorder_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/list_supplier_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/location_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/login_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/other/lot_adjustment_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/export_history_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/info_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/inventory_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/item_lot_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/location_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/lot_adjment_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/export_history_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/import_history_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/info_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/inventory_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/login_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/lot_adjustment_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/adjustment_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/export_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/import_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/inventory_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/isolation_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_goods_issue_completed_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_issue_entry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_lot_issue_completed_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/add_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/completed_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/update_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/shelve_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/warning_bloc.dart';

import 'datasource/service/list_receiver_service.dart';
import 'domain/repositories/login_repository.dart';
import 'domain/repositories/other/goods_issue_repository.dart';
import 'domain/repositories/other/goods_receipt_repository.dart';
import 'domain/repositories/other/import_history_repository.dart';
import 'domain/usecases/other/goods_issue_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
//register data service
  injector.registerSingleton<LoginService>(LoginService());
  injector.registerSingleton<ItemService>(ItemService());
  injector.registerSingleton<DepartmentService>(DepartmentService());
  injector.registerSingleton<ReceiverListService>(ReceiverListService());
  injector.registerSingleton<PODataService>(PODataService());
  injector.registerSingleton<SupplierService>(SupplierService());

  injector.registerSingleton<GoodsIssueService>(GoodsIssueService());
  injector.registerSingleton<GoodsReceiptService>(GoodsReceiptService());

  injector.registerSingleton<ItemLotService>(ItemLotService());
  injector.registerSingleton<LotAdjustmentService>(LotAdjustmentService());
  injector.registerSingleton<LocationService>(LocationService());
  injector.registerSingleton<InventoryService>(InventoryService());
  injector.registerSingleton<ImportHistoryService>(ImportHistoryService());
  injector.registerSingleton<ExportHistoryService>(ExportHistoryService());

// register repository
  injector.registerSingleton<LoginRepository>(LoginRepositoryImpl(injector()));
  injector.registerSingleton<ItemRepository>(ItemRepoImpl(injector()));
  injector.registerSingleton<ItemLotRepository>(ItemLotRepoImpl(injector()));
  injector.registerSingleton<LocationRepository>(LocationRepoImpl(injector()));

  injector.registerSingleton<LotAdjustmentRepository>(
      LotAjustmentRepoImpl(injector()));
  injector.registerSingleton<InfoRepository>(
      InfoRepoImpl(injector(), injector(), injector(), injector()));
  injector.registerSingleton<GoodsReceiptRepository>(
      GoodsReceiptRepoImpl(injector()));
  injector
      .registerSingleton<GoodsIssueRepository>(GoodsIssueRepoImpl(injector()));
  injector
      .registerSingleton<InventoryRepository>(InventoryRepoImpl(injector()));
  injector.registerSingleton<ImportHistoryRepoitory>(
      ImportHistoryRepoImpl(injector()));
  injector.registerSingleton<ExportHistoryRepoitory>(
      ExportHistoryRepoImpl(injector()));

// register usecase
  injector.registerSingleton<LoginUsecase>(LoginUsecase(injector()));
  injector.registerSingleton<ItemUsecase>(ItemUsecase(injector()));
  injector.registerSingleton<ItemLotUsecase>(ItemLotUsecase(injector()));
  injector.registerSingleton<LotAdjustmentUsecase>(
      LotAdjustmentUsecase(injector()));
  injector.registerSingleton<LocationUsecase>(LocationUsecase(injector()));

  injector.registerSingleton<InfoUsecase>(InfoUsecase(injector()));
  injector
      .registerSingleton<GoodsReceiptUsecase>(GoodsReceiptUsecase(injector()));
  injector.registerSingleton<GoodsIssueUseCase>(GoodsIssueUseCase(injector()));
  injector.registerSingleton<Inventoryusecase>(Inventoryusecase(injector()));
  injector.registerSingleton<ImportHistoryUsecase>(
      ImportHistoryUsecase(injector()));
  injector.registerSingleton<ExportHistoryUsecase>(
      ExportHistoryUsecase(injector()));

// register bloc
  injector.registerSingleton<LoginBloc>(LoginBloc(injector()));
  //receipt
  injector.registerSingleton<CreateReceiptBloc>(
      CreateReceiptBloc(injector(), injector()));
  injector.registerSingleton<FillReceiptLotBloc>(
      FillReceiptLotBloc(injector(), injector()));
  injector.registerSingleton<ExportingReceiptBloc>(
      ExportingReceiptBloc(injector()));
  injector.registerSingleton<ExportingReceiptLotBloc>(
      ExportingReceiptLotBloc(injector()));
  injector.registerSingleton<CompletedReceiptBloc>(
      CompletedReceiptBloc(injector()));
  injector.registerSingleton<CompletedReceiptLotBloc>(
      CompletedReceiptLotBloc(injector()));
  injector.registerSingleton<FillInfoNewReceiptLotBloc>(
      FillInfoNewReceiptLotBloc(injector(), injector(), injector()));
  injector.registerSingleton<GoodsReceiptSublotBloc>(
      GoodsReceiptSublotBloc(injector(), injector()));
  //issue
  injector.registerSingleton<CreateIssueBloc>(
      CreateIssueBloc(injector(), injector()));
  injector.registerSingleton<FillInfoIssueEntryBloc>(
      FillInfoIssueEntryBloc(injector(), injector()));
  injector.registerSingleton<ListGoodsIssueUncompletedBloc>(
      ListGoodsIssueUncompletedBloc(injector()));
  injector.registerSingleton<ListGoodsIssueEntryBloc>(
      ListGoodsIssueEntryBloc(injector()));
  injector.registerSingleton<ListGoodsIssueLotUncompletedBloc>(
      ListGoodsIssueLotUncompletedBloc(injector(), injector()));
  injector.registerSingleton<ListGoodsIssueCompletedBloc>(
      ListGoodsIssueCompletedBloc(injector()));
  injector.registerSingleton<ListGoodsIssueLotCompletedBloc>(
      ListGoodsIssueLotCompletedBloc(injector()));
  //lot adjustment
  injector.registerSingleton<AdjustmentBloc>(
      AdjustmentBloc(injector(), injector()));
  //invenory
  injector.registerSingleton<InventoryBloc>(
      InventoryBloc(injector(), injector(), injector(), injector()));
  // history
  injector.registerSingleton<ImportHistoryBloc>(
      ImportHistoryBloc(injector(), injector(), injector(), injector()));
  injector.registerSingleton<ExportHistoryBloc>(
      ExportHistoryBloc(injector(), injector(), injector(), injector()));
  injector.registerSingleton<WarningBloc>(
      WarningBloc(injector(), injector(), injector()));
  injector.registerSingleton<ShelveBloc>(
      ShelveBloc(injector(), injector(), injector()));
  injector.registerSingleton<IsolationBloc>(IsolationBloc(
    injector(),
    injector(),
  ));
}
