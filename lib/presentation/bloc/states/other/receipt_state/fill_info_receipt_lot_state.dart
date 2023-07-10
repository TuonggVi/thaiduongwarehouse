// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../../domain/entities/other/goods_receipt.dart';
import '../../../../../../domain/entities/item.dart';

abstract class FillInfoReceiptLotState extends Equatable {}

class LoadItemDataSuccessState extends FillInfoReceiptLotState {
  List<Item> items;
  List<Location> locations;
  GoodsReceipt goodsReceipt;
  int index;
  // bool function;
  DateTime timestamp;
  @override
  LoadItemDataSuccessState(
      this.items,this.locations, this.goodsReceipt, this.index, this.timestamp);
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