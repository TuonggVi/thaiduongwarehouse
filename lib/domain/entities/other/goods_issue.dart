// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

import '../location.dart';

class GoodsIssueLot extends Equatable {
  String? goodsIssueLotId;
  double? quantity;
  String? unit;
  Employee? employee;
  String? note;
  List<GoodsIssueSublot> goodsIssueSublot;
  GoodsIssueLot(this.goodsIssueLotId, this.quantity, this.unit,this.employee, this.note,
      this.goodsIssueSublot);
  @override
  List<Object?> get props => [goodsIssueLotId];
}

class GoodsIssueEntry extends Equatable {
  Item? item;
  double? requestQuantity;
  double? actualQuantity;
  List<GoodsIssueLot>? lots;
  GoodsIssueEntry(
      this.item, this.requestQuantity, this.actualQuantity, this.lots);
  @override
  List<Object?> get props => [item];
}

class GoodsIssue extends Equatable {
  String? goodsIssueId;
  DateTime? timestamp;
  String? receiver;
  Employee? employee;
  List<GoodsIssueEntry>? entries;
  GoodsIssue(this.goodsIssueId, this.timestamp, this.receiver, this.employee,
      this.entries);
  @override
  List<Object?> get props => throw UnimplementedError();
}
//  View Issue Entry: dùng để hiển thị và post

// class IssueEntryView extends Equatable {
//   String? itemName;
//   double? requestSublotSize;
//   double? requestQuantity;
//   String? unit;
//   IssueEntryView(
//       this.itemName, this.requestQuantity, this.requestSublotSize, this.unit);
//   @override
//   List<Object?> get props => throw UnimplementedError();
// }