// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class ImportHistoryEntry extends Equatable {
  String? supplier;
  DateTime? timestamp;
  List<LotsHistory>? lots;

  ImportHistoryEntry({this.supplier, this.timestamp, this.lots});

  @override
  List<Object?> get props => [timestamp];
}

class LotsHistory extends Equatable {
  String? goodsReceiptLotId;
  int? quantity;
  String? purchaseOrderNumber;
  Item? item;
  String? note;

  LotsHistory(
      {this.goodsReceiptLotId,
      this.quantity,
      this.purchaseOrderNumber,
      this.item,
      this.note});
  @override
  List<Object?> get props => [goodsReceiptLotId];
}

class ImportHistoryView {
  String? goodsReceiptLotId;
  int? quantity;
  String? purchaseOrderNumber;
  String? itemName;
  String? note;
  String? supplier;
  DateTime? timestamp;
  ImportHistoryView(
      this.goodsReceiptLotId,
      this.quantity,
      this.purchaseOrderNumber,
      this.itemName,
      this.note,
      this.supplier,
      this.timestamp);
}
