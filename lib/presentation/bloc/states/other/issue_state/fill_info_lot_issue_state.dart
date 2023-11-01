// ignore_for_file: must_be_immutable, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

abstract class FillInfoIssueEntryState extends Equatable {}

class LoadItemDataLoadingState extends FillInfoIssueEntryState {
  DateTime timestamp;
  LoadItemDataLoadingState(this.timestamp);

  @override

  List<Object?> get props => [timestamp];
}
class LoadItemDataSuccessState extends FillInfoIssueEntryState {
  //  String issueId;
  // String receiver;
  // String poNumber;
  List<Item> items;
  GoodsIssue? goodsIssue;
  int index;
  DateTime timestamp;
  @override
  LoadItemDataSuccessState( this.items, this.goodsIssue, this.index, this.timestamp);
 
  List<Object?> get props => [timestamp];
}

class LoadItemDataFailState extends FillInfoIssueEntryState {
  DateTime timestamp;
  LoadItemDataFailState(this.timestamp);

  @override

  List<Object?> get props => [timestamp];
}
