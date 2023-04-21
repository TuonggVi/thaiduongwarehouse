// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/lot_adjustment.dart';

abstract class AdjustmentEvent extends Equatable {}

class GetLotDetailEvent extends AdjustmentEvent {
  DateTime timestamp;
  String lotId;
  GetLotDetailEvent(this.timestamp, this.lotId);
  @override
  List<Object> get props => [timestamp];
}

class UpdateLotAdjustmentQuantityEvent extends AdjustmentEvent {
  DateTime timestamp;
  LotAdjustmentView lotAdjustmentView;
  List<LotAdjustmentView> lotAdjustment;
   int index;
  UpdateLotAdjustmentQuantityEvent(
      this.timestamp, this.lotAdjustmentView, this.lotAdjustment, this.index);
  @override
  List<Object> get props => [lotAdjustmentView];
}

