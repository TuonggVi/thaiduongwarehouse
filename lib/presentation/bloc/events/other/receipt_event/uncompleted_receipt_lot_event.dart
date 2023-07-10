
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class UncompletedReceiptLotEvent extends Equatable {}
// ds lô trong phiếu nhập 
class LoadUncompletedReceiptLotEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;

  GoodsReceipt receipt;
  LoadUncompletedReceiptLotEvent(this.timestamp,this.receipt);
  @override
  List<Object?> get props => [timestamp];
}

class LoadShelfIdEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  LoadShelfIdEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
// thêm lô mới vào phiếu nhập kho
class AddNewLotToGoodsReceiptEvent extends UncompletedReceiptLotEvent {
// lot mới cần thêm vào
  GoodsReceiptLotModel itemLot;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddNewLotToGoodsReceiptEvent(this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [itemLot];
}
// cập nhật view
class UpdateReceiptLotEvent extends UncompletedReceiptLotEvent {
  int index;
  GoodsReceiptLotModel itemLot;
  GoodsReceipt goodsReceipt;
  UpdateReceiptLotEvent(this.index, this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [];
}

// sửa phiếu nhập kho
class PatchReceiptChangedEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PatchReceiptChangedEvent(this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}



// cập nhật không thành công
class UpdateReceiptFailEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  UpdateReceiptFailEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}
// post phiếu nhập lên server
class PostReceiptChangedEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceiptModel goodsReceipt;
  PostReceiptChangedEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}