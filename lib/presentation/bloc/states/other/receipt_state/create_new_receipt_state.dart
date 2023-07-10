// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import '../../../../../../domain/entities/other/goods_receipt.dart';

class CreateReceiptState extends Equatable {
  GoodsReceipt? goodsReceipt;
  CreateReceiptState(this.goodsReceipt);
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReceiptInitState extends CreateReceiptState {
  DateTime timestamp;
  ReceiptInitState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class ReceiptLoadingState extends CreateReceiptState {
  DateTime timestamp;
  ReceiptLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
//-----------

// class LoadItemDataSuccessState extends CreateReceiptState {
//   List<Item> items;
//   List<ItemLotView> lots;
//   int index;
//   DateTime timestamp;
//   @override
//   LoadItemDataSuccessState(this.items, this.lots, this.index, this.timestamp);
//   List<Object?> get props => [timestamp];
// }

// class LoadItemDataLoadingState extends CreateReceiptState {
//   DateTime timestamp;
//   LoadItemDataLoadingState(this.timestamp);

//   @override
//   List<Object?> get props => [timestamp];
// }

// class LoadItemDataFailState extends CreateReceiptState {
//   DateTime timestamp;
//   LoadItemDataFailState(this.timestamp);

//   @override
//   List<Object?> get props => [timestamp];
// }

//--------
class AddLotToGoodsReceiptStateSuccess extends CreateReceiptState {
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  AddLotToGoodsReceiptStateSuccess(this.timestamp, this.goodsReceipt)
      : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class AddLotToGoodsReceiptStateLoading extends CreateReceiptState {
  DateTime timestamp;
  AddLotToGoodsReceiptStateLoading(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

//----------------
// nhấn hoàn thành => post phiếu nhập kho lên server
class PostReceiptStateSuccess extends CreateReceiptState {
  ErrorPackage statusRequest;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostReceiptStateSuccess(this.timestamp, this.statusRequest,this.goodsReceipt) : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class PostReceiptStateLoadingState extends CreateReceiptState {
  DateTime timestamp;
  PostReceiptStateLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
// thông báo lỗi và trả về đơn để chỉnh sửa
class PostReceiptStateFailure extends CreateReceiptState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostReceiptStateFailure(this.error, this.timestamp, this.goodsReceipt)
      : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

//-------------------
// cập nhật lô mới nhập và cập nhật thông tin lô vào phiếu nhập kho
class UpdateLotReceiptStateSuccess extends CreateReceiptState {
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  //int index;
  UpdateLotReceiptStateSuccess(
    this.timestamp,
    this.goodsReceipt,
  ) : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class UpdateLotReceiptStateLoading extends CreateReceiptState {
  DateTime timestamp;
  UpdateLotReceiptStateLoading(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}