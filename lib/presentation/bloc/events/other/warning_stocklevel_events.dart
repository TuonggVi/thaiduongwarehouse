// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class WarningStockLevelEvent extends Equatable {}

class GetWarehouseEvent extends WarningStockLevelEvent {
  DateTime timestamp;
  GetWarehouseEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoadExpirationWarningEvent extends WarningStockLevelEvent {
  DateTime timestamp;
  int expirationDate;
  LoadExpirationWarningEvent(this.timestamp, this.expirationDate);
  @override
  List<Object> get props => [timestamp];
}

class LoadMinimumStockWarningEvent extends WarningStockLevelEvent {
  DateTime timestamp;
  String warehouseId;
  List<Warehouse> listWarehouse;

  LoadMinimumStockWarningEvent(
    this.timestamp,
    this.warehouseId,
    this.listWarehouse,
  );
  @override
  List<Object> get props => [timestamp];
}
