// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

abstract class FillInfoIssueEntryEvent extends Equatable {}

class GetAllItemIssueEvent extends FillInfoIssueEntryEvent {
  DateTime timestamp;
  //    String issueId;
  // String receiver;
  // String poNumber;
  GoodsIssue? goodsIssue;
  int index;
  GetAllItemIssueEvent( this.timestamp, this.goodsIssue, this.index);
  @override
  List<Object> get props => [timestamp];
}
