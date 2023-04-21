// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

abstract class GoodsIssueLotState extends Equatable {}

class LoadingGoodsIssueLotsState extends GoodsIssueLotState {
  DateTime timestamp;
  LoadingGoodsIssueLotsState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueLotsSuccessState extends GoodsIssueLotState {
  DateTime timestamp;
  List<ItemLot> lotsSuggest;
  List<GoodsIssueLot> lotsExpected;

  LoadGoodsIssueLotsSuccessState(
      this.timestamp, this.lotsSuggest, this.lotsExpected);
  @override

  List<Object?> get props => [timestamp];
}

class LoadGoodsIssueLotsFailState extends GoodsIssueLotState {
  DateTime timestamp;
  LoadGoodsIssueLotsFailState(this.timestamp);
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
  PostGoodsIssueLotsLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class PostIssueLotsSuccessState extends GoodsIssueLotState {
  DateTime timestamp;

  PostIssueLotsSuccessState(
    this.timestamp,
  );
  @override
 
  List<Object?> get props => [timestamp];
}

class PostGoodsIssueLotsFailState extends GoodsIssueLotState {
  DateTime timestamp;
  PostGoodsIssueLotsFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}