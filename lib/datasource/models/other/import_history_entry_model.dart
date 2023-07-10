// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/import_history_entry.dart';


class ImportHistoryEntryModel extends ImportHistoryEntry {
  ImportHistoryEntryModel({super.supplier, super.timestamp, super.lots});
  ImportHistoryEntryModel.fromJson(Map<String, dynamic> json) {
    supplier = json["supplier"];
    timestamp = DateTime.tryParse(json['timestamp'].toString());
    lots = json["lots"] == null
        ? null
        : (json["lots"] as List)
            .map((e) => LotsHistoryModel.fromJson(e))
            .toList();
  }
}

class LotsHistoryModel extends LotsHistory {
  LotsHistoryModel(
      {super.goodsReceiptLotId,
      super.item,
      super.purchaseOrderNumber,
      super.quantity,
      super.note});

  LotsHistoryModel.fromJson(Map<String, dynamic> json) {
    goodsReceiptLotId = json["goodsReceiptLotId"];
    quantity = json["quantity"];
    purchaseOrderNumber = json["purchaseOrderNumber"];
    item = json["item"] == null ? null : ItemModel.fromJson(json["item"]);
    note = json["note"];
  }
}
