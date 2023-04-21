// ignore_for_file: unused_import, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

abstract class UncompletedReceiptLotEvent extends Equatable {}

class LoadUncompletedReceiptLotEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt receipt;
  LoadUncompletedReceiptLotEvent(this.timestamp, this.receipt);
  @override
  
  List<Object?> get props => [timestamp];
}

class LoadShelfIdEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  LoadShelfIdEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// cập nhật view
class UpdateReceiptLotEvent extends UncompletedReceiptLotEvent {
 
  int index;
  GoodsReceiptLot itemLot;
  GoodsReceipt goodsReceipt;
  UpdateReceiptLotEvent(
     
      this.index,
      this.itemLot,
      this.goodsReceipt);
  @override
  List<Object> get props => [];
}

// post
class PostReceiptChangedEvent extends UncompletedReceiptLotEvent {
  DateTime timestamp;
  List<GoodsReceiptLot> itemLots;
  PostReceiptChangedEvent(this.timestamp, this.itemLots);
  @override
  List<Object> get props => [timestamp];
}