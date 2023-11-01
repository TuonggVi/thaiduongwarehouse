// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';


abstract class UncompletedReceiptLotState extends Equatable {

  GoodsReceipt? goodsReceipt;
  UncompletedReceiptLotState(this.goodsReceipt);

}

class LoadReceiptLotsLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  LoadReceiptLotsLoadingState(this.timestamp) : super(null);

  @override
  List<Object?> get props => throw UnimplementedError();
}
// class LoadReceiptLotsSuccessState extends UncompletedReceiptLotState {
//     //List<GoodsReceiptLot> goodReceiptLot;
//   GoodsReceipt goodsReceipt;
//   DateTime timestamp;
//   LoadReceiptLotsSuccessState(this.goodsReceipt, this.timestamp);

//   @override
//   List<Object?> get props => [goodsReceipt];
// }

// class LoadShelfIdsCuccessState extends UncompletedReceiptLotState {
//   List<String> shelfIds;
//   DateTime timestamp;
//   LoadShelfIdsCuccessState(this.shelfIds, this.timestamp);
//   @override
//   List<Object?> get props => [timestamp];
// }
//----------------------------
// load danh sách lô trong phiếu, cập nhật phiếu
class UpdateReceiptLotSuccessState extends UncompletedReceiptLotState {
  GoodsReceipt? goodsReceipt;

  DateTime timestamp;
  UpdateReceiptLotSuccessState(this.goodsReceipt, this.timestamp) : super(goodsReceipt);

  @override
  List<Object?> get props => [goodsReceipt];
}

class UpdateReceiptLotLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  UpdateReceiptLotLoadingState(this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class UpdateReceiptLotFailState extends UncompletedReceiptLotState {
  ErrorPackage status;
  DateTime timestamp;
  UpdateReceiptLotFailState(this.status, this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}
//--------------
// Post thông tin chỉnh sửa lên server
class PatchReceiptLotChangedSuccessState extends UncompletedReceiptLotState {
  ErrorPackage statusRequest;
  DateTime timestamp;

  PatchReceiptLotChangedSuccessState(this.statusRequest, this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class PatchReceiptLotChangedLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  PatchReceiptLotChangedLoadingState(this.timestamp) : super(null);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PatchReceiptLotChangedFailState extends UncompletedReceiptLotState {
  ErrorPackage status;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;  
  PatchReceiptLotChangedFailState(this.status, this.timestamp,  this.goodsReceipt) : super(goodsReceipt);

  @override
  List<Object?> get props => [timestamp];
}


// patch lô mới thêm lên server
class PostReceiptLotChangedSuccessState extends UncompletedReceiptLotState {
  ErrorPackage statusRequest;
  DateTime timestamp;
GoodsReceipt? goodsReceipt;
  PostReceiptLotChangedSuccessState(
      this.timestamp, this.statusRequest, this.goodsReceipt) : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class PostReceiptLotChangedLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  PostReceiptLotChangedLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

// thông báo lỗi và trả về đơn để chỉnh sửa
class PostReceiptLotChangedFailState extends UncompletedReceiptLotState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostReceiptLotChangedFailState(this.error, this.timestamp, this.goodsReceipt) : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

//--------
// thêm lô vào phiếu nhập chưa hoàn thành
// class AddNewLotToGoodsReceiptStateSuccess extends UncompletedReceiptLotState {
//   DateTime timestamp;
//   GoodsReceipt? goodsReceipt;
//   AddNewLotToGoodsReceiptStateSuccess(this.timestamp, this.goodsReceipt) : super(goodsReceipt);
//   @override
//   List<Object?> get props => [timestamp];
// }

// class AddNewLotToGoodsReceiptStateLoading extends UncompletedReceiptLotState {
//   DateTime timestamp;
//   AddNewLotToGoodsReceiptStateLoading(this.timestamp) : super(null);
//   @override
//   List<Object?> get props => [timestamp];
// }

// //----------
// class NewReceiptLoadingState extends UncompletedReceiptLotState {
//   DateTime timestamp;
//   NewReceiptLoadingState(this.timestamp) : super(null);
//   @override
//   List<Object?> get props => [timestamp];
// }


class RemoveReceiptLotSuccessState extends UncompletedReceiptLotState {
  int index;
  GoodsReceipt? goodsReceipt;
  DateTime timestamp;
  RemoveReceiptLotSuccessState(
      this.index, this.goodsReceipt, this.timestamp)
      : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class RemoveReceiptLotLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  RemoveReceiptLotLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
class RemoveReceiptLotFailState extends UncompletedReceiptLotState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  RemoveReceiptLotFailState(this.error, this.timestamp, this.goodsReceipt) : super(goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}