// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

abstract class CompletedGoodsIssueState extends Equatable {}

class LoadCompletedGoodsIssueInitState extends CompletedGoodsIssueState {
  DateTime timestamp;
  LoadCompletedGoodsIssueInitState(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class LoadCompletedGoodsIssuesLoadingState extends CompletedGoodsIssueState {
  DateTime timestamp;
  LoadCompletedGoodsIssuesLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class LoadCompletedGoodsIssuesSuccessState extends CompletedGoodsIssueState {
  DateTime timestamp;
  List<GoodsIssue> goodsIssues;
  LoadCompletedGoodsIssuesSuccessState(this.timestamp, this.goodsIssues);
  @override
  List<Object?> get props => [timestamp];
}

class LoadCompletedGoodsIssuesFailState extends CompletedGoodsIssueState {
  DateTime timestamp;
  String detail;
  LoadCompletedGoodsIssuesFailState(this.timestamp, this.detail);
  @override
  List<Object?> get props => [timestamp];
}
