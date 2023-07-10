import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';

abstract class GoodsIssueLotEvent extends Equatable {}

class LoadGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  String itemId;
  String goodsIssueId;
//  List<GoodsIssueLot> lotsExpected;
  LoadGoodsIssueLotEvent(this.timestamp, this.itemId, this.goodsIssueId);
  @override

  List<Object?> get props => [timestamp];
}

class AddGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  bool addFullLot;
  String itemId;
  String goodsIssueId;
  GoodsIssueLot goodsIssueLot;
  List<ItemLot> listLotsSuggest;
  
  List<GoodsIssueLot> listLotExported;
  AddGoodsIssueLotEvent(
      this.timestamp,
      this.addFullLot,
      this.itemId,
      this.goodsIssueId,
      this.goodsIssueLot,
      this.listLotsSuggest,
      this.listLotExported);
  @override
 
  List<Object?> get props => [timestamp];
}

class PostGoodsIssueLotEvent extends GoodsIssueLotEvent {
  DateTime timestamp;
  String itemId;

  String goodsIssueId;
  List<GoodsIssueLot> lots;
  PostGoodsIssueLotEvent(
      this.timestamp, this.itemId, this.goodsIssueId, this.lots);
  @override

  List<Object?> get props => [timestamp];
}