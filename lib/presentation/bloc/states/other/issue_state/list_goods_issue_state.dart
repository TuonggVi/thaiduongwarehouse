// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

import '../../../../../domain/entities/error_package.dart';

abstract class GoodsIssueState extends Equatable {
  int index;
  GoodsIssueState(this.index);
}

class LoadGoodsIssuesLoadingState extends GoodsIssueState {
  DateTime timestamp;
  LoadGoodsIssuesLoadingState(this.timestamp) : super(0);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssuesSuccessState extends GoodsIssueState {
  DateTime timestamp;
  List<GoodsIssue> listGoodsIssues;
GoodsIssue goodsIssue;
GoodsIssueLot? goodIssueLot;
  LoadGoodsIssuesSuccessState(
    this.timestamp,
    this.listGoodsIssues,
    this.goodsIssue,
    this.goodIssueLot,
  ) : super(0);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssuesFailState extends GoodsIssueState {
  DateTime timestamp;
  String detail;
  LoadGoodsIssuesFailState(this.timestamp, this.detail) : super(0);
  @override
  List<Object?> get props => [timestamp];
}

class PatchRequestQuantityLoadingState extends GoodsIssueState {
  DateTime timestamp;

  PatchRequestQuantityLoadingState(
    this.timestamp,
  ) : super(0);
  @override
  List<Object?> get props => [timestamp];
}

class PatchRequestQuantitySuccessState extends GoodsIssueState {
  DateTime timestamp;
  ErrorPackage statusRequest;
  //List<GoodsIssue> listGoodsIssues;
  GoodsIssue goodsIssue;
 // int index;
  PatchRequestQuantitySuccessState(
      this.timestamp, this.statusRequest, this.goodsIssue)
      : super(0);
  @override
  List<Object?> get props => [timestamp];
}

class PatchRequestQuantityFailState extends GoodsIssueState {
  DateTime timestamp;

  ErrorPackage statusRequest;
  PatchRequestQuantityFailState(this.timestamp, this.statusRequest) : super(0);
  @override
  List<Object?> get props => [timestamp];
}
