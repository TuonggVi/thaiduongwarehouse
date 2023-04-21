import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/inventory_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/inventory_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/inventory_states.dart';

import '../../../domain/entities/item.dart';
import '../../../domain/usecases/location_usecase.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  ItemUsecase itemUsecase;
  InventoryUsecase inventoryUsecase;
  LocationUsecase locationUsecase;
  InventoryBloc(this.inventoryUsecase, this.locationUsecase, this.itemUsecase)
      : super(GetWarehouseIdLoadingState(DateTime.now())) {
    // hiển thị list kho hàng
    on<GetWarehouseIdEvent>((event, emit) async {
      emit(GetWarehouseIdLoadingState(DateTime.now()));
      try {
        final item = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouse();
        emit(GetWarehouseIdSuccessState(DateTime.now(), warehouse, item));
      } catch (e) {
        emit(GetWarehouseIdFailState(DateTime.now()));
      }
    });
    //list mã sản phẩm theo kho hàng
    on<GetAllItemIdByWarehouseEvent>((event, emit) async {
      emit(GetAllItemByWarehouseLoadingState(DateTime.now()));
      try {
        List<Item> item = event.item
            .expand((e) => [if (e.itemClassId == event.warehouseId) e])
            .toList();
        emit(GetAllItemByWarehouseSuccessState(
            DateTime.now(), item, event.warehouse));
      } catch (e) {
        emit(GetAllItemByWarehouseFailState(
          DateTime.now(),
        ));
      }
    });

    // lọc kho hàng theo thông tin tìm kiếm
    on<LoadInventoryEvent>((event, emit) async {
      emit(LoadInventoryLoadingState(DateTime.now()));
      try {
        {
          final itemLots = await inventoryUsecase.getInventoryByItemId(
              event.startDate, event.endDate, event.itemId);
          emit(LoadInventorySuccessState(DateTime.now(), itemLots));
        }
      } catch (e) {
        emit(LoadInventoryFailState(DateTime.now()));
      }
    });

    // thử giao diện
    on<LoadInventoryLotEvent>((event, emit) async {
      emit(LoadInventoryLotLoadingState(DateTime.now()));
      try {
        {
          final itemLots = await inventoryUsecase.getInventoryLotByItemClassId(
              event.timestamp, event.warehouseName);

          emit(LoadInventoryLotSuccessState(DateTime.now(), itemLots));
        }
      } catch (e) {
        emit(LoadInventoryLotFailState(DateTime.now()));
      }
    });
  }
}
