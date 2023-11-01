// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../domain/entities/item.dart';
import '../../../../domain/entities/location.dart';

abstract class InventoryEvent extends Equatable {}

// list kho hang
class GetWarehouseIdEvent extends InventoryEvent {
  DateTime timestamp;
  GetWarehouseIdEvent(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// lấy mã sp
class GetAllItemIdByWarehouseEvent extends InventoryEvent {
  DateTime timestamp;
  String warehouseId;
  // biến lưu state để hiển thị trong cùng một trang
  List<Item> listAllItem;
  List<Item> lisstItemByWarehouse;
  List<Warehouse> warehouse;
  GetAllItemIdByWarehouseEvent(this.timestamp, this.warehouseId,
      this.listAllItem, this.lisstItemByWarehouse, this.warehouse);
  @override
  List<Object?> get props => [timestamp];
}

// Hiển thị hàng tồn kho theo thông tin tìm kiếm
class LoadInventoryEvent extends InventoryEvent {
  DateTime timestamp;
  String itemId;
  DateTime startDate;
  DateTime endDate;
  List<Item> listAllItem;
  List<Warehouse> warehouse;
  LoadInventoryEvent(
    this.timestamp,
    this.itemId,
    this.startDate,
    this.endDate,
    this.listAllItem, this.warehouse
  );
  @override
  List<Object> get props => [timestamp];
}

class GetReportInventory extends InventoryEvent {
  String itemId;
  GetReportInventory(this.itemId);
  @override

  List<Object?> get props => [itemId];
}
