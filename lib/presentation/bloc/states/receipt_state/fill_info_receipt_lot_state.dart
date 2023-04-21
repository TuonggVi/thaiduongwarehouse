// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../domain/entities/goods_receipt.dart';
import '../../../../domain/entities/item.dart';

abstract class FillInfoReceiptLotState extends Equatable {}

class LoadItemDataSuccessState extends FillInfoReceiptLotState {
  List<Item> items;
   GoodsReceipt goodsReceipt;
  int index;
  bool function;
  DateTime timestamp;
  @override
  LoadItemDataSuccessState(
      this.items, this.goodsReceipt, this.index, this.function, this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

class LoadItemDataLoadingState extends FillInfoReceiptLotState {
  DateTime timestamp;
  LoadItemDataLoadingState(this.timestamp);

  @override

  List<Object?> get props => [timestamp];
}

class LoadItemDataFailState extends FillInfoReceiptLotState {
  DateTime timestamp;
  LoadItemDataFailState(this.timestamp);

  @override

  List<Object?> get props => [timestamp];
}