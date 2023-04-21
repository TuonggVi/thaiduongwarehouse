// ignore_for_file: must_be_immutable, unused_import

import 'package:equatable/equatable.dart';

import '../../../../domain/entities/goods_receipt.dart';
import '../../../../domain/entities/item_lot.dart';

abstract class CreateReceiptEvent extends Equatable {}

// class GetAllItemEvent extends CreateReceiptEvent {
//   DateTime timestamp;
//   List<ItemLotView> lots;
//   int index;
//   GetAllItemEvent(this.timestamp, this.lots, this.index);
//   @override
//   List<Object> get props => [timestamp];
// }

class AddLotToGoodsReceiptEvent extends CreateReceiptEvent {
// lot mới cần thêm vào
  GoodsReceiptLot itemLot;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddLotToGoodsReceiptEvent(this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [itemLot];
}

class UpdateLotReceiptEvent extends CreateReceiptEvent {
  GoodsReceiptLot itemLot;
   GoodsReceipt goodsReceipt;
  int index;

  UpdateLotReceiptEvent(this.itemLot, this.goodsReceipt, this.index);
  @override

  List<Object?> get props => [itemLot];
}

class PostNewReceiptEvent extends CreateReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PostNewReceiptEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}