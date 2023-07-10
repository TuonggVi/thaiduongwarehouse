// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/finish_product/finished_product_inventory.dart';

import '../item_model.dart';

class FinishedProductInventoryModel extends FinishedProductInventory {
   FinishedProductInventoryModel(
      super.purchaseOrderNumber, super.quantity, super.timestamp, super.item);
  factory FinishedProductInventoryModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductInventoryModel(
      json['purchaseOrderNumber'],
      double.parse(json['quantity'].toString()),
      DateTime.parse(json['timestamp'].toString()),
      json['item'] = ItemModel.fromJson(json["item"]),
    );
  }
}
