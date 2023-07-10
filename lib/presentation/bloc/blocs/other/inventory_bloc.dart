import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/inventory_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/inventory_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/inventory_states.dart';

import '../../../../domain/entities/item.dart';
import '../../../../domain/usecases/location_usecase.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  ItemUsecase itemUsecase;
  Inventoryusecase inventoryUsecase;
  ItemLotUsecase itemLotUsecase;
  LocationUsecase locationUsecase;
  InventoryBloc(this.inventoryUsecase, this.locationUsecase,
      this.itemLotUsecase, this.itemUsecase)
      : super(GetWarehouseIdLoadingState(DateTime.now())) {
    // hiển thị list kho hàng
    on<GetWarehouseIdEvent>((event, emit) async {
      emit(GetWarehouseIdLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
        emit(GetWarehouseIdSuccessState(DateTime.now(), warehouse, item));
      } catch (e) {
        emit(GetWarehouseIdFailState(DateTime.now()));
      }
    });
    //list mã sản phẩm theo kho hàng
    on<GetAllItemIdByWarehouseEvent>((event, emit) async {
      emit(GetAllItemByWarehouseLoadingState(DateTime.now()));
      try {
        List<Item> item = event.listAllItem
            .expand((e) => [if (e.itemClass == event.warehouseId) e])
            .toList();
        emit(GetAllItemByWarehouseSuccessState(
            DateTime.now(), item, event.listAllItem, event.warehouse));
      } catch (e) {
        emit(GetAllItemByWarehouseFailState(
          DateTime.now(),event.listAllItem, event.warehouse
        ));
      }
    });

    // lịch sử xuất nhập tồn 
    //   on<LoadInventoryEvent>((event, emit) async {
    //   emit(LoadInventoryLoadingState(DateTime.now()));
    //   try {
    //     {
    //       final itemLots = await inventoryUsecase.getInventoryByItemId(
    //           event.startDate, event.endDate, event.itemId);
    //       emit(LoadInventorySuccessState(DateTime.now(), itemLots, event.listAllItem, event.warehouse));
    //     }
    //   } catch (e) {
    //     emit(LoadInventoryFailState(DateTime.now(), event.listAllItem, event.warehouse));
    //   }
    // });
     on<LoadInventoryEvent>((event, emit) async {
      emit(LoadInventoryLoadingState(DateTime.now()));
      try {
        {
          final itemLots = await inventoryUsecase.getInventoryByItemId(
              event.startDate, event.endDate, event.itemId);
          emit(LoadInventorySuccessState(DateTime.now(), itemLots, event.listAllItem, event.warehouse));
        }
      } catch (e) {
        emit(LoadInventoryFailState(DateTime.now(), event.listAllItem, event.warehouse));
      }
    });
// báo cáo tồn kho
    on<GetReportInventory>((event, emit) async {
      double totalQuantity = 0;
      emit(LoadReportInventoryLotLoadingState(DateTime.now()));
      try {
        {
          final itemLots =
              await itemLotUsecase.getItemLotsByItemId(event.itemId);
          for (var element in itemLots) {
            totalQuantity =
                totalQuantity + double.parse(element.quantity.toString());
          }
          itemLots.isNotEmpty
              ? {
                  emit(LoadReportInventoryLotSuccessState(
                      DateTime.now(), itemLots, totalQuantity))
                }
              : { emit(LoadReportInventoryLotFailState(DateTime.now()))};
        }
      } catch (e) {
        emit(LoadReportInventoryLotFailState(DateTime.now()));
      }
    });
  }
}
