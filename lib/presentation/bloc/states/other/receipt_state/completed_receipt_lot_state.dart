// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class CompletedReceiptLotState extends Equatable {}

class CompletedReceiptLotLoadingState extends CompletedReceiptLotState {
  DateTime timestamp;
  CompletedReceiptLotLoadingState(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsReceiptLotSuccessState extends CompletedReceiptLotState {
  GoodsReceipt goodsReceipt;
  DateTime timestamp;
  LoadGoodsReceiptLotSuccessState(this.goodsReceipt, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsReceiptLotFailState extends CompletedReceiptLotState {
  DateTime timestamp;
  LoadGoodsReceiptLotFailState(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

// class LoadShelfIdsSuccessState extends CompletedReceiptLotState {
//   List<String> shelfIds;
//   DateTime timestamp;
//   LoadShelfIdsSuccessState(this.shelfIds, this.timestamp);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
// }

// class UpdateReceiptLotSuccessState extends CompletedReceiptLotState {
//   ItemLot itemLot;
//   DateTime timestamp;
//   UpdateReceiptLotSuccessState(this.itemLot, this.timestamp);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
// }

// class UpdateReceiptLotFailState extends CompletedReceiptLotState {
//   DateTime timestamp;
//   UpdateReceiptLotFailState(this.timestamp);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
// }

// class ConfirmReceiptLotChangedSuccessState extends CompletedReceiptLotState {
//   ErrorPackage status;
//   DateTime timestamp;
//   ConfirmReceiptLotChangedSuccessState(this.status, this.timestamp);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
// }

// class ConfirmReceiptLotChangedFailState extends CompletedReceiptLotState {
//   ErrorPackage status;
//   DateTime timestamp;
//   ConfirmReceiptLotChangedFailState(this.status, this.timestamp);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
// }
