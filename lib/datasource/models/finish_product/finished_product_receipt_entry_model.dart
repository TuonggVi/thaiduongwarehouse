// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/finish_product/finished_product_receipt_entry.dart';


import '../item_model.dart';

class FinishedProductReceiptEntryModel extends FinishedProductReceiptEntry {
  FinishedProductReceiptEntryModel(
    super.purchaseOrderNumber,
    super.quantity,
    super.note,
    super.item,
  );
  factory FinishedProductReceiptEntryModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductReceiptEntryModel(
      json['purchaseOrderNumber'],
      double.parse(json['quantity'].toString()),
      json['note'],
   json['item'] = ItemModel.fromJson(json["item"]),
    );
  }
}
