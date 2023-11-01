// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class WarningState extends Equatable {
  List<Warehouse> warehouse;
  WarningState(this.warehouse);
}


// hiển thị danh sách sản phẩm theo hạn sử dụng còn lại
class ExpirationWarningSuccessState extends WarningState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  ExpirationWarningSuccessState(this.timestamp, this.itemLot) : super([]);
  @override
  List<Object> get props => [timestamp];
}

class ExpirationWarningLoadingState extends WarningState {
  DateTime timestamp;
  ExpirationWarningLoadingState(this.timestamp) : super([]);
  @override
  List<Object> get props => [timestamp];
}

class ExpirationWarningFailState extends WarningState {
  DateTime timestamp;
  String detail;
  ExpirationWarningFailState(
    this.timestamp,
    this.detail,
  ) : super([]);
  @override
  List<Object?> get props => [timestamp];
}

// hiển thị list kho hàng
class GetWarehouseSuccessState extends WarningState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  GetWarehouseSuccessState(this.timestamp, this.warehouse) : super(warehouse);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseLoadingState extends WarningState {
  DateTime timestamp;
  GetWarehouseLoadingState(this.timestamp) : super([]);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseFailState extends WarningState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  GetWarehouseFailState(this.timestamp, this.warehouse) : super(warehouse);
  @override
  List<Object?> get props => [timestamp];
}
// hiển thị danh sách sản phẩm dưới số lượng tồn kho tối thiểu

class MinimumStockWarningSuccessState extends WarningState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  List<Warehouse> warehouse;
  String warehouseId;
  List<Warehouse> listWarehouse;
  MinimumStockWarningSuccessState(this.timestamp, this.itemLot,
      this.warehouseId, this.warehouse, this.listWarehouse)
      : super(warehouse);
  @override
  List<Object?> get props => [timestamp];
}

class MinimumStockWarningLoadingState extends WarningState {
  DateTime timestamp;

  MinimumStockWarningLoadingState(this.timestamp) : super([]);
  @override
  List<Object> get props => [timestamp];
}

class MinimumStockWarningFailState extends WarningState {
  DateTime timestamp;
  String detail;
  List<Warehouse> warehouse;
  MinimumStockWarningFailState(this.timestamp, this.detail, this.warehouse) : super(warehouse);
  @override
  List<Object> get props => [timestamp];
}
