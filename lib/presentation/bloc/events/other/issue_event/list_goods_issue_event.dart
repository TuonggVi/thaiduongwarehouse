// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/other/goods_issue.dart';

abstract class GoodsIssueEvent extends Equatable {
  GoodsIssueLot? goodsIssueLot;
  GoodsIssueEvent(this.goodsIssueLot);
}

class LoadGoodsIssuesEvent extends GoodsIssueEvent {
  DateTime timestamp;
  GoodsIssueLot? goodsIssueLot;
  LoadGoodsIssuesEvent(this.timestamp, this.goodsIssueLot)
      : super(goodsIssueLot);
  @override
  List<Object?> get props => [timestamp];
}

class PatchRequestQuantityEvent extends GoodsIssueEvent {
  DateTime timestamp;
  int index;
  // danh sách phiếu
  // List<GoodsIssue> listGoodsIssue;
  // phiếu cần chỉnh sửa
  GoodsIssue goodsIssue;

  PatchRequestQuantityEvent(
    this.timestamp,
    this.index,
    this.goodsIssue,
  ) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
