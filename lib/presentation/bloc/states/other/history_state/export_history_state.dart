// ignore_for_file: must_be_immutable, annotate_overrides, overridden_fields

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/export_history_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class ExportHistoryState extends Equatable {
  List<Warehouse> warehouse;

  List<String> receiver;
  List<Item> listAllItem;
  List<Item> itemSort;
  ExportHistoryState(this.warehouse, this.itemSort, this.listAllItem,
     this.receiver);
}

// lấy ds kho, bo phan, item
class GetAllInfoExportSuccessState extends ExportHistoryState {
  DateTime timestamp;
  List<Item> item;

  List<String> receiver;
  List<Warehouse> warehouseId;
  GetAllInfoExportSuccessState(this.timestamp, this.item,
      this.receiver, this.warehouseId) : super(warehouseId, item, item, receiver);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoExportLoadingState extends ExportHistoryState {
  DateTime timestamp;

  GetAllInfoExportLoadingState(this.timestamp) :  super([], [], [], [],);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoExportFailState extends ExportHistoryState {
  DateTime timestamp;
  ErrorPackage status;

  
  GetAllInfoExportFailState(this.timestamp, this.status) :  super([], [], [], [],);
  @override
  List<Object> get props => [timestamp];
}

// lọc danh sách item xuat kho theo kho hàng
class GetExportItemByWarehouseSuccessState extends ExportHistoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<String> receiver;
  List<Item> listAllItem;

  List<Item> item;
  GetExportItemByWarehouseSuccessState(this.timestamp, this.listAllItem,
      this.item, this.warehouse, this.receiver) : super(warehouse, item, listAllItem, receiver);
  @override
  List<Object> get props => [timestamp];
}

class GetExportItemByWarehouseLoadingState extends ExportHistoryState {
  DateTime timestamp;
  GetExportItemByWarehouseLoadingState(this.timestamp) :  super([], [], [], [],);
  @override
  List<Object> get props => [timestamp];
}

class GetExportItemByWarehouseFailState extends ExportHistoryState {
  DateTime timestamp;
  ErrorPackage status;

  
  GetExportItemByWarehouseFailState(this.timestamp, this.status) :  super([], [], [], [],);
  @override
  List<Object> get props => [timestamp];
}

// lich su xuat kho
class AccessExportHistorySuccessState extends ExportHistoryState {
  DateTime timestamp;
  List<ExportHistoryView> exportHistoryEntries;

   List<Warehouse> warehouse;

  List<String> receiver;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessExportHistorySuccessState(
    this.timestamp,
    this.exportHistoryEntries,this.itemSort, this.listAllItem, this.warehouse, this.receiver
  ) :  super(warehouse, itemSort, listAllItem, receiver);
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryLoadingState extends ExportHistoryState {
  DateTime timestamp;
  AccessExportHistoryLoadingState(
    this.timestamp,
  ) :  super([], [], [], [], );
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryFailState extends ExportHistoryState {
  DateTime timestamp;
  ErrorPackage status;

   List<Warehouse> warehouse;

  List<String> receiver;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessExportHistoryFailState(
    this.timestamp,
    this.status,this.warehouse, this.itemSort, this.listAllItem,
     this.receiver
  ) :  super(warehouse, listAllItem, listAllItem,  receiver);
  @override
  List<Object> get props => [timestamp];
}
