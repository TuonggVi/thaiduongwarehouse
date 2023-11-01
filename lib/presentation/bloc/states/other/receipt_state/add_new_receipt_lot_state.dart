// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../../domain/entities/other/goods_receipt.dart';
import '../../../../../../domain/entities/item.dart';
import '../../../../../domain/entities/error_package.dart';

abstract class FillInfoNewReceiptLotState extends Equatable {}

// lấy data
class CreateReceiptLotState extends Equatable {
  GoodsReceipt? goodsReceipt;
  CreateReceiptLotState(this.goodsReceipt);
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReceiptLotInitState extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  ReceiptLotInitState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class ReceiptLotLoadingState extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  ReceiptLotLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class LoadNewItemDataSuccessState extends FillInfoNewReceiptLotState {
  List<Item> items;
  List<Location> locations;
  GoodsReceipt goodsReceipt;

  int index;
  // bool function;
  DateTime timestamp;
  @override
  LoadNewItemDataSuccessState(this.items, this.locations, this.goodsReceipt,
      this.index, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class LoadNewItemDataLoadingState extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  LoadNewItemDataLoadingState(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class LoadNewItemDataFailState extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  LoadNewItemDataFailState(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class PostAddReceiptLotStateSuccess extends FillInfoNewReceiptLotState {
  ErrorPackage statusRequest;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostAddReceiptLotStateSuccess(
      this.timestamp, this.statusRequest, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class PostAddReceiptLotStateLoadingState extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  PostAddReceiptLotStateLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// thông báo lỗi và trả về đơn để chỉnh sửa
class PostAddReceiptLotStateFailure extends FillInfoNewReceiptLotState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostAddReceiptLotStateFailure(this.error, this.timestamp, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
} // cập nhật lô mới nhập và cập nhật thông tin lô vào phiếu nhập kho

class UpdateReceiptLotStateSuccess extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  //int index;
  UpdateReceiptLotStateSuccess(
    this.timestamp,
    this.goodsReceipt,
  );
  @override
  List<Object?> get props => [timestamp];
}

class UpdateReceiptLotStateLoading extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  UpdateReceiptLotStateLoading(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

//--------
// thêm lô vào phiếu nhập chưa hoàn thành
class AddNewLotToGoodsReceiptStateSuccess extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  AddNewLotToGoodsReceiptStateSuccess(this.timestamp, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class AddNewLotToGoodsReceiptStateLoading extends FillInfoNewReceiptLotState {
  DateTime timestamp;
  AddNewLotToGoodsReceiptStateLoading(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}
