// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';

abstract class GoodsIssueLotState extends Equatable {
  GoodsIssueLot? goodsIssueLot;
  GoodsIssueLotState(this.goodsIssueLot);
}

class LoadingGoodsIssueLotsState extends GoodsIssueLotState {
  DateTime timestamp;
  LoadingGoodsIssueLotsState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueLotsSuccessState extends GoodsIssueLotState {
  DateTime timestamp;
  String goodsIssueId;
  String itemId;
  GoodsIssueLot?   goodsIssueLot;


  List<ItemLot> lotsSuggest;
  List<GoodsIssueLot> lotsExpected;
  List<ItemLotSublot> itemLotSublot;
  List<GoodsIssueSublot> goodsIssueSublots;
  // int index;
  LoadGoodsIssueLotsSuccessState(
      this.timestamp,
      this.goodsIssueId,
      this.itemId,
      this.goodsIssueLot,
      this.lotsSuggest,
      this.lotsExpected,
      this.itemLotSublot,
      this.goodsIssueSublots) : super(goodsIssueLot);
  @override
  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueLotsFailState extends GoodsIssueLotState {
  DateTime timestamp;
  
  LoadGoodsIssueLotsFailState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
//-----

// class AddGoodsIssueLotsLoadingState extends GoodsIssueLotState {
//   DateTime timestamp;
//   AddGoodsIssueLotsLoadingState(this.timestamp);
//   @override

//   List<Object?> get props => [timestamp];
// }

// class AddIssueLotsSuccessState extends GoodsIssueLotState {
//   DateTime timestamp;
//   ItemLot lots;
//   AddIssueLotsSuccessState(this.timestamp, this.lots);
//   @override

//   List<Object?> get props => [timestamp];
// }

// class AddIssueLotsFailState extends GoodsIssueLotState {
//   DateTime timestamp;
//   AddIssueLotsFailState(this.timestamp);
//   @override
//   List<Object?> get props => [timestamp];
// }

//---------

class PostGoodsIssueLotsLoadingState extends GoodsIssueLotState {
  DateTime timestamp;
  PostGoodsIssueLotsLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class PostIssueLotsSuccessState extends GoodsIssueLotState {
  DateTime timestamp;

  PostIssueLotsSuccessState(
    this.timestamp,


  ) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class PostGoodsIssueLotsFailState extends GoodsIssueLotState {
  DateTime timestamp;

  PostGoodsIssueLotsFailState(this.timestamp,
  ) : super(null);
  @override
  List<Object?> get props => [timestamp];
}
