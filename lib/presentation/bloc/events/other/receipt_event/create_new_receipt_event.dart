// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/other/goods_receipt.dart';

abstract class CreateReceiptEvent extends Equatable {}

// class GetAllItemEvent extends CreateReceiptEvent {
//   DateTime timestamp;
//   List<ItemLotView> lots;
//   int index;
//   GetAllItemEvent(this.timestamp, this.lots, this.index);
//   @override
//   List<Object> get props => [timestamp];
// }
// thêm lô mới
class AddLotToGoodsReceiptEvent extends CreateReceiptEvent {
// lot mới cần thêm vào
  GoodsReceiptLot itemLot;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddLotToGoodsReceiptEvent(this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [itemLot];
}
// cập nhật thông tin lô (chưa cập nhật vị trí)
class UpdateLotReceiptEvent extends CreateReceiptEvent {
  GoodsReceiptLot itemLot;
   GoodsReceipt goodsReceipt;
  int index;

  UpdateLotReceiptEvent(this.itemLot, this.goodsReceipt, this.index);
  @override
  List<Object?> get props => [itemLot];
}
// post phiếu nhập lên server
class PostNewReceiptEvent extends CreateReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PostNewReceiptEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}
// cập nhật không thành công
class UpdateReceiptFailEvent extends CreateReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  UpdateReceiptFailEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}