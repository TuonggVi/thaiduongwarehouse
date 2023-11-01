// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../datasource/models/location_model.dart';
import '../../../../../domain/entities/item.dart';
import '../../../../../domain/entities/other/goods_receipt.dart';

abstract class UpdateGoodsReceiptLotEvent extends Equatable {}

// chia lô
class AddGoodsReceiptSublotEvent extends UpdateGoodsReceiptLotEvent {
  GoodsReceipt goodsReceipt;
  int index;
  // sublot
  GoodsReceiptSublotModel goodsReceiptSublotModel;
 
  // lô cần chia
  GoodsReceiptLot goodsReceiptLot;
  List<Item> item;
  DateTime timestamp;
  AddGoodsReceiptSublotEvent(this.goodsReceipt, this.index, this.goodsReceiptSublotModel,
      this.goodsReceiptLot, this.item, this.timestamp);

  @override
  List<Object?> get props => [goodsReceiptSublotModel];
}

class RemoveGoodsReceiptSublotEvent extends UpdateGoodsReceiptLotEvent {
  GoodsReceipt goodsReceipt;
  int index;
  // sublot
  GoodsReceiptSublotModel goodsReceiptSublotModel;

  // lô cần chia
  GoodsReceiptLot goodsReceiptLot;
  List<Item> item;
  DateTime timestamp;
  RemoveGoodsReceiptSublotEvent(this.goodsReceipt, this.index, this.goodsReceiptSublotModel,
      this.goodsReceiptLot, this.item, this.timestamp);

  @override
  List<Object?> get props => [goodsReceiptSublotModel];
}

// dành cho khi tạo phiếu
class RefillReceiptLotEvent extends UpdateGoodsReceiptLotEvent {
  DateTime timestamp;
  // đơn nhập
  GoodsReceipt goodsReceipt;

  // thứ tự của lô cần xử lý, nếu = -1 => thêm lô mới
  int index;
  RefillReceiptLotEvent(this.timestamp, this.goodsReceipt, this.index, );
  @override
  List<Object> get props => [timestamp];
}
