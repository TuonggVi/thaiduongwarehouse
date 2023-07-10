import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/import_history_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/info_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/history_event/import_history_event.dart';

import '../../../../../domain/entities/item.dart';
import '../../../../../domain/usecases/other/import_history_usecase.dart';
import '../../../states/other/history_state/import_history_state.dart';

class ImportHistoryBloc extends Bloc<ImportHistoryEvent, ImportHistoryState> {
  ItemUsecase itemUsecase;
  InfoUsecase infoUsecase;
  LocationUsecase locationUsecase;
  ImportHistoryUsecase importHistoryUsecase;
  // GoodsReceiptUsecase goodsReceiptUseCase;
  ImportHistoryBloc(this.importHistoryUsecase, this.infoUsecase,
      this.locationUsecase, this.itemUsecase)
      : super(GetAllInfoImportLoadingState(DateTime.now())) {
    // hiển thị list kho hàng, itemId, bộ phận

    on<GetAllInfoImportEvent>((event, emit) async {
      emit(GetAllInfoImportLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
        final poNumber = await infoUsecase.getAllPO();
        final supplier = await infoUsecase.getAllSupplier();
        emit(GetAllInfoImportSuccessState(
            DateTime.now(), poNumber, warehouse, item, supplier));
      } catch (e) {
        emit(GetAllInfoImportFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    //list sản phẩm theo kho hàng
    on<GetImportItemByWarehouseEvent>((event, emit) async {
      emit(GetImportItemByWarehouseLoadingState(DateTime.now()));
      try {
        List<Item> item = event.listAllItem
            .expand((e) => [if (e.itemClass == event.warehouseId) e])
            .toList();
        emit(GetImportItemByWarehouseSuccessState(
            DateTime.now(),
            event.poNumber,
            event.listAllItem,
            item,
            event.warehouse,
            event.supplier));
      } catch (e) {
        emit(GetImportItemByWarehouseFailState(
            DateTime.now(), ErrorPackage('')));
      }
    });
    // truy xuất lịch sử nhập kho
    on<AccessImportHistoryByPOEvent>((event, emit) async {
            List<ImportHistoryView> test = [];

      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots = await importHistoryUsecase
            .getImportHistoryByPO(event.purchaseOrderNumber);
             for (var element in goodReceiptLots) {
          if (element.lots!.isNotEmpty) {
            for (var e in element.lots!) {
              test.add(ImportHistoryView(e.goodsReceiptLotId, e.quantity, e.purchaseOrderNumber, e.item!.itemName, e.note, element.supplier, element.timestamp));
            }
          }
        }
        goodReceiptLots.isNotEmpty
            ? emit(AccessImportHistorySuccessState(
                DateTime.now(),
                test,
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplier))
            : emit(AccessImportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplier));
      } catch (e) {
        emit(AccessImportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.supplier));
      }
    });
    on<AccessImportHistoryBySupplierEvent>((event, emit) async {
      List<ImportHistoryView> test = [];

      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots =
            await importHistoryUsecase.getImportHistoryBySupplier(
                event.supplier, event.startDate, event.endDate);
 for (var element in goodReceiptLots) {
          if (element.lots!.isNotEmpty) {
            for (var e in element.lots!) {
              test.add(ImportHistoryView(e.goodsReceiptLotId, e.quantity, e.purchaseOrderNumber, e.item!.itemName, e.note, element.supplier, element.timestamp));
            }
          }
        }
        goodReceiptLots.isNotEmpty
            ? emit(AccessImportHistorySuccessState(
                DateTime.now(),
                test,
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplierList))
            : emit(AccessImportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplierList));
      } catch (e) {
        emit(AccessImportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.supplierList));
      }
    });
    on<AccessImportHistoryByItemIdEvent>((event, emit) async {
      List<ImportHistoryView> test = [];
      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots =
            await importHistoryUsecase.getImportHistoryByItem(
          event.warehouseId,
          event.itemId,
          event.startDate,
          event.endDate,
        );
      
        for (var element in goodReceiptLots) {
          if (element.lots!.isNotEmpty) {
            for (var e in element.lots!) {
              test.add(ImportHistoryView(e.goodsReceiptLotId, e.quantity, e.purchaseOrderNumber, e.item!.itemName, e.note, element.supplier, element.timestamp));
            }
          }
        }
        goodReceiptLots.isNotEmpty
            ? emit(AccessImportHistorySuccessState(
                DateTime.now(),
                test,
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplierList))
            : emit(AccessImportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.supplierList));
      } catch (e) {
        emit(AccessImportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.supplierList));
      }
    });
  }
}
