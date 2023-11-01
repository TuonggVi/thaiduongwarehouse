// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

import '../location.dart';

class GoodsReceiptLot extends Equatable {
  String? goodsReceiptLotId;
  String? oldGoodsReceiptLotId;
  String? newGoodsReceiptLotId;
  List<GoodsReceiptSublot> goodsReceiptSublots;
  Item? item;
  String? unit;
  double? quantity;

  Employee? employeeId;

  DateTime? productionDate;
  DateTime? expirationDate;
  String? note;
  GoodsReceiptLot(
      this.goodsReceiptLotId,
      this.oldGoodsReceiptLotId,
      this.newGoodsReceiptLotId,
      this.goodsReceiptSublots,
      this.item,
      this.unit,
      this.quantity,
      this.employeeId,

      this.productionDate,
      this.expirationDate,
      this.note);
  @override
  List<Object?> get props => [goodsReceiptLotId];
}

class GoodsReceipt extends Equatable {
  String? goodsReceiptId;
  String? supply;
  DateTime? timestamp;
  Employee? empployee;
  List<GoodsReceiptLot> lots;
  bool? isCompleted;
  GoodsReceipt(this.goodsReceiptId, this.supply, this.lots, this.timestamp,
      this.empployee, this.isCompleted);
  @override
  List<Object?> get props => [goodsReceiptId];
}

// chỉnh sửa mã lô và số lượng, 1 lô có nhiều vị trí
class GoodsReceiptLotAdjustment extends Equatable {
  String? oldGoodsReceiptLotId;
  String? newGoodsReceiptLotId;
  List<GoodsReceiptSublot>? goodsReceiptSublots;
  double? quantity;
  DateTime? productionDate;
  DateTime? expirationDate;
  GoodsReceiptLotAdjustment(
      this.oldGoodsReceiptLotId,
      this.newGoodsReceiptLotId,
      this.goodsReceiptSublots,
      this.quantity,
      this.productionDate,
      this.expirationDate);
  @override
  List<Object?> get props => [oldGoodsReceiptLotId];
}
