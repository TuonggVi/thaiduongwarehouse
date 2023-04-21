// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class GoodsIssueLot extends Equatable {
  String? goodsIssueLotId;
  double quantity;
  double sublotSize;
  String? employee;
  String? note;
  GoodsIssueLot(this.goodsIssueLotId, this.quantity, this.sublotSize,
      this.employee, this.note);
  @override
  List<Object?> get props => [goodsIssueLotId];
}

class GoodsIssueEntry extends Equatable {
  Item? item;
  double? requestSublotSize;
  double? requestQuantity;
  List<GoodsIssueLot>? lots;
  GoodsIssueEntry(
      this.item, this.requestSublotSize, this.requestQuantity, this.lots);
  @override
  List<Object?> get props => [item];
}

class GoodsIssue extends Equatable {
  String? goodsIssueId;
  String? purchaseOrderNumber;
  DateTime? timestamp;
  bool isConfirmed;
  String? receiver;
  List<GoodsIssueEntry>? entries;
  GoodsIssue(this.goodsIssueId, this.purchaseOrderNumber, this.timestamp,
      this.isConfirmed, this.receiver, this.entries);
  @override
  List<Object?> get props => throw UnimplementedError();
}
//  View Issue Entry: dùng để hiển thị và post

class IssueEntryView extends Equatable {
  String? itemName;
  double? requestSublotSize;
  double? requestQuantity;
  String? unit;
  IssueEntryView(
      this.itemName, this.requestQuantity, this.requestSublotSize, this.unit);
  @override
  List<Object?> get props => throw UnimplementedError();
}