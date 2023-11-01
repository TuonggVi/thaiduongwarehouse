// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';

import '../../../../../../domain/entities/other/goods_receipt.dart';
import '../../../../../../domain/entities/item.dart';
import '../../../../../datasource/models/location_model.dart';

abstract class UpdateReceiptLotState extends Equatable {
  GoodsReceiptLot? goodsReceiptLot;

  UpdateReceiptLotState(this.goodsReceiptLot);
}

class ReceiptLotInitState extends UpdateReceiptLotState {
  DateTime timestamp;
  // GoodsReceiptLotModel goodsReceiptLot;
  // GoodsReceiptSublot sublot;
  ReceiptLotInitState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class LoadItemDataUpdateSuccessState extends UpdateReceiptLotState {
  List<Item> items;
  GoodsReceiptLot? goodsReceiptLot;

  GoodsReceipt goodsReceipt;
  DateTime timestamp;
  int index;
  @override
  LoadItemDataUpdateSuccessState(this.index, this.items, this.goodsReceipt, 
      this.goodsReceiptLot, this.timestamp)
      : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class LoadItemDataUpdateLoadingState extends UpdateReceiptLotState {
  DateTime timestamp;
  LoadItemDataUpdateLoadingState(this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class LoadItemDataUpdateFailState extends UpdateReceiptLotState {
  DateTime timestamp;
  LoadItemDataUpdateFailState(this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class AddGoodsReceiptSublotSuccessState extends UpdateReceiptLotState {
  int index;
  final GoodsReceipt goodsReceipt;

  final GoodsReceiptLot? goodsReceiptLot;
  List<Item> items;
  DateTime timestamp;
  @override
  AddGoodsReceiptSublotSuccessState(this.index, this.goodsReceipt, 
      this.goodsReceiptLot, this.items, this.timestamp)
      : super(null);
  @override
  List<Object?> get props => [];
}

class AddGoodsReceiptSublotLoadingState extends UpdateReceiptLotState {
  DateTime timestamp;
  GoodsReceiptLot? goodsReceiptLot;
  
  GoodsReceiptSublotModel goodsReceiptSublotModel;
  AddGoodsReceiptSublotLoadingState(
      this.timestamp, this.goodsReceiptLot, this.goodsReceiptSublotModel)
      : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class RemoveReceiptSublotSuccessState extends UpdateReceiptLotState {
  int index;
  GoodsReceipt goodsReceipt;
  GoodsReceiptLot? goodsReceiptLot;

  List<Item> items;
  DateTime timestamp;
  RemoveReceiptSublotSuccessState(this.index, this.goodsReceipt,
      this.goodsReceiptLot,  this.items, this.timestamp)
      : super(goodsReceiptLot);
  @override
  List<Object?> get props => [timestamp];
}

class RemoveReceiptSublotLoadingState extends UpdateReceiptLotState {
  DateTime timestamp;
  RemoveReceiptSublotLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}