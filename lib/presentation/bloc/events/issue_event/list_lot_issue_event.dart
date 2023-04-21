// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

abstract class GoodsIssueLotEvent extends Equatable {}

class LoadGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  String itemId;
  List<GoodsIssueLot> lotsExpected;
  LoadGoodsIssueLotEvent(this.timestamp, this.itemId,this.lotsExpected);
  @override
 
  List<Object?> get props => [timestamp];
}

class AddGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  // ItemLot goodsIssueLot;
  // do
  // String note;
  // String employeeId;
  GoodsIssueLot goodsIssueLot;
  List<ItemLot> listLotsSuggest;
  List<GoodsIssueLot> listLotExpected;
  AddGoodsIssueLotEvent(this.timestamp, this.goodsIssueLot,
      this.listLotsSuggest, this.listLotExpected);
  @override

  List<Object?> get props => [timestamp];
}

class PostGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  List<ItemLot> lots;
  PostGoodsIssueLotEvent(this.timestamp, this.lots);
  @override

  List<Object?> get props => [timestamp];
}
