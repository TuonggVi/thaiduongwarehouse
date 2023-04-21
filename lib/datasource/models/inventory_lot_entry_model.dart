// ignore_for_file: prefer_const_constructors_in_immutables, unused_import

import 'package:mobile_warehouse_thaiduong/domain/entities/inventory_log_entry.dart';

import '../../domain/entities/item_lot.dart';
import 'item_lot_model.dart';
import 'item_model.dart';

class InventoryLogEntryModel extends InventoryLogEntry {
  InventoryLogEntryModel(super.item, super.beforeQuantity, super.afterQuantity,
      super.timestamp, super.itemLot);
  factory InventoryLogEntryModel.fromJson(Map<String, dynamic> json) {
    return InventoryLogEntryModel(
      json['item'] = ItemModel.fromJson(json["item"]),
      json['beforeQuantity'],
      json['afterQuantity'],
      json['timestamp'],
      json['itemLot'] = ItemLotModel.fromJson(json["itemLot"]),
    );
  }
}
