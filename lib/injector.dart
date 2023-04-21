// ignore_for_file: unused_import

import 'package:get_it/get_it.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/department_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/goods_issue_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/goods_receipt_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/inventory_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/item_lot_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/item_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/location_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/login_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/repositories_impl/lot_adjustment_repo_impl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/department_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/goods_issue_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/goods_receipt_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/inventory_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/item_lot_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/item_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/location_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/login_service.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/lot_adjustment_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/department_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/goods_issue_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/goods_receipt_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/inventory_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_lot_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/location_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/lot_adjment_repository.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/department_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/inventory_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/login_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/lot_adjustment_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/adjustment_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_lot_bloc.dart';

import 'domain/repositories/login_repository.dart';
import 'presentation/bloc/blocs/history_bloc.dart';
import 'presentation/bloc/blocs/inventory_bloc.dart';
import 'presentation/bloc/blocs/shelve_bloc.dart';
import 'presentation/bloc/blocs/warning_bloc.dart';
import 'presentation/bloc/blocs/isolation_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
//register data service
  injector.registerSingleton<DepartmentService>(DepartmentService());
  injector.registerSingleton<GoodsIssueService>(GoodsIssueService());
  injector.registerSingleton<GoodsReceiptService>(GoodsReceiptService());
  injector.registerSingleton<InventoryService>(InventoryService());
  injector.registerSingleton<ItemLotService>(ItemLotService());
  injector.registerSingleton<ItemService>(ItemService());
  injector.registerSingleton<LocationService>(LocationService());
  injector.registerSingleton<LoginService>(LoginService());
  injector.registerSingleton<LotAdjustmentService>(LotAdjustmentService());

// register repository
  injector
      .registerSingleton<DepartmentRepository>(DepartmentRepoImpl(injector()));
  injector
      .registerSingleton<GoodsIssueRepository>(GoodsIssueRepoImpl(injector()));
  injector.registerSingleton<GoodsReceiptRepository>(
      GoodsReceiptRepoImpl(injector()));
  injector
      .registerSingleton<InventoryRepository>(InventoryRepoImpl(injector()));
  injector.registerSingleton<ItemRepository>(ItemRepoImpl(injector()));
  injector.registerSingleton<ItemLotRepository>(ItemLotRepoImpl(injector()));
  injector.registerSingleton<LocationRepository>(LocationRepoImpl(injector()));
  injector.registerSingleton<LoginRepository>(LoginRepositoryImpl(injector()));
  injector.registerSingleton<LotAdjustmentRepository>(
      LotAjustmentRepoImpl(injector()));

// register usecase
  injector.registerSingleton<DepartmentUsecase>(DepartmentUsecase(injector()));
  injector.registerSingleton<GoodsIssueUseCase>(GoodsIssueUseCase(injector()));
  injector
      .registerSingleton<GoodsReceiptUsecase>(GoodsReceiptUsecase(injector()));
  injector.registerSingleton<InventoryUsecase>(InventoryUsecase(injector()));
  injector.registerSingleton<ItemLotUsecase>(ItemLotUsecase(injector()));
  injector.registerSingleton<ItemUsecase>(ItemUsecase(injector()));
  injector.registerSingleton<LocationUsecase>(LocationUsecase(injector()));
  injector.registerSingleton<LoginUsecase>(LoginUsecase(injector()));
  injector.registerSingleton<LotAdjustmentUsecase>(
      LotAdjustmentUsecase(injector()));

// register bloc
  injector.registerSingleton<LoginBloc>(LoginBloc(injector()));
  injector.registerSingleton<CreateReceiptBloc>(
      CreateReceiptBloc(injector(), injector()));
  injector.registerSingleton<FillReceiptLotBloc>(
      FillReceiptLotBloc(injector(), injector()));
  injector.registerSingleton<ExportingReceiptBloc>(ExportingReceiptBloc(
    injector(),
  ));
  injector.registerSingleton<ExportingReceiptLotBloc>(ExportingReceiptLotBloc(
    injector(),
  ));
  injector.registerSingleton<CompletedReceiptBloc>(CompletedReceiptBloc(
    injector(),
  ));
  injector.registerSingleton<CompletedReceiptLotBloc>(CompletedReceiptLotBloc(
    injector(),
  ));
   injector.registerSingleton<CreateIssueBloc>(CreateIssueBloc(
    injector(),injector()
  ));
   injector.registerSingleton<FillInfoIssueEntryBloc>(FillInfoIssueEntryBloc(
    injector(),injector()
  ));
     injector.registerSingleton<ListGoodsIssueUncompletedBloc>(ListGoodsIssueUncompletedBloc(
    injector(),
  ));
  

  //==

  injector.registerSingleton<WarningBloc>(WarningBloc(injector(), injector(), injector()));
  injector.registerSingleton<ShelveBloc>(
      ShelveBloc(injector(), injector(), injector()));
  injector.registerSingleton<InventoryBloc>(
      InventoryBloc(injector(), injector(), injector()));
  injector.registerSingleton<AdjustmentBloc>(
      AdjustmentBloc(injector(), injector(), injector(), injector()));
  injector.registerSingleton<IsolationBloc>(IsolationBloc(
    injector(),
    injector(),
  ));
  injector.registerSingleton<HistoryBloc>(HistoryBloc(
    injector(),
    injector(),
    injector(),
    injector(),
    injector(),
  ));
}
