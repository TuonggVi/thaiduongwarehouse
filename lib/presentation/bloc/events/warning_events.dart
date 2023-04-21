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
  GetWarehouseEvent(this.timestamp);
  @override

  List<Object> get props => [timestamp];
}

// hiển thị danh sách sản phẩm dưới số lượng tồn kho tối thiểu
class MinimumStockWarningEvent extends WarningEvent {
  DateTime timestamp;
  List <Warehouse> warehouse;
  String warehouseId;
  List<Warehouse> listWarehouse;
  MinimumStockWarningEvent(this.timestamp, this.warehouseId, this.warehouse,
  this.listWarehouse
  );
  @override
  List<Object> get props => [timestamp];
}