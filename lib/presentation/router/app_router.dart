// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/injector.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/inventory_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_issue_entry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/create_new_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/fill_info_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/shelve_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/warning_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/create_new_issue_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/export_function_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/fill_info_lot_issue_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/list_entry_issue_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/list_good_issue_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/create_new_receipt_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/fill_info_lot_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/import_function_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/list_completed_receipt.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/list_completed_receipt_lot_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/list_uncompleted_receipt.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/import/list_uncompleted_receipt_lot_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/others/home_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/others/login_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/others/main_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/shelves/shelves_function_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/warning/warning_function_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/warning/warning_under_stockmin.dart';

import '../bloc/blocs/adjustment_bloc.dart';
import '../bloc/blocs/history_bloc.dart';
import '../bloc/blocs/isolation_bloc.dart';
import '../screens/adjustment/lot_adjust_screen.dart';
import '../screens/adjustment/scan_adjustment_screen.dart';
import '../screens/history/export_history_screen.dart';
import '../screens/history/history_function_screen.dart';
import '../screens/history/import_history_screen.dart';
import '../screens/history/list_export_history_screen.dart';
import '../screens/history/list_import_history_screen.dart';

import '../screens/inventory/stockcard_function_screen.dart';
import '../screens/isolation/isolation_function_screen.dart';
import '../screens/isolation/isolation_item_screen.dart';
import '../screens/isolation/isolation_update_screen.dart';
import '../screens/shelves/search_item_screen.dart';
import '../screens/shelves/search_shelf_screen.dart';
import '../screens/warning/warning_expired_screen.dart';

