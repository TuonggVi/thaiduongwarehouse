// ignore_for_file: must_be_immutable
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import '../../../domain/entities/finish_product/finished_product_issue_entry.dart';

class FinishedProductIssueEntryModel extends FinishedProductIssueEntry {
  FinishedProductIssueEntryModel(
      super.purchaseOrderNumber, super.quantity, super.note, super.item);
  factory FinishedProductIssueEntryModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductIssueEntryModel(
      json['purchaseOrderNumber'],
      double.parse(json['quantity'].toString()),
      json['note'],
      json['item'] = ItemModel.fromJson(json["item"]),
    );
  }
}
