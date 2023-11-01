// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class InventoryState extends Equatable {
  List<Warehouse> warehouse;
  List<Item> item;
  List<Item> listSortItem;
  InventoryState(this.item, this.warehouse, this.listSortItem);
}

// List kho hàng
class GetWarehouseIdSuccessState extends InventoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Item> item;
  GetWarehouseIdSuccessState(this.timestamp, this.warehouse, this.item)
      : super(item, warehouse, item);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseIdLoadingState extends InventoryState {
  DateTime timestamp;
  GetWarehouseIdLoadingState(this.timestamp) : super([], [],[]);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseIdFailState extends InventoryState {
  DateTime timestamp;
  GetWarehouseIdFailState(this.timestamp) : super([], [],[]);
  @override
  List<Object?> get props => [timestamp];
}

// Lọc sp theo kho hàng
class GetAllItemByWarehouseSuccessState extends InventoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Item> listAllItem;
  List<Item> item;
  GetAllItemByWarehouseSuccessState(
      this.timestamp, this.item, this.listAllItem, this.warehouse)
      : super(listAllItem, warehouse, item);
  @override
  List<Object?> get props => [timestamp];
}

class GetAllItemByWarehouseLoadingState extends InventoryState {
  DateTime timestamp;
  GetAllItemByWarehouseLoadingState(this.timestamp) : super([], [], []);
  @override
  List<Object?> get props => [timestamp];
}

class GetAllItemByWarehouseFailState extends InventoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Item> item;
  GetAllItemByWarehouseFailState(this.timestamp, this.item, this.warehouse)
      : super(item, warehouse,[]);
  @override
  List<Object?> get props => [timestamp];
}

// Truy xuất theo thông tin tìm kiếm
class LoadInventorySuccessState extends InventoryState {
  DateTime timestamp;
  List<InventoryLogEntry> itemLots;
  List<Warehouse> warehouse;
  List<Item> item;
  LoadInventorySuccessState(
      this.timestamp, this.itemLots, this.item, this.warehouse)
      : super(item, warehouse,item);
  @override
  List<Object?> get props => [timestamp];
}

class LoadInventoryFailState extends InventoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Item> item;
  LoadInventoryFailState(this.timestamp, this.item, this.warehouse)
      : super(item, warehouse, item);
  @override
  List<Object?> get props => [timestamp];
}

class LoadInventoryLoadingState extends InventoryState {
  DateTime timestamp;
  // ErrorPackage status;
  LoadInventoryLoadingState(
    this.timestamp,
    // this.status
  ) : super([], [],[]);
  @override
  List<Object?> get props => [
        timestamp,
        // status
      ];
}

class LoadReportInventoryLotSuccessState extends InventoryState {
  DateTime timestamp;
  List<ItemLot> itemLots;
  double totalQuantity;
  //  List<ItemClass> listItemClass;
  LoadReportInventoryLotSuccessState(
      this.timestamp, this.itemLots, this.totalQuantity)
      : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

class LoadReportInventoryLotFailState extends InventoryState {
  DateTime timestamp;

  LoadReportInventoryLotFailState(
    this.timestamp,
  ) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

class LoadReportInventoryLotLoadingState extends InventoryState {
  DateTime timestamp;
  LoadReportInventoryLotLoadingState(
    this.timestamp,
  ) : super([], [],[]);
  @override
  List<Object?> get props => [
        timestamp,
      ];
}