import '../bloc/events/issue_event/list_lot_issue_event.dart';
import '../screens/export/fill_main_info_issue_screen.dart';
import '../screens/export/list_lot_issue_screen.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '//':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<LoginBloc>(create: (context) => injector()),
                ], child: LoginScreen()));
      case '/main_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<LoginBloc>(create: (context) => injector()),
                ], child: const MainScreen()));
      case '/main_receipt_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<CompletedReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<ExportingReceiptBloc>(
                      create: (context) => injector()),
                ], child: const ImportFunctionScreen()));
      case '/create_receipt_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const CreateNewReceiptScreen()));
      case '/fill_lot_receipt_screen':
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillReceiptLotBloc>(
                      create: (context) => injector()),

                  BlocProvider<ExportingReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const FillInfoLotReceiptScreen()));

      case '/importing_receipt_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ExportingReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<ExportingReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const ListUncompletedGoodReceiptScreen()));
      case '/importing_receipt_lot_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ExportingReceiptLotBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const ListUncompletedLotReceiptScreen()));
      case '/imported_receipt_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CompletedReceiptBloc>(
                      create: (context) => injector()),
                  BlocProvider<CompletedReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const ListCompletedReceiptScreen()));
      case '/imported_receipt_lot_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CompletedReceiptLotBloc>(
                      create: (context) => injector()),
                ], child: const ListCompletedLotReceiptScreen()));
      case '/export_main_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateIssueBloc>(
                      create: (context) => injector()),
                  BlocProvider<ListGoodsIssueUncompletedBloc>(
                      create: (context) => injector()),
                ], child: const ExportFunctionScreen()));
      case '/create_issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateIssueBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillInfoIssueEntryBloc>(
                      create: (context) => injector()),
                ], child: const CreateNewIssueScreen()));
      case '/fill_info_entry_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateIssueBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillInfoIssueEntryBloc>(
                      create: (context) => injector()),
                ], child: const FillInfoEntryIssueScreen()));

      case '/fill_main_info_issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<CreateIssueBloc>(
                      create: (context) => injector()),
                  BlocProvider<FillInfoIssueEntryBloc>(
                      create: (context) => injector()),
                ], child: const FillMainInFoIssueScreen()));
      case '/list_goods_issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ListGoodsIssueUncompletedBloc>(
                      create: (context) => injector()),
                  BlocProvider<ListGoodsIssueEntryBloc>(
                      create: (context) => injector()),
                  BlocProvider<ListGoodsIssueLotUncompletedBloc>(
                      create: (context) => injector()),
                ], child: const ListGoodIssueScreen()));
      // case '/list_goods_issue_entry_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(providers: [
      //             BlocProvider<ListGoodsIssueLotUncompletedBloc>(
      //                 create: (context) => injector()),
      //             BlocProvider<ListGoodsIssueEntryBloc>(
      //                 create: (context) => injector()),

      //           ], child: const CreateNewIssueScreen()));
      // case 'fill_info_entry_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(providers: [
      //             BlocProvider<CreateIssueBloc>(
      //                 create: (context) => injector()),
      //             BlocProvider<FillInfoIssueEntryBloc>(
      //                 create: (context) => injector()),
      //           ], child: const FillInfoEntryIssueScreen()));
      //--
      case '/shelves_function_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ShelveBloc>(create: (context) => injector()),
                ], child: const ShelveFunctionScreen()));
      case '/search_item_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ShelveBloc>(create: (context) => injector()),
                ], child: const SearchItemScreen()));
      case '/search_shelf_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ShelveBloc>(create: (context) => injector()),
                ], child: const SearchShelfScreen()));
      //---
      case '/warning_function_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<WarningBloc>(create: (context) => injector()),
                ], child: const WarningFunctionScreen()));
      case '/warning_expired_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<WarningBloc>(create: (context) => injector()),
                ], child: const WarningExpiredScreen()));
      case '/warning_under_stockmin':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<WarningBloc>(create: (context) => injector()),
                ], child: const WarningUnderStockminScreen()));
      //---
      case '/stockcard_function_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<InventoryBloc>(create: (context) => injector()),
                ], child: const StockcardFunctionScreen()));
      case '/scan_item_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<InventoryBloc>(create: (context) => injector()),
                ], child: const BarcodeScannerScreen()));
      case '/inventory_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<InventoryBloc>(create: (context) => injector()),
                ], child:const StockcardScreen()));
      // case '/product_inventory_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(providers: [
      //             BlocProvider<InventoryBloc>(create: (context) => injector()),
      //           ], child: const ProductStockcardScreen()));
      //--
      case '/history_function_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<HistoryBloc>(create: (context) => injector()),
                ], child: const HistoryFunctionScreen()));
      case '/import_history_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<HistoryBloc>(create: (context) => injector()),
            
                ], child: const ImportHistoryScreen()));
       case '/list_import_history_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<HistoryBloc>(create: (context) => injector()),
                ], child: const ListImportHistoryScreen()));
      case '/export_history_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<HistoryBloc>(create: (context) => injector()),
                ], child: const ExportHistoryScreen()));
      case '/list_export_history_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<HistoryBloc>(create: (context) => injector()),
                ], child: const ListExportHistoryScreen()));
      //--
      case '/lot_adjustment_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<AdjustmentBloc>(create: (context) => injector()),
                ], child: const LotAdjustmentScreen()));
      case '/scan_adjustment_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<AdjustmentBloc>(create: (context) => injector()),
                ], child: const BarcodeScannerScreen()));
      //--
      case '/isolation_function_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IsolationBloc>(create: (context) => injector()),
                ], child: const IsolationFunctionScreen()));
      case '/isolation_item_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IsolationBloc>(create: (context) => injector()),
                ], child: const IsolationItemScreen()));
      case '/isolation_update_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IsolationBloc>(create: (context) => injector()),
                ], child: const UpdateIsolationItemScreen()));

      //           ], child: const ListGoodIssueEntryScreen()));
      case '/list_goods_issue_lot_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ListGoodsIssueLotUncompletedBloc>(
                      create: (context) => injector()),
                  BlocProvider<ListGoodsIssueUncompletedBloc>(
                      create: (context) => injector()),
                ], child: const ListLotIssueScreen()));

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
