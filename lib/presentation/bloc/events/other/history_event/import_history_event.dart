// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../domain/entities/item.dart';

abstract class ImportHistoryEvent extends Equatable {
  // List<String> poNumberList;
  // List<String> supplierList;
  // List<String> warehouseIdList;
  // List<Item> itemList;
  // List<ImportHistoryEntry> importHistoryEntries;
}

class GetAllInfoImportEvent extends ImportHistoryEvent {
  DateTime timestamp;
  GetAllInfoImportEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// lọc danh sách item nhập kho theo kho hàng
class GetImportItemByWarehouseEvent extends ImportHistoryEvent {
  DateTime timestamp;
  String warehouseId;
  List<String> poNumber;
  List<Item> listAllItem;
  List<Warehouse> warehouse;
  List<String> supplier;
  GetImportItemByWarehouseEvent(
    this.timestamp,
    this.poNumber,
    this.warehouseId,
    this.listAllItem,
    this.warehouse,
    this.supplier
  );
  @override
  List<Object> get props => [timestamp];
}

// truy xuất lịch sử nhập kho
class AccessImportHistoryByPOEvent extends ImportHistoryEvent {
  DateTime timestamp;
  String purchaseOrderNumber;
    List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplier;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessImportHistoryByPOEvent(
    this.timestamp,
    this.purchaseOrderNumber,
    this.warehouse, this.itemSort, this.listAllItem, this.poNumber, this.supplier
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryBySupplierEvent extends ImportHistoryEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  String supplier;

    List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplierList;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessImportHistoryBySupplierEvent(
      this.timestamp, this.startDate, this.endDate, this.supplier,
      this.warehouse, this.itemSort, this.listAllItem, this.poNumber, this.supplierList);
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryByItemIdEvent extends ImportHistoryEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  String itemId;
  String warehouseId;

   List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplierList;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessImportHistoryByItemIdEvent(this.timestamp, this.startDate, this.endDate,
      this.itemId, this.warehouseId,
       this.warehouse, this.itemSort, this.listAllItem, this.poNumber, this.supplierList);
  @override
  List<Object> get props => [timestamp];
}
