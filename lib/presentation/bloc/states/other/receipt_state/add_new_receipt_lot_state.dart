// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../../../domain/entities/other/goods_receipt.dart';
import '../../../../../../domain/entities/item.dart';

abstract class FillInfoNewReceiptLotState extends Equatable {}
// lấy data 
class LoadNewItemDataSuccessState extends FillInfoNewReceiptLotState {
  List<Item> items;
  List<Location> locations;
  GoodsReceipt goodsReceipt;
  int index;
  // bool function;
  DateTime timestamp;
  @override
  LoadNewItemDataSuccessState(
      this.items,this.locations, this.goodsReceipt, this.index, this.timestamp);
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