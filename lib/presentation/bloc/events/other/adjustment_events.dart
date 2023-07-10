// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';

import '../../../../domain/entities/other/item_lot.dart';

abstract class AdjustmentEvent extends Equatable {}

class GetLotEvent extends AdjustmentEvent {
  DateTime timestamp;
  String lotId;
  GetLotEvent(this.timestamp, this.lotId);
  @override
  List<Object> get props => [timestamp];
}

class UpdateLotAdjustmentQuantityEvent extends AdjustmentEvent {
  DateTime timestamp;
  String employeeName;
  LotAdjustment lotAdjustment;
  UpdateLotAdjustmentQuantityEvent(this.timestamp, this.employeeName,
     this.lotAdjustment);
  @override
  List<Object> get props => [timestamp];
}
