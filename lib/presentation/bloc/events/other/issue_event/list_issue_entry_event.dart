// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/other/goods_issue.dart';

abstract class GoodsIssueEntryEvent extends Equatable {}

class LoadGoodsIssueEntryEvent extends GoodsIssueEntryEvent {
  DateTime timestamp;
  GoodsIssue goodsIssue;
  LoadGoodsIssueEntryEvent(this.timestamp, this.goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}

// xóa yêu cầu trong phiếu
class RemoveGoodsIssueEntryEvent extends GoodsIssueEntryEvent {
  GoodsIssue goodsIssue;
  int index;
  GoodsIssueEntry goodsIssueEntry;
  DateTime timestamp;
  RemoveGoodsIssueEntryEvent(
      this.goodsIssue, this.index, this.goodsIssueEntry, this.timestamp);

  @override
  List<Object?> get props => [];
}
