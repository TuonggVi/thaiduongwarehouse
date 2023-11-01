// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../domain/entities/item.dart';

abstract class ExportHistoryEvent extends Equatable {
  // List<String> poNumberList;
  // List<String> supplierList;
  // List<String> warehouseIdList;
  // List<Item> itemList;
  // List<ImportHistoryEntry> importHistoryEntries;
}


class GetAllInfoExportEvent extends ExportHistoryEvent {
  DateTime timestamp;
  GetAllInfoExportEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}


class GetExportItemByWarehouseEvent extends ExportHistoryEvent {
  DateTime timestamp;
  String warehouseId;
  // List<Department> department;
  List<String> receiver;

  List<Item> listAllItem;
  List<Item> lisstItemByWarehouse;
  List<Warehouse> warehouse;
  GetExportItemByWarehouseEvent(
      this.timestamp,
      this.warehouseId,
      this.listAllItem,
      this.lisstItemByWarehouse,
      this.warehouse,
      //  this.department,
      this.receiver);
  @override
  List<Object> get props => [timestamp];
}


class AccessExportHistoryByPOEvent extends ExportHistoryEvent {
  DateTime timestamp;

  List<Warehouse> warehouse;
  List<String> poNumber;
  List<String> receiverList;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessExportHistoryByPOEvent(this.timestamp, this.warehouse, this.itemSort,
      this.listAllItem, this.poNumber, this.receiverList);
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryByReceiverEvent extends ExportHistoryEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  String receiver;
  List<Warehouse> warehouse;

  List<String> receiverList;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessExportHistoryByReceiverEvent(
      this.timestamp,
      this.startDate,
      this.endDate,
      this.receiver,
      this.warehouse,
      this.itemSort,
      this.listAllItem,
      this.receiverList);
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryByItemIdEvent extends ExportHistoryEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  String itemId;
  String warehouseId;

  List<Warehouse> warehouse;

  List<String> receiverList;
  List<Item> listAllItem;
  List<Item> itemSort;
  AccessExportHistoryByItemIdEvent(
      this.timestamp,
      this.startDate,
      this.endDate,
      this.itemId,
      this.warehouseId,
      this.warehouse,
      this.itemSort,
      this.listAllItem,
      this.receiverList);
  @override
  List<Object> get props => [timestamp];
}
