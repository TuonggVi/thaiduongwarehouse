// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';



abstract class WarningState extends Equatable {}

// hiển thị danh sách sản phẩm theo hạn sử dụng còn lại
class ExpirationWarningSuccessState extends WarningState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  ExpirationWarningSuccessState(this.timestamp, this.itemLot);
  @override
  List<Object> get props => [timestamp];
}

class ExpirationWarningLoadingState extends WarningState {
  DateTime timestamp;
  ExpirationWarningLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ExpirationWarningFailState extends WarningState {
  DateTime timestamp;
  String detail;
  ExpirationWarningFailState(
    this.timestamp,
    this.detail,
  );
  @override

  List<Object?> get props => [timestamp];
}

// hiển thị list kho hàng
class GetWarehouseSuccessState extends WarningState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  GetWarehouseSuccessState(this.timestamp, this.warehouse);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseLoadingState extends WarningState {
  DateTime timestamp;
  GetWarehouseLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class GetWarehouseFailState extends WarningState {
  DateTime timestamp;
  GetWarehouseFailState(this.timestamp);
  @override
  List<Object?> get props =>[timestamp];
}
// hiển thị danh sách sản phẩm dưới số lượng tồn kho tối thiểu

class MinimumStockWarningSuccessState extends WarningState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  List<Warehouse> warehouse;
  String warehouseId;
  List<Warehouse> listWarehouse;
  MinimumStockWarningSuccessState(this.timestamp, this.itemLot,this.warehouseId,
  this.warehouse,
  this.listWarehouse
   );
  @override
  List<Object?> get props => [timestamp];
}

class MinimumStockWarningLoadingState extends WarningState {
  DateTime timestamp;

  MinimumStockWarningLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class MinimumStockWarningFailState extends WarningState {
  DateTime timestamp;
  String detail;
  MinimumStockWarningFailState(this.timestamp, this.detail);
  @override

  List<Object> get props => [timestamp];
}
