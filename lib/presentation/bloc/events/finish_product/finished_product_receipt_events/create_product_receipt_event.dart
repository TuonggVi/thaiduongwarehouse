// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/finish_product/finished_product_receipt.dart';
import '../../../../../domain/entities/other/goods_receipt.dart';

abstract class CreateProductReceiptEvent extends Equatable {}

// thêm lô mới
class AddLotToProductGoodsReceiptEvent extends CreateProductReceiptEvent {
// lot mới cần thêm vào
  FinishedProductReceipt finishedProductReceipt;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddLotToProductGoodsReceiptEvent(this.finishedProductReceipt, this.goodsReceipt);
  @override
  List<Object> get props => [finishedProductReceipt];
}
// cập nhật thông tin lô (chưa cập nhật vị trí)
class UpdateLotReceiptEvent extends CreateProductReceiptEvent {
  GoodsReceiptLot itemLot;
   GoodsReceipt goodsReceipt;
  int index;

  UpdateLotReceiptEvent(this.itemLot, this.goodsReceipt, this.index);
  @override
  List<Object?> get props => [itemLot];
}
// post phiếu nhập lên server
class PostNewReceiptEvent extends CreateProductReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PostNewReceiptEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}
// cập nhật không thành công
class UpdateReceiptFailEvent extends CreateProductReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  UpdateReceiptFailEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}