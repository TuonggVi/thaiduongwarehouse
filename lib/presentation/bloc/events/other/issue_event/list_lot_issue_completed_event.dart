// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/other/goods_issue.dart';

abstract class GoodsIssueLotCompletedEvent extends Equatable {}

class LoadGoodsIssueLotCompletedEvent extends GoodsIssueLotCompletedEvent {
  DateTime timestamp;
  GoodsIssue goodsIssue;
  LoadGoodsIssueLotCompletedEvent(this.timestamp, this.goodsIssue);
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
