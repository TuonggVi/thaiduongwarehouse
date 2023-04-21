// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class InventoryState extends Equatable {}
// List kho hàng
class GetWarehouseIdSuccessState extends InventoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Item> item; 
  GetWarehouseIdSuccessState(this.timestamp, this.warehouse, this.item);
  @override

  List<Object?> get props => [timestamp];
}
class GetWarehouseIdLoadingState extends InventoryState {
  DateTime timestamp;
  GetWarehouseIdLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
class GetWarehouseIdFailState extends InventoryState {
  DateTime timestamp;
  GetWarehouseIdFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
// Lọc sp theo kho hàng
class GetAllItemByWarehouseSuccessState extends InventoryState {
  DateTime timestamp;
  List<Item> item;
  List<Warehouse> warehouse;
  GetAllItemByWarehouseSuccessState(this.timestamp, this.item, this.warehouse);
  @override

  List<Object?> get props => [timestamp];
}
class GetAllItemByWarehouseLoadingState extends InventoryState {
  DateTime timestamp;
  GetAllItemByWarehouseLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
class GetAllItemByWarehouseFailState extends InventoryState {
  DateTime timestamp;
  GetAllItemByWarehouseFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
// Truy xuất theo thông tin tìm kiếm
class LoadInventorySuccessState extends InventoryState {
  DateTime timestamp;
  List<InventoryLogEntry> itemLots;
  LoadInventorySuccessState(this.timestamp, this.itemLots);
  @override

  List<Object?> get props => [timestamp];
}

class LoadInventoryFailState extends InventoryState {
  DateTime timestamp;
  LoadInventoryFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class LoadInventoryLoadingState extends InventoryState {
  DateTime timestamp;
  // ErrorPackage status;
  LoadInventoryLoadingState(this.timestamp, 
  // this.status
  );
  @override

  List<Object?> get props => [timestamp, 
  // status
  ];
}
// thử giao diện
class LoadInventoryLotSuccessState extends InventoryState {
  DateTime timestamp;
  List<InventoryLogEntry> itemLots;
 //  List<ItemClass> listItemClass;
  LoadInventoryLotSuccessState(
    this.timestamp,
    this.itemLots,
    
  );
  @override
  List<Object> get props => [timestamp];
}
class LoadInventoryLotFailState extends InventoryState {
  DateTime timestamp;

  LoadInventoryLotFailState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}
class LoadInventoryLotLoadingState extends InventoryState {
  DateTime timestamp;
  LoadInventoryLotLoadingState(this.timestamp, 
  );
  @override
  List<Object?> get props => [timestamp, 
  ];
}