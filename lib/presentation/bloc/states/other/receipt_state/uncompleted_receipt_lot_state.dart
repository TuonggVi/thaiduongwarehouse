// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

import '../../../../../datasource/models/other/goods_receipt_model.dart';

abstract class UncompletedReceiptLotState extends Equatable {}

class LoadReceiptLotsLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  LoadReceiptLotsLoadingState(this.timestamp);

  @override
  List<Object?> get props => throw UnimplementedError();
}

// class LoadShelfIdsCuccessState extends UncompletedReceiptLotState {
//   List<String> shelfIds;
//   DateTime timestamp;
//   LoadShelfIdsCuccessState(this.shelfIds, this.timestamp);
//   @override
//   List<Object?> get props => [timestamp];
// }
//----------------------------
class UpdateReceiptLotSuccessState extends UncompletedReceiptLotState {
  GoodsReceipt goodsReceipt;
  DateTime timestamp;
  UpdateReceiptLotSuccessState(this.goodsReceipt, this.timestamp);

  @override
  List<Object?> get props => [goodsReceipt];
}
class UpdateReceiptLotLoadingState extends UncompletedReceiptLotState {

  DateTime timestamp;
  UpdateReceiptLotLoadingState( this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}
//--------------
// cập nhật phiếu nhập kho đã chỉnh sửa lên server
class PatchReceiptLotChangedSuccessState extends UncompletedReceiptLotState {
  ErrorPackage statusRequest;
  DateTime timestamp;
 
  PatchReceiptLotChangedSuccessState(this.statusRequest, this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class PatchReceiptLotChangedLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  PatchReceiptLotChangedLoadingState(this.timestamp);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PatchReceiptLotChangedFailState extends UncompletedReceiptLotState {
  ErrorPackage status;
  DateTime timestamp;

  PatchReceiptLotChangedFailState(this.status, this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}
//-------- 
// thêm lô mới vào phiếu nhập
class AddNewLotToGoodsReceiptStateSuccess extends UncompletedReceiptLotState {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  AddNewLotToGoodsReceiptStateSuccess(this.timestamp, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class AddNewLotToGoodsReceiptStateLoading extends UncompletedReceiptLotState {
  DateTime timestamp;
  AddNewLotToGoodsReceiptStateLoading(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}
//----------
class NewReceiptLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  NewReceiptLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];}
// nhấn hoàn thành => post phiếu nhập kho lên server
class PostReceiptLotChangedSuccessState extends UncompletedReceiptLotState {
  ErrorPackage statusRequest;
  DateTime timestamp;
  GoodsReceiptModel? goodsReceipt;
  PostReceiptLotChangedSuccessState(this.timestamp, this.statusRequest,this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

class PostReceiptLotChangedLoadingState extends UncompletedReceiptLotState {
  DateTime timestamp;
  PostReceiptLotChangedLoadingState(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// thông báo lỗi và trả về đơn để chỉnh sửa
class PostReceiptLotChangedFailState extends UncompletedReceiptLotState {
  ErrorPackage error;
  DateTime timestamp;
  GoodsReceipt? goodsReceipt;
  PostReceiptLotChangedFailState(this.error, this.timestamp, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}
