import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/export_history_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/export_history_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/info_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/history_event/export_history_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/history_state/export_history_state.dart';

import '../../../../../domain/entities/item.dart';

class ExportHistoryBloc extends Bloc<ExportHistoryEvent, ExportHistoryState> {
  ItemUsecase itemUsecase;
  InfoUsecase infoUsecase;
  LocationUsecase locationUsecase;
  ExportHistoryUsecase exportHistoryUsecase;
  // GoodsReceiptUsecase goodsReceiptUseCase;
  ExportHistoryBloc(this.exportHistoryUsecase, this.infoUsecase,
      this.locationUsecase, this.itemUsecase)
      : super(GetAllInfoExportLoadingState(DateTime.now())) {
    // hiển thị list kho hàng, itemId, bộ phận
    on<GetAllInfoExportEvent>((event, emit) async {
      emit(GetAllInfoExportLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
        final receiver = await infoUsecase.getAllReceiver();
        final poNumber = await infoUsecase.getAllPO();

        emit(GetAllInfoExportSuccessState(
            DateTime.now(), item, poNumber, receiver, warehouse));
      } catch (e) {
        emit(GetAllInfoExportFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    on<GetExportItemByWarehouseEvent>((event, emit) async {
      emit(GetExportItemByWarehouseLoadingState(DateTime.now()));
      try {
        List<Item> item = event.listAllItem
            .expand((e) => [if (e.itemClass == event.warehouseId) e])
            .toList();
        emit(GetExportItemByWarehouseSuccessState(
            DateTime.now(),
            event.listAllItem,
            item,
            event.warehouse,
            event.poNumber,
            event.receiver));
      } catch (e) {
        emit(GetExportItemByWarehouseFailState(
            DateTime.now(), ErrorPackage('')));
      }
    });

    // truy xuất lịch sử xuất kho
    on<AccessExportHistoryByPOEvent>((event, emit) async {
      List<ExportHistoryView> exportHistoryView = [];
      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots = await exportHistoryUsecase
            .getExportHistoryByPO(event.purchaseOrderNumber);
        for (var element in goodIssueLots) {
          if (element.entries!.isNotEmpty) {
            for (var entry in element.entries!) {
              if (entry.lots!.isNotEmpty) {
                for (var lot in entry.lots!) {
                  exportHistoryView.add(ExportHistoryView(
                      lot.goodsIssueLotId,
                      lot.quantity,
                      lot.note,
                      element.receiver,
                      element.purchaseOrderNumber,
                      element.timestamp,
                      entry.item!.itemName,
                      entry.unit));
                }
              }
            }
          }
        }
        goodIssueLots.isNotEmpty
            ? emit(AccessExportHistorySuccessState(
                DateTime.now(),
                exportHistoryView,
                event.itemSort,
                event.listAllItem,
                event.warehouse,
                event.poNumber,
                event.receiverList))
            : emit(AccessExportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.receiverList));
      } catch (e) {
        emit(AccessExportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.receiverList));
      }
    });
    on<AccessExportHistoryByReceiverEvent>((event, emit) async {
      List<ExportHistoryView> exportHistoryView = [];

      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots =
            await exportHistoryUsecase.getExportHistoryByReceiver(
          event.receiver,
          event.startDate,
          event.endDate,
        );
        for (var element in goodIssueLots) {
          if (element.entries!.isNotEmpty) {
            for (var entry in element.entries!) {
              if (entry.lots!.isNotEmpty) {
                for (var lot in entry.lots!) {
                  exportHistoryView.add(ExportHistoryView(
                      lot.goodsIssueLotId,
                      lot.quantity,
                      lot.note,
                      element.receiver,
                      element.purchaseOrderNumber,
                      element.timestamp,
                      entry.item!.itemName,
                      entry.unit));
                }
              }
            }
          }
        }
        goodIssueLots.isNotEmpty
            ? emit(AccessExportHistorySuccessState(
                DateTime.now(),
                exportHistoryView,
                event.itemSort,
                event.listAllItem,
                event.warehouse,
                event.poNumber,
                event.receiverList))
            : emit(AccessExportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.receiverList));
      } catch (e) {
        emit(AccessExportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.receiverList));
      }
    });
    on<AccessExportHistoryByItemIdEvent>((event, emit) async {
      List<ExportHistoryView> exportHistoryView = [];

      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots = await exportHistoryUsecase.getExportHistoryByItem(
          event.warehouseId,
          event.itemId,
          event.startDate,
          event.endDate,
        );
        for (var element in goodIssueLots) {
          if (element.entries!.isNotEmpty) {
            for (var entry in element.entries!) {
              if (entry.lots!.isNotEmpty) {
                for (var lot in entry.lots!) {
                  exportHistoryView.add(ExportHistoryView(
                      lot.goodsIssueLotId,
                      lot.quantity,
                      lot.note,
                      element.receiver,
                      element.purchaseOrderNumber,
                      element.timestamp,
                      entry.item!.itemName,
                      entry.unit));
                }
              }
            }
          }
        }
        goodIssueLots.isNotEmpty
            ? emit(AccessExportHistorySuccessState(
                DateTime.now(),
                exportHistoryView,
                event.itemSort,
                event.listAllItem,
                event.warehouse,
                event.poNumber,
                event.receiverList))
            : emit(AccessExportHistoryFailState(
                DateTime.now(),
                ErrorPackage('Lịch sử đang rỗng'),
                event.warehouse,
                event.itemSort,
                event.listAllItem,
                event.poNumber,
                event.receiverList));
      } catch (e) {
        emit(AccessExportHistoryFailState(
            DateTime.now(),
            ErrorPackage('Lỗi hệ thống'),
            event.warehouse,
            event.itemSort,
            event.listAllItem,
            event.poNumber,
            event.receiverList));
      }
    });
  }
}
