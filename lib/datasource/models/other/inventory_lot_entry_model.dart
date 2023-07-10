import 'package:mobile_warehouse_thaiduong/domain/entities/other/inventory_log_entry.dart';

import '../item_model.dart';

class InventoryLogEntryModel extends InventoryLogEntry {
  const InventoryLogEntryModel(super.item, super.beforeQuantity, super.changedQuantity,
      super.timestamp, super.itemLot);
  factory InventoryLogEntryModel.fromJson(Map<String, dynamic> json) {
    return InventoryLogEntryModel(
      json['item']  = ItemModel.fromJson(json["item"]),
     double.parse( json['beforeQuantity'].toString()),  
        double.parse( json['changedQuantity'].toString()),  
      DateTime.parse( json['timestamp'].toString()), 
      json['itemLotId'],
    );
  }
}
