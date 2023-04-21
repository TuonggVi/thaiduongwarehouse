// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../domain/entities/goods_issue.dart';

abstract class GoodsIssueEntryEvent extends Equatable {}

class LoadGoodsIssueEntryEvent extends GoodsIssueEntryEvent {
  DateTime timestamp;
  GoodsIssue goodsIssue;
  LoadGoodsIssueEntryEvent(this.timestamp,this.goodsIssue);
  @override

  List<Object?> get props => [timestamp];
}