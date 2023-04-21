// ignore_for_file: must_be_immutable, unused_import

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/location_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

import '../../../domain/entities/goods_issue.dart';
import '../../../domain/entities/location.dart';

abstract class HistoryState extends Equatable {}

// lấy ds kho, bộ phận, item
class GetAllInfoImportSuccessState extends HistoryState {
  DateTime timestamp;
  List<Item> item;
  List<Warehouse> warehouse;
  List<Department> department;
  GetAllInfoImportSuccessState(this.timestamp, this. warehouse,this.item, this.department);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoImportLoadingState extends HistoryState {
  DateTime timestamp;
  GetAllInfoImportLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoImportFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  GetAllInfoImportFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}

// lấy ds kho, ncc, item
class GetAllInfoExportSuccessState extends HistoryState {
  DateTime timestamp;
  List<Item> item;
  List<Warehouse> warehouse;
  List<Department> department;
  GetAllInfoExportSuccessState(this.timestamp, this.item,this.warehouse, this.department);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoExportLoadingState extends HistoryState {
  DateTime timestamp;

  GetAllInfoExportLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllInfoExportFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  GetAllInfoExportFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}

// lọc danh sách item theo kho hàng
class GetItemByWarehouseSuccessState extends HistoryState {
  DateTime timestamp;
  List<Warehouse> warehouse;
  List<Department> department;
  List<Item> listAllItem;
  List<Item> item;
  GetItemByWarehouseSuccessState(this.timestamp,
  this.listAllItem, 
  this.item,
  this.warehouse, this.department
  );
  @override
  List<Object> get props => [timestamp];
}

class GetItemByWarehouseLoadingState extends HistoryState {
  DateTime timestamp;
  GetItemByWarehouseLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetItemByWarehouseFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  GetItemByWarehouseFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}

// // Truy xuất lịch sử nhập kho
// class AccessImportHistorySuccessState extends HistoryState {
//   DateTime timestamp;
//   List<Warehouse> warehouse;
//   List<Department> department;
//   List<Item> item;
//   List<GoodsReceiptLot> goodReceiptLots;
//   AccessImportHistorySuccessState(
//     this.timestamp,
//     this.department,
//     this.warehouse,
//     this.item,
//     this.goodReceiptLots,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryLoadingState extends HistoryState {
//   DateTime timestamp;
//   AccessImportHistoryLoadingState(
//     this.timestamp,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryFailState extends HistoryState {
//   DateTime timestamp;
//   ErrorPackage status;
//   AccessImportHistoryFailState(
//     this.timestamp,
//     this.status,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }
// // lich su nhap theo so PO
// class AccessImportHistoryByPOSuccessState extends HistoryState {
//   DateTime timestamp;
//   List<GoodsReceiptLot> goodReceiptLots;
//   AccessImportHistoryByPOSuccessState(
//     this.timestamp,
//     this.goodReceiptLots,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryByPOLoadingState extends HistoryState {
//   DateTime timestamp;
//   AccessImportHistoryByPOLoadingState(
//     this.timestamp,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryByPOFailState extends HistoryState {
//   DateTime timestamp;
//   ErrorPackage status;
//   AccessImportHistoryByPOFailState(
//     this.timestamp,
//     this.status,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }
// // lich su nhap kho theo nha cung cap
// class AccessImportHistoryBySupplierSuccessState extends HistoryState {
//   DateTime timestamp;
//   List<GoodsReceiptLot> goodReceiptLots;
//   AccessImportHistoryBySupplierSuccessState(
//     this.timestamp,
//     this.goodReceiptLots,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryBySupplierLoadingState extends HistoryState {
//   DateTime timestamp;
//   AccessImportHistoryBySupplierLoadingState(
//     this.timestamp,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryBySupplierFailState extends HistoryState {
//   DateTime timestamp;
//   ErrorPackage status;
//   AccessImportHistoryBySupplierFailState(
//     this.timestamp,
//     this.status,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }
// lich su nhap kho theo ma san pham
class AccessImportHistorySuccessState extends HistoryState {
  DateTime timestamp;
  List<GoodsReceiptLot> goodReceiptLots;
  AccessImportHistorySuccessState(
    this.timestamp,
    this.goodReceiptLots,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryLoadingState extends HistoryState {
  DateTime timestamp;
  AccessImportHistoryLoadingState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessImportHistoryFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  AccessImportHistoryFailState(
    this.timestamp,
    this.status,
  );
  @override
  List<Object> get props => [timestamp];
}

// Truy xuất lịch sử xuất kho
// // lich su xuat theo so PO
// class AccessExportHistoryByPOSuccessState extends HistoryState {
//   DateTime timestamp;
//   List<GoodsIssueLot> goodsIssueLot;
//   AccessExportHistoryByPOSuccessState(
//     this.timestamp,
//     this.goodsIssueLot,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessExportHistoryByPOLoadingState extends HistoryState {
//   DateTime timestamp;
//   AccessExportHistoryByPOLoadingState(
//     this.timestamp,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessExportHistoryByPOFailState extends HistoryState {
//   DateTime timestamp;
//   ErrorPackage status;
//   AccessExportHistoryByPOFailState(
//     this.timestamp,
//     this.status,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }
// // lich su xuat kho theo nha cung cap
// class AccessExportHistoryByReceiverSuccessState extends HistoryState {
//   DateTime timestamp;
//   List<GoodsIssueLot> goodsIssueLot;
//   AccessExportHistoryByReceiverSuccessState(
//     this.timestamp,
//     this.goodsIssueLot,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessExportHistoryByReceiverLoadingState extends HistoryState {
//   DateTime timestamp;
//   AccessExportHistoryByReceiverLoadingState(
//     this.timestamp,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// class AccessImportHistoryByReceiverFailState extends HistoryState {
//   DateTime timestamp;
//   ErrorPackage status;
//   AccessImportHistoryByReceiverFailState(
//     this.timestamp,
//     this.status,
//   );
//   @override
//   List<Object> get props => [timestamp];
// }
// lich su xuat kho theo ma san pham
class AccessExportHistorySuccessState extends HistoryState {
  DateTime timestamp;
  List<GoodsIssueLot> goodsIssueLot;
  AccessExportHistorySuccessState(
    this.timestamp,
    this.goodsIssueLot,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryLoadingState extends HistoryState {
  DateTime timestamp;
  AccessExportHistoryLoadingState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class AccessExportHistoryFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  AccessExportHistoryFailState(
    this.timestamp,
    this.status,
  );
  @override
  List<Object> get props => [timestamp];
}

// Truy xuất lịch sử xuất kho
class TestHistorySuccessState extends HistoryState {
  DateTime timestamp;
  List<GoodsReceiptLot> goodReceiptLots;
  TestHistorySuccessState(
    this.timestamp,
    this.goodReceiptLots,
  );
  @override
  List<Object> get props => [timestamp];
}

class TestHistoryLoadingState extends HistoryState {
  DateTime timestamp;
  TestHistoryLoadingState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class TestHistoryFailState extends HistoryState {
  DateTime timestamp;
  ErrorPackage status;
  TestHistoryFailState(
    this.timestamp,
    this.status,
  );
  @override
  List<Object> get props => [timestamp];
}
