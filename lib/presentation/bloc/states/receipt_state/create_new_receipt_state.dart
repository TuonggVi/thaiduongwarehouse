// ignore_for_file: must_be_immutable, unused_import

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

import '../../../../domain/entities/goods_receipt.dart';
import '../../../../domain/entities/item.dart';

class CreateReceiptState extends Equatable {
  @override

  List<Object?> get props => throw UnimplementedError();
}

class ReceiptInitState extends CreateReceiptState {
  DateTime timestamp;
  ReceiptInitState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
class ReceiptLoadingState extends CreateReceiptState {
  DateTime timestamp;
  ReceiptLoadingState(this.timestamp);
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
   GoodsReceipt goodsReceipt;
  AddLotToGoodsReceiptStateSuccess(this.timestamp, this.goodsReceipt);
  @override

  List<Object?> get props => [timestamp];
}

class AddLotToGoodsReceiptStateLoading extends CreateReceiptState {
  DateTime timestamp;
  AddLotToGoodsReceiptStateLoading(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

//----------------
class PostReceiptStateSuccess extends CreateReceiptState {
  ErrorPackage statusRequest;
  DateTime timestamp;
  PostReceiptStateSuccess(this.timestamp, this.statusRequest);
  @override

  List<Object?> get props => [timestamp];
}

class PostReceiptStateLoadingState extends CreateReceiptState {
  DateTime timestamp;
  PostReceiptStateLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class PostReceiptStateFailure extends CreateReceiptState {
  String error;
  DateTime timestamp;
  PostReceiptStateFailure(this.error, this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

//-------------------
class UpdateLotReceiptStateSuccess extends CreateReceiptState {
  DateTime timestamp;
   GoodsReceipt goodsReceipt;
  //int index;
  UpdateLotReceiptStateSuccess(this.timestamp, this.goodsReceipt, );
  @override

  List<Object?> get props => [timestamp];
}

class UpdateLotReceiptStateLoading extends CreateReceiptState {
  DateTime timestamp;
  UpdateLotReceiptStateLoading(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}