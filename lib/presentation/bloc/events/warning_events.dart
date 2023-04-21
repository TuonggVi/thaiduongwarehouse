// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';



abstract class WarningEvent extends Equatable {}
// hiển thị danh sách sản phẩm theo hạn sử dụng còn lại
class ExpirationWarningEvent extends WarningEvent {
  DateTime timestamp;
  String expirationDate;
  ExpirationWarningEvent(this.timestamp, this.expirationDate);
  @override
  List<Object> get props => [timestamp];
}

// hiển thị list kho hàng
class GetWarehouseEvent extends WarningEvent {
  DateTime timestamp;
    //List<Warehouse> listWarehouse;
  GetWarehouseEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// hiển thị danh sách sản phẩm dưới số lượng tồn kho tối thiểu
class MinimumStockWarningEvent extends WarningEvent {
  DateTime timestamp;
  String warehouseId;
  List<Warehouse> listWarehouse;
   List<Warehouse> warehouse;
  MinimumStockWarningEvent(this.timestamp, this.warehouseId,
  this.listWarehouse, this.warehouse
  );
  @override
  List<Object> get props => [timestamp];
}