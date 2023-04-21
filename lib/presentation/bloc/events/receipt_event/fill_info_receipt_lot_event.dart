// ignore_for_file: must_be_immutable, unused_import
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/goods_receipt.dart';
import '../../../../domain/entities/item_lot.dart';

class FillInfoLotReceiptEvent extends Equatable {
  @override

  List<Object?> get props => throw UnimplementedError();
}

// dành cho khi tạo phiếu
class FillReceiptLotEvent extends FillInfoLotReceiptEvent {
  DateTime timestamp;
  // đơn nhập
  GoodsReceipt goodsReceipt;
  // thứ tự của lô cần xử lý, nếu = -1 => thêm lô mới
  int index;
  // function = true => fill, function = false => refill => một trang cho 2 chức năng
  bool function;
  FillReceiptLotEvent(this.timestamp, this.goodsReceipt, this.index, this.function);
  @override
  List<Object> get props => [timestamp];
}

// dành cho khi sửa phiếu đã gửi
// class RefillReceiptLotEvent extends FillInfoLotReceiptEvent {
//   DateTime timestamp;
//   List<GoodsReceiptLot> lots;
//   int index;
//   RefillReceiptLotEvent(this.timestamp, this.lots, this.index);
//   @override
//   List<Object> get props => [timestamp];
// }
