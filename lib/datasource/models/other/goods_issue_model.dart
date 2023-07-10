// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/employee_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';

class GoodsIssueLotModel extends GoodsIssueLot {
  GoodsIssueLotModel(super.goodsIssueLotId, super.quantity, super.sublotSize,
      super.employee, super.note);
  factory GoodsIssueLotModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueLotModel(
      json['goodsIssueLotId'],
      double.tryParse(json['quantity'].toString()),
      double.tryParse(json['sublotSize'].toString()),
      json['employee'] == null
          ? const EmployeeModel('', '')
          : EmployeeModel.fromJson(json["employee"]),
      json['note'],
    );
  }
}

class GoodsIssueEntryModel extends GoodsIssueEntry {
  GoodsIssueEntryModel(super.item, super.requestSublotSize,
      super.requestQuantity, super.actualQuantity, super.lots);
  factory GoodsIssueEntryModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryModel(
      json['item'] = ItemModel.fromJson(json["item"]),
      double.tryParse(json['requestedSublotSize'].toString()),
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
  GoodsIssueModel(
      super.goodsIssueId,
      super.purchaseOrderNumber,
      super.timestamp,
      super.isConfirmed,
      super.receiver,
      super.employee,
      super.entries);
  factory GoodsIssueModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueModel(
      json['goodsIssueId'],
      json['purchaseOrderNumber'],
      DateTime.tryParse(json['timestamp'].toString()),
      json['isConfirmed'],
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



// class GoodsIssueEntryViewModel extends IssueEntryView {
//   GoodsIssueEntryViewModel(
//       super.itemName, super.requestSublotSize, super.requestQuantity, super.unit);
//   factory GoodsIssueEntryViewModel.fromJson(Map<String, dynamic> json) {
//     return GoodsIssueEntryViewModel(
//       json['itemName'],
//       json['requestSublotSize'],
//       json['requestQuantity'],
//       json['unit'] 
//     );
//   }
// }