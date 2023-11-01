// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/employee_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

import '../location_model.dart';

class GoodsIssueLotModel extends GoodsIssueLot {
  GoodsIssueLotModel(super.goodsIssueLotId, super.quantity, super.unit,
      super.employee, super.note, super.goodsIssueSublot);
  factory GoodsIssueLotModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueLotModel(
      json['goodsIssueLotId'],
      double.tryParse(json['quantity'].toString()),
       json['unit'],
      json['employee'] == null
          ? const EmployeeModel('', '')
          : EmployeeModel.fromJson(json["employee"]),
      json['note'],
      json['goodsReceiptSublot'] == null
          ? []
          : (json["goodsReceiptSublot"] as List)
              .map((e) => GoodsIssueSublotModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsIssueEntryModel extends GoodsIssueEntry {
  GoodsIssueEntryModel(
      super.item, super.requestQuantity, super.actualQuantity, super.lots);
  factory GoodsIssueEntryModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryModel(
      json['item'] = ItemModel.fromJson(json["item"]),
      double.tryParse(json['requestedQuantity'].toString()),
      0,
      json['lots'] == null
          ? []
          : (json["lots"] as List)
              .map((e) => GoodsIssueLotModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsIssueModel extends GoodsIssue {
  GoodsIssueModel(super.goodsIssueId, super.timestamp, super.receiver,
      super.employee, super.entries);
  factory GoodsIssueModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueModel(
      json['goodsIssueId'],
      DateTime.tryParse(json['timestamp'].toString()),
      json['receiver'],
      json['employee'] == null
          ? const EmployeeModel("", "")
          : EmployeeModel.fromJson(json["employee"]),
      json['entries'] == null
          ? []
          : (json["entries"] as List)
              .map((e) => GoodsIssueEntryModel.fromJson(e))
              .toList(),
    );
  }
}


