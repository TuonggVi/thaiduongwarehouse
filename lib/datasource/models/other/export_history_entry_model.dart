// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/export_history_entry.dart';

class ExportHistoryEntryModel extends ExportHistoryEntry {
  ExportHistoryEntryModel(
      {super.receiver,
      super.timestamp,
      super.purchaseOrderNumber,
      super.entries});
  ExportHistoryEntryModel.fromJson(Map<String, dynamic> json) {
    receiver = json["receiver"];
    purchaseOrderNumber = json["purchaseOrderNumber"];
    timestamp =  DateTime.tryParse( json['timestamp'].toString());
    entries = json["entries"] == null
        ? null
        : (json["entries"] as List)
            .map((e) => EntryHistoryModel.fromJson(e))
            .toList();
  }
}

class EntryHistoryModel extends EntriesHistory {
  EntryHistoryModel({super.item, super.lots, super.unit});
  EntryHistoryModel.fromJson(Map<String, dynamic> json) {
    item = json["item"] == null ? null : ItemModel.fromJson(json["item"]);
    unit = json["unit"];
    lots = json["lots"] == null
        ? null
        : (json["lots"] as List)
            .map((e) => LotsHistoryModel.fromJson(e))
            .toList();
  }
}

class LotsHistoryModel extends LotsHistory {
  LotsHistoryModel({super.goodsIssueLotId, super.quantity, super.note});
  LotsHistoryModel.fromJson(Map<String, dynamic> json) {
    goodsIssueLotId = json["goodsIssueLotId"];
    quantity = json["quantity"];
    note = json["note"];
  }
}
