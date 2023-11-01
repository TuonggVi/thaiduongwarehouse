// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../datasource/models/other/goods_receipt_model.dart';
import '../../../../../domain/entities/other/goods_receipt.dart';

class FillInfoNewLotReceiptEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

// dành cho khi tạo phiếu
class FillNewReceiptLotEvent extends FillInfoNewLotReceiptEvent {
  DateTime timestamp;
  // đơn nhập
  GoodsReceipt goodsReceipt;
  // thứ tự của lô cần xử lý, nếu = -1 => thêm lô mới
  int index;
  FillNewReceiptLotEvent(this.timestamp, this.goodsReceipt, this.index);
  @override
  List<Object> get props => [timestamp];
}

// dành cho khi sửa phiếu đã gửi
class RefillNewReceiptLotEvent extends FillInfoNewLotReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  int index;
  RefillNewReceiptLotEvent(this.timestamp, this.goodsReceipt, this.index);
  @override
  List<Object> get props => [timestamp];
}

class PostNewReceiptLotEvent extends FillInfoNewLotReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  PostNewReceiptLotEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}

class UpdateReceiptLotFailEvent extends FillInfoNewLotReceiptEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  UpdateReceiptLotFailEvent( this.timestamp, this.goodsReceipt);
  @override
  List<Object> get props => [timestamp];
}
// thêm lô mới vào phiếu nhập kho
class AddNewLotToGoodsReceiptEvent extends FillInfoNewLotReceiptEvent {
// lot mới cần thêm vào
  GoodsReceiptLotModel itemLot;
  // đơn cần cập nhật
  GoodsReceipt goodsReceipt;
  AddNewLotToGoodsReceiptEvent(this.itemLot, this.goodsReceipt);
  @override
  List<Object> get props => [itemLot];
}