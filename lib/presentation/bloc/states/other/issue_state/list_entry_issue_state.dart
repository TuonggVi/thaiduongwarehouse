// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

import '../../../../../domain/entities/error_package.dart';

abstract class GoodsIssueEntryState extends Equatable {}

class LoadGoodsIssueEntryLoadingState extends GoodsIssueEntryState {
  DateTime timestamp;
  LoadGoodsIssueEntryLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueEntrySuccessState extends GoodsIssueEntryState {
  DateTime timestamp;
  List<GoodsIssue> goodsIssues;
  LoadGoodsIssueEntrySuccessState(this.timestamp, this.goodsIssues);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueEntryFailState extends GoodsIssueEntryState {
  DateTime timestamp;
  LoadGoodsIssueEntryFailState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// xóa yêu cầu trong phiếu xuất
class RemoveGoodIssueEntrySuccessState extends GoodsIssueEntryState {
  int index;
  GoodsIssue? goodsIssue;
  DateTime timestamp;
  RemoveGoodIssueEntrySuccessState(this.index, this.goodsIssue, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class RemoveGoodIssueEntryLoadingState extends GoodsIssueEntryState {
  DateTime timestamp;
  RemoveGoodIssueEntryLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class RemoveGoodIssueEntryFailState extends GoodsIssueEntryState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsIssue? goodsIssue;
  RemoveGoodIssueEntryFailState(this.error, this.timestamp, this.goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}
