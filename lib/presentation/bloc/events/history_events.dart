// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';

import '../../../domain/entities/item.dart';
import '../../../domain/entities/location.dart';

abstract class HistoryEvent extends Equatable {}

//------------
// get po number => chọn kho thành phẩm thì dc chọn số po
// bắt buộc phải chọn kho hàng, từ ngày - đến ngày => có thể truy xuất
// mã sp, bộ phận có thể có hoặc không
// số po chỉ với kho thành phẩm
//---------
// lấy ds kho, bộ phận, item => ls xuất
class GetAllInfoImportEvent extends HistoryEvent {
  DateTime timestamp;
  GetAllInfoImportEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// lấy ds kho, ncc, item => ls nhập
class GetAllInfoExportEvent extends HistoryEvent {
  DateTime timestamp;
  GetAllInfoExportEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// lọc danh sách item theo kho hàng
class GetItemByWarehouseEvent extends HistoryEvent {
  DateTime timestamp;
  String warehouseId;
  List<Department> department;
  List<Item> listAllItem;
  List<Item> lisstItemByWarehouse;
  List<Warehouse> warehouse;
  GetItemByWarehouseEvent(
    this.timestamp, 
    this.warehouseId,

  this.listAllItem, 
  this.lisstItemByWarehouse,
  this.warehouse,
  this.department
      );
  @override
  List<Object> get props => [timestamp];
}

// // Truy xuất lịch sử nhập kho
// class AccessImportHistoryEvent extends HistoryEvent {
//   DateTime timestamp;
//   List<Warehouse> warehouse;
//   List<Department> department;
//   List<Item> item;

//   String itemClass;
//   DateTime startDate;
//   DateTime endDate;
//   String itemId;
//   String departmentId;
//   String receiver;
//   String purchaseOrderNumber;
//   AccessImportHistoryEvent(
//       this.timestamp,
//       this.department,
//       this.item,
//       this.warehouse,
//       this.itemClass,
//       this.startDate,
//       this.endDate,
//       this.itemId,
//       this.departmentId,
//       this.receiver,
//       this.purchaseOrderNumber);
//   @override
//   List<Object> get props => [timestamp];
// }
// truy xuất lịch sử nhập kho
class AccessImportHistoryByPOEvent extends HistoryEvent {
  DateTime timestamp;
  String purchaseOrderNumber;
  AccessImportHistoryByPOEvent(
    this.timestamp,
    this.purchaseOrderNumber,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryBySupplierEvent extends HistoryEvent {
  DateTime timestamp;
  AccessImportHistoryBySupplierEvent(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryByItemIdEvent extends HistoryEvent {
  DateTime timestamp;
  String itemId;
  AccessImportHistoryByItemIdEvent(this.timestamp, this.itemId);
  @override
  List<Object> get props => [timestamp];
}

// Truy xuất lịch sử xuất kho
class AccessExportHistoryEvent extends HistoryEvent {
  DateTime timestamp;
  String warehouse;
  DateTime startDate;
  DateTime endDate;
  String itemId;
  String department;

  //String purchaseOrderNumber;
  AccessExportHistoryEvent(
    this.timestamp,
    this.warehouse,
    this.startDate,
    this.endDate,
    this.itemId,
    this.department,

    //this.purchaseOrderNumber
  );
  @override
  List<Object> get props => [timestamp];
}
// truy xuất lịch sử xuất kho
class AccessExportHistoryByPOEvent extends HistoryEvent {
  DateTime timestamp;
  String purchaseOrderNumber;
  AccessExportHistoryByPOEvent(
    this.timestamp,
    this.purchaseOrderNumber,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryByReceiverEvent extends HistoryEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  String department;
  AccessExportHistoryByReceiverEvent(
    this.timestamp,
    this.startDate,
    this.endDate,
    this.department,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryByItemIdEvent extends HistoryEvent {
  DateTime timestamp;
    DateTime startDate;
  DateTime endDate;
  String itemId;
  AccessExportHistoryByItemIdEvent(this.timestamp,    this.startDate,
    this.endDate, this.itemId);
  @override
  List<Object> get props => [timestamp];
}

// test giao diện
class TestHistoryEvent extends HistoryEvent {
  DateTime timestamp;
  String warehouse;
  //String purchaseOrderNumber;
  TestHistoryEvent(
    this.timestamp,
    this.warehouse,
    //this.purchaseOrderNumber
  );
  @override
  List<Object> get props => [timestamp];
}
