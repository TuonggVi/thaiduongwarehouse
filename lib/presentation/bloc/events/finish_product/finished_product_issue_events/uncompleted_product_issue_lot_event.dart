
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class UncompletedReceiptLotEvent extends Equatable {}
// ds lô trong phiếu nhập 
class LoadUncompletedReceiptLotEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt receipt;
  LoadUncompletedReceiptLotEvent(this.timestamp, this.receipt);
  @override
  List<Object?> get props => [timestamp];
}

class LoadShelfIdEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  LoadShelfIdEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// cập nhật view
class UpdateReceiptLotEvent extends UncompletedReceiptLotEvent {
  int index;
  GoodsReceiptLot itemLot;
  GoodsReceipt goodsReceipt;
  UpdateReceiptLotEvent(this.index, this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [];
}

// post
class PostReceiptChangedEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PostReceiptChangedEvent(this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}

// thêm lô mới vào phiếu nhập kho
class AddNewLotToGoodsReceiptEvent extends UncompletedReceiptLotEvent {
// lot mới cần thêm vào
  GoodsReceiptLot itemLot;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddNewLotToGoodsReceiptEvent(this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [itemLot];
}