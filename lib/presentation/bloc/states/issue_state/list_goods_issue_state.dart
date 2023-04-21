
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';

abstract class GoodsIssueState extends Equatable {}

class LoadGoodsIssuesLoadingState extends GoodsIssueState {
  DateTime timestamp;
  LoadGoodsIssuesLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class LoadGoodsIssuesSuccessState extends GoodsIssueState {
  DateTime timestamp;
  List<GoodsIssue> goodsIssues;
  LoadGoodsIssuesSuccessState(this.timestamp, this.goodsIssues);
  @override

  List<Object?> get props => [timestamp];
}

class LoadGoodsIssuesFailState extends GoodsIssueState {
  DateTime timestamp;
  LoadGoodsIssuesFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
