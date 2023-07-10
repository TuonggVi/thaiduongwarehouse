// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../domain/entities/other/import_history_entry.dart';

abstract class ImportHistoryState extends Equatable {
  List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplier;
  List<Item> listAllItem;
  List<Item> itemSort;
  ImportHistoryState(this.warehouse, this.itemSort, this.listAllItem,
      this.poNumber, this.supplier);
}

// lấy ds kho, ncc, item
class GetAllInfoImportSuccessState extends ImportHistoryState {
  DateTime timestamp;
  List<Item> listAllItem;
  List<String> poNumber;
  List<Warehouse> warehouse; // lưu warehouse
  List<String> supplier;
  GetAllInfoImportSuccessState(this.timestamp, this.poNumber, this.warehouse,
      this.listAllItem, this.supplier)
      : super(warehouse, listAllItem, listAllItem, poNumber, supplier);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoImportLoadingState extends ImportHistoryState {
  DateTime timestamp;
  GetAllInfoImportLoadingState(this.timestamp) : super([], [], [], [], []);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoImportFailState extends ImportHistoryState {
  DateTime timestamp;
  ErrorPackage status;
 
  GetAllInfoImportFailState(this.timestamp, this.status)
      : super([], [], [], [], []);
  @override
  List<Object> get props => [timestamp];
}

// lọc danh sách item nhap kho theo kho hàng
class GetImportItemByWarehouseSuccessState extends ImportHistoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplier;
  List<Item> listAllItem;
  List<Item> itemSort;
  GetImportItemByWarehouseSuccessState(this.timestamp, this.poNumber,
      this.listAllItem, this.itemSort, this.warehouse, this.supplier)
      : super(warehouse, itemSort, listAllItem, poNumber, supplier);
  @override
  List<Object> get props => [timestamp];
}

class GetImportItemByWarehouseLoadingState extends ImportHistoryState {
  DateTime timestamp;
  GetImportItemByWarehouseLoadingState(this.timestamp)
      : super([], [], [], [], []);
  @override
  List<Object> get props => [timestamp];
}

class GetImportItemByWarehouseFailState extends ImportHistoryState {
  DateTime timestamp;
  ErrorPackage status;
 
  GetImportItemByWarehouseFailState(this.timestamp, this.status)
      : super([], [], [], [], []);
  @override
  List<Object> get props => [timestamp];
}

// lich su nhap kho
class AccessImportHistorySuccessState extends ImportHistoryState {
  DateTime timestamp;
  List<ImportHistoryView> importHistoryEntries;
  List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplier;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessImportHistorySuccessState(
      this.timestamp,
      this.importHistoryEntries,
      this.warehouse,
      this.itemSort,
      this.listAllItem,
      this.poNumber,
      this.supplier)
      : super(warehouse, itemSort, listAllItem, poNumber, supplier);
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryLoadingState extends ImportHistoryState {
  DateTime timestamp;
  AccessImportHistoryLoadingState(
    this.timestamp,
  ) : super([], [], [], [], []);
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryFailState extends ImportHistoryState {
  DateTime timestamp;
  ErrorPackage status;
  List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> supplier;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessImportHistoryFailState(
    this.timestamp,
    this.status,this.warehouse, this.itemSort, this.listAllItem,
      this.poNumber, this.supplier
  ) : super(warehouse, listAllItem, listAllItem, poNumber, supplier);
  @override
  List<Object> get props => [timestamp];
}
