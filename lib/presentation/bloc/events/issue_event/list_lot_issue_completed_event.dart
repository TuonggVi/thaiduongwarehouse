// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/goods_issue.dart';

abstract class GoodsIssueLotCompletedEvent extends Equatable {}

class LoadGoodsIssueLotCompletedEvent extends GoodsIssueLotCompletedEvent {
  DateTime timestamp;
  List<GoodsIssueLot> lotsExpected;
  LoadGoodsIssueLotCompletedEvent(this.timestamp, this.lotsExpected);
  @override

  List<Object?> get props => [timestamp];
}
// 
class UpdateGoodsIssueLotEvent extends GoodsIssueLotCompletedEvent {
  DateTime timestamp;
  UpdateGoodsIssueLotEvent(this.timestamp);
  @override
  
  List<Object?> get props => [timestamp];
}

