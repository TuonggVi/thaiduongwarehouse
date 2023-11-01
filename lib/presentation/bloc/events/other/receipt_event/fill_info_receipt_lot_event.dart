// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/other/goods_receipt.dart';

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
  FillReceiptLotEvent(this.timestamp, this.goodsReceipt, this.index);
  @override
  List<Object> get props => [timestamp];
}

