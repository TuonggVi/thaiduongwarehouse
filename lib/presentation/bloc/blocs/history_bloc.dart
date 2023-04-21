import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/department_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/history_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/history_states.dart';

import '../../../domain/entities/item.dart';
import '../../../domain/usecases/goods_receipt_usecase.dart';
import '../../../domain/usecases/location_usecase.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  ItemUsecase itemUsecase;
  DepartmentUsecase departmentUsecase;
  LocationUsecase locationUsecase;
  GoodsIssueUseCase goodsIssueUseCase;
  GoodsReceiptUsecase goodsReceiptUseCase;
  HistoryBloc(this.goodsIssueUseCase, this.departmentUsecase,
      this.locationUsecase, this.goodsReceiptUseCase, this.itemUsecase)
      : super(GetAllInfoExportLoadingState(DateTime.now())) {
    // hiển thị list kho hàng, itemId, bộ phận
    on<GetAllInfoExportEvent>((event, emit) async {
      emit(GetAllInfoExportLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouse();
        final department = await departmentUsecase.getAllDepartment();

        emit(GetAllInfoExportSuccessState(
            DateTime.now(), item, warehouse, department));
      } catch (e) {
        emit(GetAllInfoExportFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    // truy xuất lịch sử xuất kho
    on<AccessExportHistoryByPOEvent>((event, emit) async {
      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots = await goodsIssueUseCase
            .getGoodsIssueHistoryByPO(event.purchaseOrderNumber);
        emit(AccessExportHistorySuccessState(DateTime.now(), goodIssueLots));
      } catch (e) {
        emit(AccessExportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    on<AccessExportHistoryByReceiverEvent>((event, emit) async {
      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots =
            await goodsIssueUseCase.getGoodsIssueHistoryByReceiver(
          event.startDate,
          event.endDate,
        );
        emit(AccessExportHistorySuccessState(DateTime.now(), goodIssueLots));
      } catch (e) {
        emit(AccessImportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    on<AccessExportHistoryByItemIdEvent>((event, emit) async {
      emit(AccessExportHistoryLoadingState(DateTime.now()));
      try {
        final goodIssueLots =
            await goodsIssueUseCase.getGoodsIssueHistoryByItemId(
          event.startDate,
          event.endDate,
          event.itemId,
        );
        emit(AccessExportHistorySuccessState(DateTime.now(), goodIssueLots));
      } catch (e) {
        emit(AccessExportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });

    //-------------------
    on<GetAllInfoImportEvent>((event, emit) async {
      emit(GetAllInfoImportLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouse();
        final department = await departmentUsecase.getAllDepartment();
        emit(GetAllInfoImportSuccessState(
            DateTime.now(), warehouse, item, department));
      } catch (e) {
        emit(GetAllInfoImportFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    //list sản phẩm theo kho hàng
    on<GetItemByWarehouseEvent>((event, emit) async {
      emit(GetItemByWarehouseLoadingState(DateTime.now()));
      try {
        List<Item> item = event.listAllItem
            .expand((e) => [if (e.itemClassId == event.warehouseId) e])
            .toList();
        emit(GetItemByWarehouseSuccessState(
            DateTime.now(),
            event.lisstItemByWarehouse,
            item,
            event.warehouse,
            event.department));
      } catch (e) {
        emit(GetItemByWarehouseFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    // truy xuất lịch sử nhập kho
    on<AccessImportHistoryByPOEvent>((event, emit) async {
      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots = await goodsReceiptUseCase
            .getGoodsReceiptsHistoryByPO(event.purchaseOrderNumber);
        emit(AccessImportHistorySuccessState(DateTime.now(), goodReceiptLots));
      } catch (e) {
        emit(AccessImportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    on<AccessImportHistoryBySupplierEvent>((event, emit) async {
      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots = await goodsReceiptUseCase
            .getGoodsReceiptsHistoryBySupplier(event.startDate, event.endDate);

        emit(AccessImportHistorySuccessState(DateTime.now(), goodReceiptLots));
      } catch (e) {
        emit(AccessImportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });
    on<AccessImportHistoryByItemIdEvent>((event, emit) async {
      emit(AccessImportHistoryLoadingState(DateTime.now()));
      try {
        final goodReceiptLots =
            await goodsReceiptUseCase.getGoodsReceiptsHistoryByItemId(
          event.startDate,
          event.endDate,
          event.itemId,
        );
        emit(AccessImportHistorySuccessState(DateTime.now(), goodReceiptLots));
      } catch (e) {
        emit(AccessImportHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });

    // on<AccessImportHistoryEvent>((event, emit) async {
    //   emit(AccessImportHistoryLoadingState(DateTime.now()));
    //   try {
    //     {
    //       final goodIssueLots =
    //           await goodsReceiptUseCase.getGoodsReceiptsHistory(
    //               event.itemClass,
    //               event.startDate,
    //               event.endDate,
    //               event.itemId,
    //               event.departmentId,
    //               event.receiver,
    //               event.purchaseOrderNumber);
    //       emit(AccessImportHistorySuccessState(DateTime.now(), event.department,event.warehouse, event.item, goodIssueLots ));
    //     }
    //   } catch (e) {
    //     emit(AccessImportHistoryFailState(DateTime.now(), ErrorPackage('')));
    //   }
    // });
    // test giao diện
    on<TestHistoryEvent>((event, emit) async {
      emit(TestHistoryLoadingState(DateTime.now()));
      try {
        {
          final goodReceiptLots =
              await goodsReceiptUseCase.getGoodsReceiptsHistoryTest(
            event.warehouse,
          );
          emit(TestHistorySuccessState(DateTime.now(), goodReceiptLots));
        }
      } catch (e) {
        emit(TestHistoryFailState(DateTime.now(), ErrorPackage('')));
      }
    });
  }
}
